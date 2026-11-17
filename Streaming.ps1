function Read-ChatEventStream {
    param([System.IO.TextReader]$Reader, [scriptblock]$OnChunk)
    $answer = New-Object System.Text.StringBuilder
    $finish = $null
    while ($null -ne ($line = $Reader.ReadLine())) {
        if (-not $line.StartsWith('data:')) { continue }
        $data = $line.Substring(5).Trim()
        if ($data -eq '[DONE]') { break }
        if (-not $data) { continue }
        $event = $data | ConvertFrom-Json
        if ($event.error) { throw ($event.error | ConvertTo-Json -Compress) }
        if ($event.choices.Count -gt 0) {
            $chunk = [string]$event.choices[0].delta.content
            if ($chunk.Length) { [void]$answer.Append($chunk); & $OnChunk $chunk }
            if ($event.choices[0].finish_reason) { $finish = $event.choices[0].finish_reason }
        }
    }
    if (-not $finish) { throw 'A valaszfolyam megszakadt. A megjelent reszlet nem teljes valasz.' }
    return @{content=$answer.ToString();finish_reason=$finish}
}

function Invoke-StreamingChat {
    param([string]$Url, [string]$Json)
    $request = [Net.HttpWebRequest]::Create($Url)
    $request.Method='POST'
    $request.ContentType='application/json; charset=utf-8'
    $request.Proxy=$null
    $request.Timeout=120000
    $request.ReadWriteTimeout=180000
    $bytes=[Text.Encoding]::UTF8.GetBytes($Json)
    $request.ContentLength=$bytes.Length
    $stream=$request.GetRequestStream()
    try { $stream.Write($bytes,0,$bytes.Length) } finally { $stream.Dispose() }
    $response=$null; $reader=$null
    try {
        $response=$request.GetResponse()
        $reader=New-Object IO.StreamReader($response.GetResponseStream(),[Text.Encoding]::UTF8)
        return Read-ChatEventStream -Reader $reader -OnChunk { param($chunk) Write-Host -NoNewline $chunk }
    } finally {
        if ($reader) { $reader.Dispose() }
        if ($response) { $response.Dispose() }
    }
}
