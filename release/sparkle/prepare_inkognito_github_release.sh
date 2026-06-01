#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  bash release/sparkle/prepare_inkognito_github_release.sh \
    --github-repo Dok100/Inkognito \
    --tag v0.3.0 \
    --dmg-path output/release/dmg/Inkognito-0.3.0.dmg \
    --highlight "Review-Workflow weiter geschaerft" \
    --highlight "Dokumentklassen robuster erkannt" \
    --highlight "Eigene Regeln produktnaeher gemacht" \
    --user-facing-note "Automatische Treffer lassen sich jetzt klarer pruefen." \
    --migration-note "Bestehende Installationen koennen bei alten Vorabstaenden eine bewusste Neuinstallation brauchen." \
    --output-dir output/release/github-release

This helper prepares the first real Inkognito Sparkle release artifacts for a GitHub Release:
1. derive the public GitHub Release DMG URL
2. render HTML release notes from the Inkognito template
3. derive the Sparkle edSignature from the final DMG, unless it is passed in
4. render a concrete appcast XML file

Required:
  --github-repo       GitHub repository in owner/name form
  --tag               GitHub release tag, for example v0.3.0
  --dmg-path          Local path to the final notarized DMG
  --highlight         One release highlight. Repeat exactly 3 times.
  --user-facing-note  User-facing note shown below the highlights
  --migration-note    Update or migration hint for existing users
  --output-dir        Directory for rendered files

Optional:
  --version           Sparkle internal version. Defaults to CURRENT_PROJECT_VERSION.
  --short-version     Human-readable version. Defaults to MARKETING_VERSION.
  --asset-name        Release asset file name. Defaults to the DMG file name.
  --ed-signature      Precomputed Sparkle edSignature. If omitted, sign_update is used.
  --pub-date          RFC822 publication date. Defaults to current UTC time.
  --notes-path        Override the rendered release notes output path.
  --appcast-path      Override the rendered appcast output path.
  --sign-update-path  Explicit path to Sparkle's sign_update helper.
USAGE
}

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
PROJECT_FILE="$ROOT_DIR/Inkognito.xcodeproj/project.pbxproj"

default_project_value() {
  local key="$1"
  rg -n --no-filename "$key = " "$PROJECT_FILE" | head -n 1 | sed -E "s/.*$key = ([^;]+);/\\1/"
}

find_sign_update() {
  if [[ -n "$SIGN_UPDATE_PATH" ]]; then
    echo "$SIGN_UPDATE_PATH"
    return 0
  fi

  local candidate=""
  for candidate in \
    "$(command -v sign_update 2>/dev/null || true)" \
    "/Applications/Sparkle/bin/sign_update" \
    "$HOME/Applications/Sparkle/bin/sign_update" \
    "$ROOT_DIR/vendor/Sparkle/bin/sign_update"
  do
    if [[ -n "$candidate" && -x "$candidate" ]]; then
      echo "$candidate"
      return 0
    fi
  done

  return 1
}

extract_ed_signature() {
  local sign_output="$1"
  python3 - <<'PY' "$sign_output"
import re
import sys

text = sys.argv[1]
match = re.search(r'edSignature="([^"]+)"', text)
if not match:
    match = re.search(r'^([^"\n]+)$', text.strip())
if not match:
    raise SystemExit("Could not parse edSignature from sign_update output")
print(match.group(1))
PY
}

VERSION="$(default_project_value CURRENT_PROJECT_VERSION)"
SHORT_VERSION="$(default_project_value MARKETING_VERSION)"
GITHUB_REPO=""
TAG=""
DMG_PATH=""
ASSET_NAME=""
ED_SIGNATURE=""
PUB_DATE="$(LC_ALL=C date -u '+%a, %d %b %Y %H:%M:%S +0000')"
OUTPUT_DIR=""
NOTES_PATH=""
APPCAST_PATH=""
USER_FACING_NOTE=""
MIGRATION_NOTE=""
SIGN_UPDATE_PATH=""
declare -a HIGHLIGHTS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --version)
      VERSION="$2"
      shift 2
      ;;
    --short-version)
      SHORT_VERSION="$2"
      shift 2
      ;;
    --github-repo)
      GITHUB_REPO="$2"
      shift 2
      ;;
    --tag)
      TAG="$2"
      shift 2
      ;;
    --dmg-path)
      DMG_PATH="$2"
      shift 2
      ;;
    --asset-name)
      ASSET_NAME="$2"
      shift 2
      ;;
    --ed-signature)
      ED_SIGNATURE="$2"
      shift 2
      ;;
    --pub-date)
      PUB_DATE="$2"
      shift 2
      ;;
    --output-dir)
      OUTPUT_DIR="$2"
      shift 2
      ;;
    --notes-path)
      NOTES_PATH="$2"
      shift 2
      ;;
    --appcast-path)
      APPCAST_PATH="$2"
      shift 2
      ;;
    --highlight)
      HIGHLIGHTS+=("$2")
      shift 2
      ;;
    --user-facing-note)
      USER_FACING_NOTE="$2"
      shift 2
      ;;
    --migration-note)
      MIGRATION_NOTE="$2"
      shift 2
      ;;
    --sign-update-path)
      SIGN_UPDATE_PATH="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

for value_name in VERSION SHORT_VERSION GITHUB_REPO TAG DMG_PATH OUTPUT_DIR USER_FACING_NOTE MIGRATION_NOTE; do
  if [[ -z "${!value_name}" ]]; then
    echo "Missing required argument: ${value_name}" >&2
    usage >&2
    exit 1
  fi
done

if [[ "${#HIGHLIGHTS[@]}" -ne 3 ]]; then
  echo "Expected exactly 3 --highlight values, got ${#HIGHLIGHTS[@]}" >&2
  usage >&2
  exit 1
fi

if [[ ! -f "$DMG_PATH" ]]; then
  echo "DMG not found: $DMG_PATH" >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

if [[ -z "$ASSET_NAME" ]]; then
  ASSET_NAME="$(basename "$DMG_PATH")"
fi

if [[ -z "$NOTES_PATH" ]]; then
  NOTES_PATH="$OUTPUT_DIR/inkognito-release-notes-$SHORT_VERSION.html"
fi

if [[ -z "$APPCAST_PATH" ]]; then
  APPCAST_PATH="$OUTPUT_DIR/inkognito-appcast-$SHORT_VERSION.xml"
fi

DMG_URL="https://github.com/$GITHUB_REPO/releases/download/$TAG/$ASSET_NAME"

echo "Preparing Sparkle release assets"
echo "Version: $VERSION"
echo "Short version: $SHORT_VERSION"
echo "GitHub release: $GITHUB_REPO @ $TAG"
echo "DMG path: $DMG_PATH"
echo "DMG URL: $DMG_URL"

echo
echo "1. Render release notes HTML"
bash "$ROOT_DIR/release/sparkle/render_inkognito_release_notes.sh" \
  --short-version "$SHORT_VERSION" \
  --highlight "${HIGHLIGHTS[0]}" \
  --highlight "${HIGHLIGHTS[1]}" \
  --highlight "${HIGHLIGHTS[2]}" \
  --user-facing-note "$USER_FACING_NOTE" \
  --migration-note "$MIGRATION_NOTE" \
  --output "$NOTES_PATH"

if [[ -z "$ED_SIGNATURE" ]]; then
  if ! SIGN_UPDATE_BIN="$(find_sign_update)"; then
    echo "Could not locate Sparkle sign_update. Pass --ed-signature or --sign-update-path." >&2
    exit 1
  fi

  echo
  echo "2. Derive Sparkle edSignature"
  SIGN_OUTPUT="$("$SIGN_UPDATE_BIN" "$DMG_PATH")"
  ED_SIGNATURE="$(extract_ed_signature "$SIGN_OUTPUT")"
  echo "sign_update: $SIGN_UPDATE_BIN"
else
  echo
  echo "2. Use provided Sparkle edSignature"
fi

echo "edSignature: $ED_SIGNATURE"

echo
echo "3. Render appcast XML"
bash "$ROOT_DIR/release/sparkle/render_inkognito_appcast.sh" \
  --version "$VERSION" \
  --short-version "$SHORT_VERSION" \
  --dmg-url "$DMG_URL" \
  --dmg-path "$DMG_PATH" \
  --ed-signature "$ED_SIGNATURE" \
  --notes-file "$NOTES_PATH" \
  --output "$APPCAST_PATH" \
  --pub-date "$PUB_DATE"

echo
echo "Prepared release artifacts:"
echo "Release notes: $NOTES_PATH"
echo "Appcast: $APPCAST_PATH"
echo "DMG URL: $DMG_URL"
echo "edSignature: $ED_SIGNATURE"
