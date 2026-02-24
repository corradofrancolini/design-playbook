#!/usr/bin/env bash
set -euo pipefail

# design-playbook installer
# Installs scaffold files and Claude Code skills into a target project.

# ---------------------------------------------------------------------------
# Colors (disabled if not a terminal)
# ---------------------------------------------------------------------------
if [ -t 1 ]; then
  GREEN='\033[0;32m'
  YELLOW='\033[0;33m'
  RED='\033[0;31m'
  BOLD='\033[1m'
  DIM='\033[2m'
  RESET='\033[0m'
else
  GREEN='' YELLOW='' RED='' BOLD='' DIM='' RESET=''
fi

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
info()  { printf "${GREEN}  ✓${RESET} %s\n" "$1"; }
warn()  { printf "${YELLOW}  !${RESET} %s\n" "$1"; }
error() { printf "${RED}  ✗${RESET} %s\n" "$1"; }
header(){ printf "\n${BOLD}%s${RESET}\n" "$1"; }

ask_yes_no() {
  local prompt="$1" default="${2:-n}"
  if [ "$default" = "y" ]; then
    printf "  %s [Y/n] " "$prompt"
  else
    printf "  %s [y/N] " "$prompt"
  fi
  read -r answer
  answer="${answer:-$default}"
  case "$answer" in
    [yY]*) return 0 ;;
    *) return 1 ;;
  esac
}

# ---------------------------------------------------------------------------
# Resolve script directory (where design-playbook lives)
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------------------------------------------------------------------------
# Validate target directory
# ---------------------------------------------------------------------------
TARGET="${1:-}"

if [ -z "$TARGET" ]; then
  printf "\n${BOLD}design-playbook${RESET} — AD + AI project methodology\n\n"
  printf "Usage: %s <target-directory>\n\n" "$0"
  printf "Example:\n"
  printf "  %s ~/Projects/my-project\n\n" "$0"
  exit 1
fi

# Resolve to absolute path
TARGET="$(cd "$TARGET" 2>/dev/null && pwd)" || {
  error "Directory not found: $1"
  exit 1
}

# ---------------------------------------------------------------------------
# Project name
# ---------------------------------------------------------------------------
DEFAULT_NAME="$(basename "$TARGET")"

printf "\n${BOLD}design-playbook${RESET} — AD + AI project methodology\n"
printf "${DIM}Target: %s${RESET}\n" "$TARGET"
printf "\n  Project name [%s]: " "$DEFAULT_NAME"
read -r PROJECT_NAME
PROJECT_NAME="${PROJECT_NAME:-$DEFAULT_NAME}"

# ---------------------------------------------------------------------------
# Counters
# ---------------------------------------------------------------------------
INSTALLED=0
SKIPPED=0

# ---------------------------------------------------------------------------
# Copy a scaffold file with placeholder replacement
# ---------------------------------------------------------------------------
copy_scaffold() {
  local src="$1"   # relative path inside scaffold/
  local dest="$TARGET/$src"
  local dest_dir
  dest_dir="$(dirname "$dest")"

  # Create parent directories
  mkdir -p "$dest_dir"

  # If file exists, ask before overwriting
  if [ -f "$dest" ]; then
    if ! ask_yes_no "$src already exists. Overwrite?"; then
      warn "$src (skipped — already exists)"
      SKIPPED=$((SKIPPED + 1))
      return
    fi
  fi

  # Copy with placeholder replacement
  sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$SCRIPT_DIR/scaffold/$src" > "$dest"
  info "$src"
  INSTALLED=$((INSTALLED + 1))
}

# ---------------------------------------------------------------------------
# Copy a skill
# ---------------------------------------------------------------------------
copy_skill() {
  local skill_name="$1"
  local src="$SCRIPT_DIR/skills/$skill_name/SKILL.md"
  local dest_dir="$TARGET/.claude/skills/$skill_name"
  local dest="$dest_dir/SKILL.md"

  mkdir -p "$dest_dir"

  if [ -f "$dest" ]; then
    if ! ask_yes_no "Skill $skill_name already exists. Overwrite?"; then
      warn "$skill_name (skipped — already exists)"
      SKIPPED=$((SKIPPED + 1))
      return
    fi
  fi

  cp "$src" "$dest"
  info "$skill_name"
  INSTALLED=$((INSTALLED + 1))
}

# ---------------------------------------------------------------------------
# Append gitignore additions (without duplicates)
# ---------------------------------------------------------------------------
update_gitignore() {
  local gitignore="$TARGET/.gitignore"
  local additions="$SCRIPT_DIR/extras/gitignore-additions"

  if [ ! -f "$additions" ]; then
    return
  fi

  # Create .gitignore if it doesn't exist
  touch "$gitignore"

  local added=0
  while IFS= read -r line || [ -n "$line" ]; do
    # Skip comments and empty lines for duplicate checking
    if [[ "$line" =~ ^[[:space:]]*# ]] || [[ -z "${line// /}" ]]; then
      # For comments, check if the exact line exists
      if ! grep -qxF "$line" "$gitignore" 2>/dev/null; then
        echo "$line" >> "$gitignore"
      fi
      continue
    fi
    # For actual patterns, check for duplicates
    if ! grep -qxF "$line" "$gitignore" 2>/dev/null; then
      echo "$line" >> "$gitignore"
      added=$((added + 1))
    fi
  done < "$additions"

  if [ "$added" -gt 0 ]; then
    info ".gitignore updated ($added entries added)"
    INSTALLED=$((INSTALLED + 1))
  else
    warn ".gitignore (already up to date)"
  fi
}

# ---------------------------------------------------------------------------
# Install scaffold
# ---------------------------------------------------------------------------
header "Installing scaffold..."

copy_scaffold "CLAUDE.md"
copy_scaffold "SESSION_HANDOFF.md"
copy_scaffold "BACKLOG.md"
copy_scaffold "CREATIVE_DIRECTION.md"
copy_scaffold "lab/PROCESS.md"
copy_scaffold "lab/notes.md"
copy_scaffold "docs/sessions/TEMPLATE.md"

update_gitignore

# ---------------------------------------------------------------------------
# Install skills
# ---------------------------------------------------------------------------
header "Installing skills..."

copy_skill "session-end"
copy_skill "creative"
copy_skill "review"
copy_skill "accessibility"
copy_skill "content"
copy_skill "design-system"
copy_skill "seo"
copy_skill "project-index"

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
header "Done."
printf "  %s files installed" "$INSTALLED"
if [ "$SKIPPED" -gt 0 ]; then
  printf ", %s skipped" "$SKIPPED"
fi
printf ".\n"
printf "  Open Claude Code in ${BOLD}%s${RESET} to start.\n\n" "$TARGET"
