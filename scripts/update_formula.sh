#!/bin/bash
#
# 自动更新 Formula 的版本与 SHA256
# 用法: ./scripts/update_formula.sh cleanold 1.0.1
# ----------------------------------------------------

set -e

if [ $# -lt 2 ]; then
  echo "用法: $0 <formula_name> <version>"
  echo "示例: $0 cleanold 1.0.1"
  exit 1
fi

FORMULA_NAME="$1"
VERSION="$2"
REPO="raoxiaoman/homebrew-tools"
FORMULA_PATH="Formula/${FORMULA_NAME}.rb"
TAG="v${VERSION}"
TAR_URL="https://github.com/${REPO}/archive/refs/tags/${TAG}.tar.gz"

echo "🔍 正在计算新版本 ${FORMULA_NAME} (${VERSION}) 的 SHA256..."

# 下载 tar.gz 并计算 sha256
TMPFILE=$(mktemp)
curl -L -s -o "$TMPFILE" "$TAR_URL"
SHA256=$(shasum -a 256 "$TMPFILE" | awk '{print $1}')
rm -f "$TMPFILE"

echo "✅ SHA256: $SHA256"

# 检查 Formula 是否存在
if [ ! -f "$FORMULA_PATH" ]; then
  echo "❌ 找不到 Formula: $FORMULA_PATH"
  exit 1
fi

# 更新 Formula 文件
echo "🛠 正在更新 Formula: $FORMULA_PATH"

# 替换版本与 sha256
sed -i '' "s|url \".*\"|url \"${TAR_URL}\"|" "$FORMULA_PATH"
sed -i '' "s|sha256 \".*\"|sha256 \"${SHA256}\"|" "$FORMULA_PATH"

echo "✅ Formula 已更新。"
echo "🔖 版本: ${VERSION}"
echo "📦 URL : ${TAR_URL}"
echo "🔑 SHA : ${SHA256}"
