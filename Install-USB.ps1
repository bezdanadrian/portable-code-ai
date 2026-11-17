param([string]$Destination, [switch]$Include7B)
$ErrorActionPreference='Stop'
if ([string]::IsNullOrWhiteSpace($Destination)) { throw 'Add meg a celmappat: -Destination E:\Portable-Code-AI' }
$Destination=[IO.Path]::GetFullPath($Destination)
if ($Destination.TrimEnd('\') -eq [IO.Path]::GetPathRoot($Destination).TrimEnd('\')) { throw 'Meghajto gyokere helyett kulon celmappat adj meg.' }
[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12
New-Item -ItemType Directory -Force -Path $Destination,"$Destination\models","$Destination\runtime","$Destination\licenses","$Destination\projects" | Out-Null
foreach ($f in @('START.bat','Chat.ps1','Streaming.ps1','README.md','README-HU.txt','NOTICE.txt','school-profile.txt','TANANYAG.md','benchmark-prompt.txt')) { Copy-Item -LiteralPath (Join-Path $PSScriptRoot $f) -Destination $Destination }
$zip="$Destination\runtime\llama-b11476.zip"
& curl.exe -L --fail --retry 5 -C - -o $zip 'https://github.com/ggml-org/llama.cpp/releases/download/b11476/llama-b11476-bin-win-cpu-x64.zip'
if ($LASTEXITCODE) { throw 'Runtime letoltes sikertelen' }
Expand-Archive -LiteralPath $zip -DestinationPath "$Destination\runtime" -Force
$sizes=@('3'); if ($Include7B) { $sizes += '7' }
foreach ($size in $sizes) {
    $quant='q5_k_m'; if ($size -eq '7') { $quant='q4_k_m' }
    $repo="Qwen/Qwen2.5-Coder-${size}B-Instruct-GGUF"
    $name="qwen2.5-coder-${size}b-instruct-$quant.gguf"
    $meta=Invoke-RestMethod "https://huggingface.co/api/models/${repo}?blobs=true"
    $entry=$meta.siblings | Where-Object rfilename -eq $name
    $target="$Destination\models\$name"
    if (-not (Test-Path $target)) {
        & curl.exe -L --fail --retry 5 -C - -o "$target.part" "https://huggingface.co/$repo/resolve/main/$name"
        if ($LASTEXITCODE) { throw "Modell letoltes sikertelen: $name" }
        if ((Get-FileHash -LiteralPath "$target.part" -Algorithm SHA256).Hash.ToLower() -ne $entry.lfs.sha256) { throw 'SHA256 elteres!' }
        Move-Item -LiteralPath "$target.part" -Destination $target
    } elseif ((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash.ToLower() -ne $entry.lfs.sha256) { throw 'Meglevo modell SHA256 elteres!' }
    Invoke-WebRequest "https://huggingface.co/$repo/resolve/main/LICENSE" -OutFile "$Destination\licenses\Qwen-${size}B-LICENSE.txt" -UseBasicParsing
    Write-Host "ELLENORIZVE: $name"
}
Invoke-WebRequest 'https://raw.githubusercontent.com/ggml-org/llama.cpp/b11476/LICENSE' -OutFile "$Destination\licenses\llama-cpp-LICENSE.txt" -UseBasicParsing
Write-Host "KESZ: $Destination\START.bat"
