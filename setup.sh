#!/usr/bin/env bash
# =============================================================================
# Agent-Skills Setup Script (macOS / Linux)
# 从本仓库安装 skills 到目标 AI 工具的全局或项目路径
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RED="\033[31m"
RESET="\033[0m"

# ─── 目标工具及其路径定义 ─────────────────────────────────────────────────────
declare -A GLOBAL_PATHS=(
  [antigravity]="$HOME/.gemini/skills"
  [copilot]="$HOME/.vscode/skills"
  [openclaw]="$HOME/.openclaw/skills"
  [claude]="$HOME/.claude/skills"
)

declare -A PROJECT_PATHS=(
  [antigravity]=".agents/workflows"
  [copilot]=".github/skills"
  [openclaw]="skills"
  [claude]=".claude/skills"
)

declare -A TOOL_LABELS=(
  [antigravity]="Antigravity / Gemini CLI"
  [copilot]="VS Code Copilot"
  [openclaw]="OpenClaw"
  [claude]="Claude Code"
)

# ─── 函数 ────────────────────────────────────────────────────────────────────

show_help() {
  cat <<EOF
${BOLD}Agent-Skills 安装脚本${RESET}

${CYAN}用法:${RESET}
  ./setup.sh <tool> [--project [path]]

${CYAN}目标工具 (tool):${RESET}
  antigravity   安装到 Antigravity / Gemini CLI  (~/.gemini/skills/)
  copilot       安装到 VS Code Copilot           (~/.vscode/skills/)
  openclaw      安装到 OpenClaw                   (~/.openclaw/skills/)
  claude        安装到 Claude Code                (~/.claude/skills/)
  all           安装到以上所有工具

${CYAN}选项:${RESET}
  --project [path]  安装到项目目录 (默认当前目录) 而非全局路径
                    antigravity: .agents/workflows/ (转为 workflow 格式)
                    copilot:     .github/skills/
                    openclaw:    skills/
                    claude:      .claude/skills/

${CYAN}示例:${RESET}
  ./setup.sh antigravity              # 全局安装到 Antigravity
  ./setup.sh copilot --project        # 项目级安装到当前目录
  ./setup.sh all                      # 全局安装到所有工具
  ./setup.sh openclaw --project /path # 安装到指定项目目录

EOF
  exit 0
}

get_skill_dirs() {
  # 返回仓库中所有 skill 目录名
  find "$SCRIPT_DIR" -maxdepth 1 -mindepth 1 -type d ! -name ".git" -exec basename {} \; | sort
}

install_as_skill() {
  local src_dir="$1"
  local dest_dir="$2"
  local skill_name
  skill_name="$(basename "$src_dir")"

  mkdir -p "$dest_dir/$skill_name"
  cp -r "$src_dir"/* "$dest_dir/$skill_name/" 2>/dev/null || true
  echo -e "  ${GREEN}✓${RESET} $skill_name"
}

convert_to_workflow() {
  local src_dir="$1"
  local dest_dir="$2"
  local skill_name
  skill_name="$(basename "$src_dir")"
  local src_file="$src_dir/SKILL.md"
  local dest_file="$dest_dir/${skill_name}.md"

  if [[ ! -f "$src_file" ]]; then
    echo -e "  ${YELLOW}⚠${RESET} $skill_name: SKILL.md not found, skipping"
    return
  fi

  mkdir -p "$dest_dir"

  # 提取 description 从 YAML frontmatter
  local description
  description=$(awk '/^---$/{n++; next} n==1 && /^description:/{sub(/^description: */, ""); print}' "$src_file")

  # 提取 markdown 正文 (跳过 frontmatter)
  local body
  body=$(awk 'BEGIN{n=0} /^---$/{n++; next} n>=2{print}' "$src_file")

  # 写入 workflow 格式
  {
    echo "---"
    echo "description: $description"
    echo "---"
    echo ""
    echo "$body"
  } > "$dest_file"

  echo -e "  ${GREEN}✓${RESET} $skill_name → ${skill_name}.md"
}

install_for_tool() {
  local tool="$1"
  local is_project="${2:-false}"
  local project_path="${3:-.}"

  local label="${TOOL_LABELS[$tool]}"
  local dest_dir

  if [[ "$is_project" == "true" ]]; then
    dest_dir="$project_path/${PROJECT_PATHS[$tool]}"
    echo -e "\n${BOLD}📦 安装到 ${label} (项目级: $dest_dir)${RESET}"
  else
    dest_dir="${GLOBAL_PATHS[$tool]}"
    echo -e "\n${BOLD}🌍 安装到 ${label} (全局: $dest_dir)${RESET}"
  fi

  local count=0
  while IFS= read -r skill_name; do
    local src_dir="$SCRIPT_DIR/$skill_name"

    if [[ "$tool" == "antigravity" && "$is_project" == "true" ]]; then
      # Antigravity 项目级需要转换为 workflow 格式
      convert_to_workflow "$src_dir" "$dest_dir"
    else
      # 其他情况直接复制 SKILL.md
      install_as_skill "$src_dir" "$dest_dir"
    fi
    count=$((count + 1))
  done < <(get_skill_dirs)

  echo -e "${GREEN}${BOLD}✅ 完成! 共安装 $count 个 skills 到 $label${RESET}"
}

# ─── 主逻辑 ──────────────────────────────────────────────────────────────────

[[ $# -eq 0 ]] && show_help
[[ "$1" == "-h" || "$1" == "--help" ]] && show_help

TOOL="$1"
IS_PROJECT="false"
PROJECT_PATH="."

shift
while [[ $# -gt 0 ]]; do
  case "$1" in
    --project)
      IS_PROJECT="true"
      if [[ $# -gt 1 && ! "$2" =~ ^-- ]]; then
        PROJECT_PATH="$2"
        shift
      fi
      ;;
    *)
      echo -e "${RED}未知参数: $1${RESET}"
      show_help
      ;;
  esac
  shift
done

if [[ "$TOOL" == "all" ]]; then
  for t in antigravity copilot openclaw claude; do
    install_for_tool "$t" "$IS_PROJECT" "$PROJECT_PATH"
  done
else
  if [[ -z "${TOOL_LABELS[$TOOL]+x}" ]]; then
    echo -e "${RED}未知工具: $TOOL${RESET}"
    echo "可选: antigravity, copilot, openclaw, claude, all"
    exit 1
  fi
  install_for_tool "$TOOL" "$IS_PROJECT" "$PROJECT_PATH"
fi
