#!/bin/bash
# 自动更新 Formula 的 URL 和 sha256

if [ $# -ne 3 ]; then
  echo "用法: $0 <formula_name> <version> <github_repo>"
  echo "示例: $0 cleanold 1.1.0 raoxiaoman/cleanold"
  exit 1
fi

FORMULA_NAME=$1
VERSION=$2
REPO=$3
FORMULA_PATH="Formula/${FORMULA_NAME}.rb"

URL="https://github.com/${REPO}/archive/refs/tags/v${VERSION}.tar.gz"
TMP_FILE="/tmp/${FORMULA_NAME}-${VERSION}.tar.gz"

echo "📦 下载新版本: $URL"
curl -L -o "$TMP_FILE" "$URL"

SHA=$(shasum -a 256 "$TMP_FILE" | awk '{print $1}')
echo "✅ 新 SHA256: $SHA"

echo "📝 更新 Formula..."
sed -i '' "s|url \".*\"|url \"${URL}\"|" "$FORMULA_PATH"
sed -i '' "s|sha256 \".*\"|sha256 \"${SHA}\"|" "$FORMULA_PATH"

echo "🎉 更新完成: $FORMULA_PATH"
