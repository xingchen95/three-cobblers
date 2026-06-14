#!/usr/bin/env bash
# install.sh —— 安装「三个臭皮匠」skill + slash 命令到你的 Claude Code 配置。
#
# 拷贝：
#   skills/cobblers  -> $CLAUDE_DIR/skills/cobblers
#   commands/*.md    -> $CLAUDE_DIR/commands/
# CLAUDE_DIR 默认 ~/.claude（用 CLAUDE_CONFIG_DIR 覆盖）。

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

mkdir -p "$CLAUDE_DIR/skills" "$CLAUDE_DIR/commands"

rm -rf "$CLAUDE_DIR/skills/cobblers"
cp -R "$HERE/skills/cobblers" "$CLAUDE_DIR/skills/cobblers"
cp "$HERE/commands/"*.md "$CLAUDE_DIR/commands/"

echo "✓ 已安装「三个臭皮匠」到 $CLAUDE_DIR"
echo "    skill    : $CLAUDE_DIR/skills/cobblers"
echo "    commands : /cobblers  /cobblers-quick"
echo
echo "前提：会话模型为 Opus 4.8（臭皮匠子代理与诸葛亮裁判都继承会话模型）。"
echo "零外部依赖——只用 Opus 子代理，无需任何外部 CLI。"
echo
echo "下一步：重启 Claude Code 或运行 /reload-skills 加载。"
