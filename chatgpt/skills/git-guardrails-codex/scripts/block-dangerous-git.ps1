$ErrorActionPreference = 'Stop'

$inputText = [Console]::In.ReadToEnd()
$payload = $inputText | ConvertFrom-Json
$command = [string]$payload.tool_input.command

$dangerousPatterns = @(
    '(?i)(^|[;&|]\s*)git\s+push(?:\s|$)',
    '(?i)git\s+reset\s+--hard(?:\s|$)',
    '(?i)git\s+clean\s+[^\r\n;&|]*-[^\s]*f',
    '(?i)git\s+branch\s+-D(?:\s|$)',
    '(?i)git\s+checkout\s+(?:--\s+)?\.(?:\s|$)',
    '(?i)git\s+restore\s+(?:--[^\s]+\s+)*\.(?:\s|$)'
)

foreach ($pattern in $dangerousPatterns) {
    if ($command -match $pattern) {
        [Console]::Error.WriteLine("BLOCKED: command matches the configured destructive Git pattern: $command")
        exit 2
    }
}

exit 0
