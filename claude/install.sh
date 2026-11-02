#!/usr/bin/env sh
# Claude Code 도구(Ponytail·Graphify·Headroom)와 skills 폴더의 스킬을 이 컴퓨터에 설치합니다.
# 이미 설치된 항목은 건너뜁니다. 사용법: sh install.sh [--skip-tools] [--skip-skills]
set -u

HERE=$(cd "$(dirname "$0")" && pwd)
SKIP_TOOLS=0
SKIP_SKILLS=0
for arg in "$@"; do
  case "$arg" in
    --skip-tools) SKIP_TOOLS=1 ;;
    --skip-skills) SKIP_SKILLS=1 ;;
    *) echo "알 수 없는 옵션: $arg"; exit 2 ;;
  esac
done

export PATH="$HOME/.local/bin:$PATH"
has() { command -v "$1" >/dev/null 2>&1; }

if [ "$SKIP_TOOLS" -eq 0 ]; then
  has claude || { echo "claude CLI가 없습니다. https://claude.com/claude-code 에서 먼저 설치하세요."; exit 1; }

  if has uv; then echo "[skip] uv $(uv --version)"
  else curl -LsSf https://astral.sh/uv/install.sh | sh; fi

  if claude plugin list 2>/dev/null | grep -q "ponytail@ponytail"; then echo "[skip] ponytail"
  else
    claude plugin marketplace add DietrichGebert/ponytail --scope user
    claude plugin install ponytail@ponytail --scope user
  fi

  if claude plugin list 2>/dev/null | grep -q "humanize-korean@im-not-ai"; then echo "[skip] humanize-korean"
  else
    claude plugin marketplace add epoko77-ai/im-not-ai --scope user
    claude plugin install humanize-korean@im-not-ai --scope user
  fi

  if has graphify; then echo "[skip] $(graphify --version)"
  else uv tool install graphifyy && graphify install; fi

  if has headroom; then echo "[skip] $(headroom --version)"
  else uv tool install --python 3.13 "headroom-ai[proxy,mcp]"; fi
fi

if [ "$SKIP_SKILLS" -eq 0 ]; then
  DEST="$HOME/.claude/skills"
  mkdir -p "$DEST"
  for dir in "$HERE"/skills/*/; do
    name=$(basename "$dir")
    # ponytail*·humanize*는 위 플러그인이 에이전트와 함께 제공하므로 복사하지 않음
    case "$name" in ponytail*|humanize*) [ "$SKIP_TOOLS" -eq 0 ] && continue ;; esac
    if [ -e "$DEST/$name" ]; then echo "[skip] skill $name"
    else cp -R "$dir" "$DEST/$name" && echo "[add]  skill $name"; fi
  done
fi

echo "== 확인"
claude plugin list 2>/dev/null | grep -A3 "ponytail@ponytail" || echo "ponytail 없음"
graphify --version 2>/dev/null || echo "graphify 없음"
headroom --version 2>/dev/null || echo "headroom 없음"
