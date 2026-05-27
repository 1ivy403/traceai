#!/usr/bin/env bash
# TraceAI — 一键创建仓库并推送（需已安装 gh 且 gh auth login）
set -euo pipefail
cd "$(dirname "$0")/.."

REPO_NAME="${1:-traceai}"
DESC="TraceAI — AI chats to traceable knowledge map"

if ! command -v gh >/dev/null 2>&1; then
  echo "请先安装 GitHub CLI: https://cli.github.com/"
  exit 1
fi

gh auth status || { echo "请先运行: gh auth login"; exit 1; }

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  git init -b main
fi

git add -A
git diff --cached --quiet && git diff --quiet || git commit -m "feat: TraceAI MVP — Claude JSON to knowledge map"

if ! gh repo view "$REPO_NAME" >/dev/null 2>&1; then
  gh repo create "$REPO_NAME" --public --description "$DESC" --source=. --remote=origin --push
else
  git remote remove origin 2>/dev/null || true
  gh repo set-default "$REPO_NAME" 2>/dev/null || true
  git remote add origin "https://github.com/$(gh api user -q .login)/${REPO_NAME}.git"
  git push -u origin main
fi

USER=$(gh api user -q .login)
echo ""
echo "完成。请在浏览器开启 Pages："
echo "  https://github.com/${USER}/${REPO_NAME}/settings/pages"
echo "  Source: main / root"
echo ""
echo "Demo: https://${USER}.github.io/${REPO_NAME}/"
