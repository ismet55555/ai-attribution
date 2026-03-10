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
#   --with-skill      Also install the Claude Code skill (.claude/skills/ai-attribution/SKILL.md).
#   --skill-only      Install only the Claude Code skill (skip AI_ATTRIBUTION.md).
#   --help            Show this help message.

set -e

REPO="ismet55555/ai-attribution"
FILE="AI_ATTRIBUTION.md"
VERSION=""
FORCE=0
SKILL=0
SKILL_ONLY=0

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
    --with-skill)
      SKILL=1
      shift
      ;;
    --skill-only)
      SKILL=1
      SKILL_ONLY=1
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

# --- Download AI_ATTRIBUTION.md (unless --skill-only) ---

DOWNLOADED_FILE=0

if [ "$SKILL_ONLY" -eq 0 ]; then
  if [ -f "$FILE" ] && [ "$FORCE" -eq 0 ]; then
    echo ""
    echo "WARNING: $FILE already exists."
    echo "Overwriting will REPLACE the entire file, including any attribution"
    echo "log entries you have recorded. This cannot be undone (unless you have"
    echo "committed the file to version control)."
    echo ""
    printf "Type YES to overwrite and lose existing contents: "
    read -r answer
    case "$answer" in
      YES)
        ;;
      *)
        echo "Aborted. Existing $FILE was not modified."
        if [ "$SKILL" -eq 0 ]; then
          exit 0
        fi
        # Continue to skill installation if --with-skill was also set
        DOWNLOADED_FILE=-1
        ;;
    esac
  fi

  if [ "$DOWNLOADED_FILE" -eq 0 ]; then
    URL="https://raw.githubusercontent.com/$REPO/$VERSION/$FILE"
    HTTP_CODE=$(curl -sL -w "%{http_code}" -o "$FILE" "$URL")

    if [ "$HTTP_CODE" -ne 200 ]; then
      rm -f "$FILE"
      echo "Error: Failed to download $FILE (HTTP $HTTP_CODE)." >&2
      echo "Check that version '$VERSION' exists at https://github.com/$REPO/releases" >&2
      exit 1
    fi
    DOWNLOADED_FILE=1
  fi
fi

# --- Install skill (optional) ---

SKILL_DIR=".claude/skills/ai-attribution"
SKILL_FILE="$SKILL_DIR/SKILL.md"

if [ "$SKILL" -eq 1 ]; then
  if [ -f "$SKILL_FILE" ] && [ "$FORCE" -eq 0 ]; then
    printf "%s already exists. Overwrite? [y/N] " "$SKILL_FILE"
    read -r answer
    case "$answer" in
      [Yy]*) ;;
      *)
        echo "Skipped skill installation."
        SKILL=0
        ;;
    esac
  fi

  if [ "$SKILL" -eq 1 ]; then
    mkdir -p "$SKILL_DIR"
    SKILL_URL="https://raw.githubusercontent.com/$REPO/$VERSION/$SKILL_FILE"
    SKILL_HTTP=$(curl -sL -w "%{http_code}" -o "$SKILL_FILE" "$SKILL_URL")

    if [ "$SKILL_HTTP" -ne 200 ]; then
      rm -f "$SKILL_FILE"
      echo "Warning: Could not download skill file (HTTP $SKILL_HTTP). Continuing without it." >&2
      SKILL=0
    fi
  fi
fi

# --- Summary ---

echo ""
echo "AI Attribution Log $VERSION — installation complete."
if [ "$DOWNLOADED_FILE" -eq 1 ]; then
  echo "  -> $FILE"
fi
if [ "$SKILL" -eq 1 ]; then
  echo "  -> $SKILL_FILE"
fi
echo ""
echo "Next steps:"
STEP=1
if [ "$DOWNLOADED_FILE" -eq 1 ]; then
  echo "  $STEP. Open $FILE and edit the Configuration section"
  STEP=$((STEP + 1))
  echo "  $STEP. Add a reference in your AI config file (see the AI Config Integration section)"
  STEP=$((STEP + 1))
fi
if [ "$SKILL" -eq 1 ]; then
  echo "  $STEP. Use /ai-attribution log, check, graph, or summary in Claude Code"
  STEP=$((STEP + 1))
fi
echo "  $STEP. Commit and start logging"
