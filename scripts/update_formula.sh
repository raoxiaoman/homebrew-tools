#!/bin/bash
#
# 自动更新 Formula 的版本与 SHA256
# 支持：
#   - 自动计算 tar.gz 的 sha256
#   - 自动更新 Formula 文件中的 url/sha256/version
#   - 自动 commit + push (可选)
#
# 用法:
#   ./scripts/update_formula.sh <formula_name> <version> <repo> [--push]
#
# 示例:
#   ./scripts/update_formula.sh cleanold 1.0.1 raoxiaoman/cleanold --push
# ---------------------------------------------------------------

set -e

if [ $# -lt 3 ]; then
  echo "用法: $0 <formula_name> <version> <repo> [--push]"
  echo "示例: $0 cleanold 1.0.1 raoxiaoman/cleanold --push"
  exit 1
fi

FORMULA_NAME="$1"
VERSION="$2"
REPO="$3"
PUSH=false

if [[ "$4" == "--push" ]]; then
  PUSH=true
fi

FORMULA_PATH="Formula/${FORMULA_NAME}.rb"
TAG="v${VERSION}"
TAR_URL="https://github.com/${REPO}/archive/refs/tags/${TAG}.tar.gz"

echo "🧾 Formula: $FORMULA_PATH"
echo "📦 Repo:    $REPO"
echo "🏷️  Version: $VERSION"
echo "🌐 URL:     $TAR_URL"
echo "------------------------------------------"

# 检查 formula 是否存在
if [ ! -f "$FORMULA_PATH" ]; then
  echo "❌ 找不到 Formula 文件: $FORMULA_PATH"
  exit 1
fi

# 清理旧缓存
CACHE_PATH="$HOME/Library/Caches/Homebrew/downloads"
echo "🧹 清理旧缓存..."
rm -f "$CACHE_PATH"/*${FORMULA_NAME}* 2>/dev/null || true

# 下载 tar.gz 并计算 SHA256
TMPFILE=$(mktemp)
echo "⬇️  下载 tar.gz ..."
curl -L --header "Accept: application/octet-stream" -o "$TMPFILE" "$TAR_URL"

SHA256=$(shasum -a 256 "$TMPFILE" | awk '{print $1}')
rm -f "$TMPFILE"

echo "✅ SHA256: $SHA256"
echo "------------------------------------------"

# 更新 Formula 文件（Mac 兼容 sed）
echo "🛠️  更新 Formula..."
sed -i '' "s|url \".*\"|url \"${TAR_URL}\"|" "$FORMULA_PATH"
sed -i '' "s|sha256 \".*\"|sha256 \"${SHA256}\"|" "$FORMULA_PATH"

# 尝试更新版本号（如果 Formula 里有 version 字段）
if grep -q "version " "$FORMULA_PATH"; then
  sed -i '' "s|version \".*\"|version \"${VERSION}\"|" "$FORMULA_PATH"
fi

echo "✅ Formula 已更新。"
echo "🔖 版本: ${VERSION}"
echo "🔑 SHA : ${SHA256}"
echo "------------------------------------------"

if $PUSH; then
  echo "🚀 提交并推送 Formula 更新..."
  git add "$FORMULA_PATH"
  git commit -m "update ${FORMULA_NAME} v${VERSION}"
  git push
  echo "✅ 已推送到远程。"
else
  echo "💡 已更新本地 Formula 文件，如需提交请手动执行："
  echo "   git add $FORMULA_PATH && git commit -m 'update ${FORMULA_NAME} v${VERSION}' && git push"
fi
