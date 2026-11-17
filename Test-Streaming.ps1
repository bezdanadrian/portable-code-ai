$ErrorActionPreference='Stop'
. (Join-Path $PSScriptRoot 'Streaming.ps1')
$events=@(
    ': keepalive',
    'data: {"choices":[{"delta":{"role":"assistant"},"finish_reason":null}]}',
    '',
    'data: {"choices":[{"delta":{"content":"els\u0151 "},"finish_reason":null}]}',
    '',
    'data: {"choices":[{"delta":{"content":"sor\nmasodik"},"finish_reason":null}]}',
    'data: {"choices":[{"delta":{},"finish_reason":"stop"}]}',
    'data: [DONE]'
) -join "`n"
$reader=New-Object IO.StringReader($events)
try { $result=Read-ChatEventStream -Reader $reader -OnChunk { param($chunk) } }
finally { $reader.Dispose() }
$expected='els' + [char]0x151 + " sor`nmasodik"
if ($result.content -ne $expected -or $result.finish_reason -ne 'stop') { throw 'Streaming assembly failed' }
$reader=New-Object IO.StringReader('data: {"choices":[{"delta":{"content":"partial"},"finish_reason":null}]}')
$rejected=$false
try { $null=Read-ChatEventStream -Reader $reader -OnChunk { param($chunk) } }
catch { $rejected=$true }
finally { $reader.Dispose() }
if (-not $rejected) { throw 'Truncated stream must be rejected' }
$reader=New-Object IO.StringReader('data: {"error":{"message":"failure"}}')
$rejected=$false
try { $null=Read-ChatEventStream -Reader $reader -OnChunk { param($chunk) } }
catch { $rejected=$true }
finally { $reader.Dispose() }
if (-not $rejected) { throw 'Server error must be rejected' }
Write-Host 'PASS: chunks, Unicode, newlines, completion, truncation, server error'
