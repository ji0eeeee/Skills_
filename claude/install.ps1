# Claude Code 도구(Ponytail·Graphify·Headroom)와 skills 폴더의 스킬을 이 컴퓨터에 설치합니다.
# 이미 설치된 항목은 건너뜁니다. 사용법: powershell -ExecutionPolicy Bypass -File install.ps1 [-SkipTools] [-SkipSkills]
param([switch]$SkipTools, [switch]$SkipSkills)

$env:Path = "$env:USERPROFILE\.local\bin;$env:Path"
function Has($name) { [bool](Get-Command $name -ErrorAction SilentlyContinue) }

# claude가 PATH에 없으면 데스크톱 앱에 포함된 claude.exe 중 가장 최근 것을 사용합니다.
$claude = (Get-Command claude -ErrorAction SilentlyContinue).Source
if (-not $claude) {
    $claude = Get-ChildItem "$env:APPDATA\Claude\claude-code" -Recurse -Filter claude.exe -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName
}

if (-not $SkipTools) {
    if (-not $claude) { Write-Host "claude CLI가 없습니다. Claude 데스크톱 앱이나 Claude Code를 먼저 설치하세요."; exit 1 }

    if (Has uv) { Write-Host "[skip] $(uv --version)" }
    else {
        powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
        $env:Path = "$env:USERPROFILE\.local\bin;$env:Path"
    }

    if ((& $claude plugin list 2>$null) -match "ponytail@ponytail") { Write-Host "[skip] ponytail" }
    else {
        & $claude plugin marketplace add DietrichGebert/ponytail --scope user
        & $claude plugin install ponytail@ponytail --scope user
    }

    if ((& $claude plugin list 2>$null) -match "humanize-korean@im-not-ai") { Write-Host "[skip] humanize-korean" }
    else {
        & $claude plugin marketplace add epoko77-ai/im-not-ai --scope user
        & $claude plugin install humanize-korean@im-not-ai --scope user
    }

    if (Has graphify) { Write-Host "[skip] $(graphify --version)" }
    else { uv tool install graphifyy; graphify install }

    # Python 3.13 설치가 "Missing expected target directory" 오류로 멈추면 보안 프로그램이나
    # 샌드박스가 링크 생성을 막은 것입니다. 일반 PowerShell 창에서 다시 실행하세요.
    if (Has headroom) { Write-Host "[skip] $(headroom --version)" }
    else { uv tool install --python 3.13 "headroom-ai[proxy,mcp]" }
}

if (-not $SkipSkills) {
    $dest = "$env:USERPROFILE\.claude\skills"
    New-Item -ItemType Directory -Force $dest | Out-Null
    foreach ($dir in Get-ChildItem "$PSScriptRoot\skills" -Directory) {
        # ponytail*·humanize*는 위 플러그인이 에이전트와 함께 제공하므로 복사하지 않음
        if (-not $SkipTools -and $dir.Name -match '^(ponytail|humanize)') { continue }
        if (Test-Path "$dest\$($dir.Name)") { Write-Host "[skip] skill $($dir.Name)" }
        else { Copy-Item $dir.FullName "$dest\$($dir.Name)" -Recurse; Write-Host "[add]  skill $($dir.Name)" }
    }
}

Write-Host "== 확인"
if ($claude) { & $claude plugin list | Select-String -Context 0,3 "ponytail@ponytail" }
if (Has graphify) { graphify --version } else { Write-Host "graphify 없음" }
if (Has headroom) { headroom --version } else { Write-Host "headroom 없음" }
