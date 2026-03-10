# =============================================================================
# Agent-Skills Setup Script (Windows PowerShell)
# =============================================================================

param(
    [Parameter(Position = 0)]
    [ValidateSet("antigravity", "copilot", "openclaw", "claude", "all", "help")]
    [string]$Tool = "help",

    [switch]$Project,

    [string]$ProjectPath = "."
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$GlobalPaths = @{
    antigravity = Join-Path $HOME ".gemini\skills"
    copilot     = Join-Path $HOME ".vscode\skills"
    openclaw    = Join-Path $HOME ".openclaw\skills"
    claude      = Join-Path $HOME ".claude\skills"
}

$ProjectPaths = @{
    antigravity = ".agents\workflows"
    copilot     = ".github\skills"
    openclaw    = "skills"
    claude      = ".claude\skills"
}

$ToolLabels = @{
    antigravity = "Antigravity / Gemini CLI"
    copilot     = "VS Code Copilot"
    openclaw    = "OpenClaw"
    claude      = "Claude Code"
}

function Show-Help {
    Write-Host ""
    Write-Host "Agent-Skills Setup Script" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usage:" -ForegroundColor Yellow
    Write-Host "  .\setup.ps1 TOOL [-Project [-ProjectPath PATH]]"
    Write-Host ""
    Write-Host "Tools:" -ForegroundColor Yellow
    Write-Host "  antigravity   Install to Antigravity / Gemini CLI  (~/.gemini/skills/)"
    Write-Host "  copilot       Install to VS Code Copilot           (~/.vscode/skills/)"
    Write-Host "  openclaw      Install to OpenClaw                   (~/.openclaw/skills/)"
    Write-Host "  claude        Install to Claude Code                (~/.claude/skills/)"
    Write-Host "  all           Install to all tools above"
    Write-Host ""
    Write-Host "Options:" -ForegroundColor Yellow
    Write-Host "  -Project              Install to project dir instead of global"
    Write-Host "  -ProjectPath PATH     Specify project dir (default: current dir)"
    Write-Host "                        antigravity: .agents/workflows/ (converted to workflow)"
    Write-Host "                        copilot:     .github/skills/"
    Write-Host "                        openclaw:    skills/"
    Write-Host "                        claude:      .claude/skills/"
    Write-Host ""
    Write-Host "Examples:" -ForegroundColor Yellow
    Write-Host "  .\setup.ps1 antigravity              # Global install to Antigravity"
    Write-Host "  .\setup.ps1 copilot -Project          # Project-level install"
    Write-Host "  .\setup.ps1 all                       # Global install to all tools"
    Write-Host "  .\setup.ps1 openclaw -Project -ProjectPath C:\myproject"
    Write-Host ""
}

function Get-SkillDirs {
    Get-ChildItem -Path $ScriptDir -Directory |
    Where-Object { $_.Name -ne ".git" } |
    Select-Object -ExpandProperty Name |
    Sort-Object
}

function Install-AsSkill {
    param([string]$SrcDir, [string]$DestDir, [string]$SkillName)

    $destSkillDir = Join-Path $DestDir $SkillName
    if (-not (Test-Path $destSkillDir)) {
        New-Item -ItemType Directory -Path $destSkillDir -Force | Out-Null
    }
    Copy-Item -Path (Join-Path $SrcDir "*") -Destination $destSkillDir -Recurse -Force
    Write-Host "  + $SkillName" -ForegroundColor Green
}

function Convert-ToWorkflow {
    param([string]$SrcDir, [string]$DestDir, [string]$SkillName)

    $srcFile = Join-Path $SrcDir "SKILL.md"
    $destFile = Join-Path $DestDir "$SkillName.md"

    if (-not (Test-Path $srcFile)) {
        Write-Host "  ! ${SkillName}: SKILL.md not found, skipping" -ForegroundColor Yellow
        return
    }

    if (-not (Test-Path $DestDir)) {
        New-Item -ItemType Directory -Path $DestDir -Force | Out-Null
    }

    $content = Get-Content -Path $srcFile -Raw -Encoding UTF8
    $description = ""
    $body = ""

    if ($content -match '(?s)^---\r?\n(.*?)\r?\n---\r?\n(.*)$') {
        $frontmatter = $Matches[1]
        $body = $Matches[2]

        if ($frontmatter -match '(?m)^description:\s*(.+)$') {
            $description = $Matches[1].Trim()
        }
    }

    $sep = "---"
    $lines = @($sep, "description: $description", $sep, "", $body)
    $workflowContent = $lines -join "`r`n"

    Set-Content -Path $destFile -Value $workflowContent -Encoding UTF8 -NoNewline
    Write-Host "  + $SkillName -> ${SkillName}.md" -ForegroundColor Green
}

function Install-ForTool {
    param(
        [string]$ToolName,
        [bool]$IsProject,
        [string]$ProjPath
    )

    $label = $ToolLabels[$ToolName]

    if ($IsProject) {
        $destDir = Join-Path $ProjPath $ProjectPaths[$ToolName]
        Write-Host ""
        Write-Host "[PROJECT] Installing to $label ($destDir)" -ForegroundColor Cyan
    }
    else {
        $destDir = $GlobalPaths[$ToolName]
        Write-Host ""
        Write-Host "[GLOBAL] Installing to $label ($destDir)" -ForegroundColor Cyan
    }

    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    $count = 0
    foreach ($skillName in (Get-SkillDirs)) {
        $srcDir = Join-Path $ScriptDir $skillName

        if ($ToolName -eq "antigravity" -and $IsProject) {
            Convert-ToWorkflow -SrcDir $srcDir -DestDir $destDir -SkillName $skillName
        }
        else {
            Install-AsSkill -SrcDir $srcDir -DestDir $destDir -SkillName $skillName
        }
        $count++
    }

    Write-Host ""
    Write-Host "Done! Installed $count skills to $label" -ForegroundColor Green
}

# Main

if ($Tool -eq "help") {
    Show-Help
    return
}

if ($Tool -eq "all") {
    foreach ($t in @("antigravity", "copilot", "openclaw", "claude")) {
        Install-ForTool -ToolName $t -IsProject $Project.IsPresent -ProjPath $ProjectPath
    }
}
else {
    Install-ForTool -ToolName $Tool -IsProject $Project.IsPresent -ProjPath $ProjectPath
}
