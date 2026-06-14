#!/usr/bin/env pwsh
# install.ps1 —— 在 Windows / PowerShell 上安装「三个臭皮匠」skill + slash 命令到你的 Claude Code 配置。
#
# 拷贝：
#   skills/cobblers  -> $ClaudeDir/skills/cobblers
#   commands/*.md    -> $ClaudeDir/commands/
# ClaudeDir 默认 ~/.claude（用环境变量 CLAUDE_CONFIG_DIR 覆盖）。
#
# 用法：
#   ./install.ps1
#   $env:CLAUDE_CONFIG_DIR = 'D:\path\to\.claude'; ./install.ps1   # 自定义安装位置

$ErrorActionPreference = 'Stop'

$Here = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ClaudeDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }

$SkillsDir   = Join-Path $ClaudeDir 'skills'
$CommandsDir = Join-Path $ClaudeDir 'commands'
New-Item -ItemType Directory -Force -Path $SkillsDir, $CommandsDir | Out-Null

$SkillDest = Join-Path $SkillsDir 'cobblers'
if (Test-Path $SkillDest) { Remove-Item -Recurse -Force $SkillDest }
Copy-Item -Recurse -Path (Join-Path $Here 'skills/cobblers') -Destination $SkillDest
Copy-Item -Path (Join-Path $Here 'commands/*.md') -Destination $CommandsDir

Write-Host "✓ 已安装「三个臭皮匠」到 $ClaudeDir"
Write-Host "    skill    : $SkillDest"
Write-Host "    commands : /cobblers  /cobblers-quick"
Write-Host ""
Write-Host "前提：会话模型为 Opus 4.8（臭皮匠子代理与诸葛亮裁判都继承会话模型）。"
Write-Host "零外部依赖——只用 Opus 子代理，无需任何外部 CLI。"
Write-Host ""
Write-Host "下一步：重启 Claude Code 或运行 /reload-skills 加载。"
