#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if ! command -v xcodebuild >/dev/null 2>&1; then
  echo "ERROR: xcodebuild is required. Run this script on macOS with Xcode 26 or newer." >&2
  exit 2
fi

if ! command -v xcodegen >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    brew install xcodegen
  else
    echo "ERROR: xcodegen is required. Install it with: brew install xcodegen" >&2
    exit 3
  fi
fi

rm -rf build dist PhaseZero.xcodeproj
mkdir -p build dist

xcodegen generate --spec project.yml

set -o pipefail
xcodebuild \
  -project PhaseZero.xcodeproj \
  -scheme PhaseZero \
  -configuration Release \
  -sdk iphoneos \
  -destination 'generic/platform=iOS' \
  -derivedDataPath "$ROOT/build/DerivedData" \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY='' \
  DEVELOPMENT_TEAM='' \
  clean build | tee "$ROOT/build/xcodebuild.log"

APP_PATH="$(find "$ROOT/build/DerivedData/Build/Products/Release-iphoneos" -maxdepth 1 -type d -name '*.app' -print -quit)"
if [[ -z "$APP_PATH" || ! -d "$APP_PATH" ]]; then
  echo "ERROR: Xcode completed without producing an .app bundle." >&2
  exit 4
fi

EXECUTABLE_NAME="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleExecutable' "$APP_PATH/Info.plist")"
if [[ ! -f "$APP_PATH/$EXECUTABLE_NAME" ]]; then
  echo "ERROR: App executable is missing: $APP_PATH/$EXECUTABLE_NAME" >&2
  exit 5
fi

rm -rf "$ROOT/build/ipa"
mkdir -p "$ROOT/build/ipa/Payload"
ditto "$APP_PATH" "$ROOT/build/ipa/Payload/$(basename "$APP_PATH")"
xattr -cr "$ROOT/build/ipa/Payload" || true

IPA_NAME="PhaseZero-5.2.0-build9-unsigned.ipa"
(
  cd "$ROOT/build/ipa"
  /usr/bin/zip -qry "$ROOT/dist/$IPA_NAME" Payload
)

/usr/bin/unzip -t "$ROOT/dist/$IPA_NAME"
echo ""
echo "Created: $ROOT/dist/$IPA_NAME"
echo "This IPA is intentionally unsigned so AltServer/AltStore can sign it with your Apple account."
