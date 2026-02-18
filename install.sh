#!/usr/bin/env sh
# AI Attribution Log — Installer
# https://github.com/ismet55555/ai-attribution
#
# Downloads AI_ATTRIBUTION.md into the current directory.
#
# Usage:
#   curl -sL https://raw.githubusercontent.com/ismet55555/ai-attribution/main/install.sh | sh
#   curl -sL https://raw.githubusercontent.com/ismet55555/ai-attribution/main/install.sh | sh -s -- --version v1.0.0
#
# Options:
#   --version <tag>   Download a specific version (e.g., v1.0.0). Default: latest release.
#   --force           Overwrite existing AI_ATTRIBUTION.md without prompting.
#   --help            Show this help message.

set -e

REPO="ismet55555/ai-attribution"
FILE="AI_ATTRIBUTION.md"
VERSION=""
FORCE=0

# --- Parse arguments ---

while [ $# -gt 0 ]; do
  case "$1" in
    --version)
      VERSION="$2"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --help)
      sed -n '2,/^$/s/^# *//p' "$0"
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

# --- Check for curl ---

if ! command -v curl >/dev/null 2>&1; then
  echo "Error: curl is required but not installed." >&2
  exit 1
fi

# --- Resolve version ---

if [ -z "$VERSION" ]; then
  VERSION=$(curl -sI "https://github.com/$REPO/releases/latest" \
    | grep -i '^location:' \
    | sed 's|.*/||' \
    | tr -d '\r')

  if [ -z "$VERSION" ]; then
    echo "Error: Could not determine latest release. Specify a version with --version." >&2
    exit 1
  fi
fi

# --- Check for existing file ---

if [ -f "$FILE" ] && [ "$FORCE" -eq 0 ]; then
  printf "%s already exists. Overwrite? [y/N] " "$FILE"
  read -r answer
  case "$answer" in
    [Yy]*) ;;
    *)
      echo "Aborted."
      exit 0
      ;;
  esac
fi

# --- Download ---

URL="https://raw.githubusercontent.com/$REPO/$VERSION/$FILE"
HTTP_CODE=$(curl -sL -w "%{http_code}" -o "$FILE" "$URL")

if [ "$HTTP_CODE" -ne 200 ]; then
  rm -f "$FILE"
  echo "Error: Failed to download $FILE (HTTP $HTTP_CODE)." >&2
  echo "Check that version '$VERSION' exists at https://github.com/$REPO/releases" >&2
  exit 1
fi

echo "AI Attribution Log $VERSION installed successfully."
echo "  -> $FILE"
echo ""
echo "Next steps:"
echo "  1. Open $FILE and edit the Configuration section"
echo "  2. Add a reference in your AI config file (see the AI Config Integration section)"
echo "  3. Commit and start logging"
