#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  bash release/sparkle/render_inkognito_release_notes.sh \
    --short-version 0.3.0 \
    --highlight "Review-Workflow weiter geschaerft" \
    --highlight "Dokumentklassen robuster erkannt" \
    --highlight "Eigene Regeln produktnaeher gemacht" \
    --user-facing-note "Automatische Treffer lassen sich jetzt klarer pruefen." \
    --migration-note "Bestehende Installationen koennen bei alten Vorabstaenden eine bewusste Neuinstallation brauchen." \
    --output output/release/sparkle/inkognito-release-notes-0.3.0.html

Required:
  --short-version    Human-readable version string
  --highlight        One release highlight. Repeat exactly 3 times.
  --user-facing-note User-facing note shown below the highlights
  --migration-note   Update or migration hint for existing users
  --output           Output path for the rendered HTML file
USAGE
}

SHORT_VERSION=""
USER_FACING_NOTE=""
MIGRATION_NOTE=""
OUTPUT_PATH=""
declare -a HIGHLIGHTS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --short-version)
      SHORT_VERSION="$2"
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
    --output)
      OUTPUT_PATH="$2"
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

for value_name in SHORT_VERSION USER_FACING_NOTE MIGRATION_NOTE OUTPUT_PATH; do
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

TEMPLATE_PATH="release/sparkle/inkognito-release-notes.template.html"
if [[ ! -f "$TEMPLATE_PATH" ]]; then
  echo "Template not found: $TEMPLATE_PATH" >&2
  exit 1
fi

OUTPUT_DIR="$(dirname "$OUTPUT_PATH")"
mkdir -p "$OUTPUT_DIR"

python3 - <<'PY' "$TEMPLATE_PATH" "$OUTPUT_PATH" "$SHORT_VERSION" "${HIGHLIGHTS[0]}" "${HIGHLIGHTS[1]}" "${HIGHLIGHTS[2]}" "$USER_FACING_NOTE" "$MIGRATION_NOTE"
from pathlib import Path
import html
import sys

template_path, output_path, short_version, highlight_1, highlight_2, highlight_3, user_facing_note, migration_note = sys.argv[1:]
text = Path(template_path).read_text(encoding="utf-8")
replacements = {
    "{{SHORT_VERSION}}": html.escape(short_version),
    "{{HIGHLIGHT_1}}": html.escape(highlight_1),
    "{{HIGHLIGHT_2}}": html.escape(highlight_2),
    "{{HIGHLIGHT_3}}": html.escape(highlight_3),
    "{{USER_FACING_NOTE}}": html.escape(user_facing_note),
    "{{MIGRATION_NOTE_OPTIONAL}}": html.escape(migration_note),
}
for key, value in replacements.items():
    text = text.replace(key, value)
Path(output_path).write_text(text, encoding="utf-8")
PY

echo "Rendered release notes: $OUTPUT_PATH"
