#!/bin/bash

python3 scripts/assets/compile_illustrations.py --check || exit $?

# 自动从 git tag 检测版本号
VERSION=$(git describe --tags --abbrev=0 2>/dev/null | sed 's/^v//')
if [ -n "$VERSION" ]; then
  echo "📦 检测到版本号: $VERSION"
  export CURRENT_PROJECT_VERSION=$VERSION
else
  echo "⚠️  未找到 git tag，使用默认版本号"
fi

xcodebuild \
  -project alt-tab-macos.xcodeproj \
  -scheme Debug \
  -configuration Debug \
  -derivedDataPath DerivedData \
  CURRENT_PROJECT_VERSION=$VERSION
