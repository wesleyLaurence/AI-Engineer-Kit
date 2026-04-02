#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$ROOT_DIR/.agents/skills"
TARGET_DIR="$ROOT_DIR/.claude/skills"
MODE="${1:-sync}"

usage() {
  cat <<'EOF'
Usage:
  scripts/sync-skills.sh sync
  scripts/sync-skills.sh check

Modes:
  sync   Mirror .agents/skills/ into .claude/skills/
  check  Exit non-zero if the two skill trees differ
EOF
}

require_dir() {
  local path="$1"

  if [[ ! -d "$path" ]]; then
    echo "Missing directory: $path" >&2
    exit 1
  fi
}

sync_skills() {
  require_dir "$SOURCE_DIR"
  mkdir -p "$TARGET_DIR"

  if ! command -v rsync >/dev/null 2>&1; then
    echo "rsync is required for sync mode." >&2
    exit 1
  fi

  rsync -a --delete --exclude '.DS_Store' "$SOURCE_DIR/" "$TARGET_DIR/"
  echo "Mirrored $SOURCE_DIR -> $TARGET_DIR"
}

check_skills() {
  require_dir "$SOURCE_DIR"
  require_dir "$TARGET_DIR"

  if diff -ru --exclude='.DS_Store' "$SOURCE_DIR" "$TARGET_DIR" >/dev/null; then
    echo "Skill trees are in sync."
  else
    echo "Skill trees differ: $SOURCE_DIR vs $TARGET_DIR" >&2
    diff -ru --exclude='.DS_Store' "$SOURCE_DIR" "$TARGET_DIR" || true
    exit 1
  fi
}

case "$MODE" in
  sync)
    sync_skills
    ;;
  check)
    check_skills
    ;;
  *)
    usage
    exit 1
    ;;
esac
