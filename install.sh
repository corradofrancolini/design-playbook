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
  # --force: always yes
  if [ "$OPT_FORCE" = true ]; then
    return 0
  fi
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
PLAYBOOK_VERSION="2.0.0"

# ---------------------------------------------------------------------------
# Parse arguments
# ---------------------------------------------------------------------------
OPT_NAME=""
OPT_FORCE=false
OPT_SKILL=""
TARGET=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --name)   OPT_NAME="$2"; shift 2 ;;
    --name=*) OPT_NAME="${1#*=}"; shift ;;
    --force)  OPT_FORCE=true; shift ;;
    --skill)  OPT_SKILL="$2"; shift 2 ;;
    --skill=*) OPT_SKILL="${1#*=}"; shift ;;
    --list-skills)
      printf "\n${BOLD}Available skills:${RESET}\n"
      for skill_dir in "$SCRIPT_DIR"/skills/*/; do
        printf "  %s\n" "$(basename "$skill_dir")"
      done
      printf "\n"
      exit 0
      ;;
    -h|--help)
      printf "\n${BOLD}design-playbook${RESET} — AD + AI project methodology\n\n"
      printf "Usage: %s [options] <target-directory>\n\n" "$0"
      printf "Options:\n"
      printf "  --name <name>    Project name (default: directory name)\n"
      printf "  --force          Overwrite existing files without asking\n"
      printf "  --skill <name>   Install a single skill (skip scaffold)\n"
      printf "  --list-skills    List available skills\n"
      printf "  -h, --help       Show this help\n\n"
      printf "Example:\n"
      printf "  %s ~/Projects/my-project\n" "$0"
      printf "  %s --name \"My Project\" --force ~/Projects/my-project\n\n" "$0"
      exit 0
      ;;
    -*) error "Unknown option: $1"; exit 1 ;;
    *)  TARGET="$1"; shift ;;
  esac
done

# ---------------------------------------------------------------------------
# Validate target directory
# ---------------------------------------------------------------------------
if [ -z "$TARGET" ]; then
  printf "\n${BOLD}design-playbook${RESET} — AD + AI project methodology\n\n"
  printf "Usage: %s [options] <target-directory>\n\n" "$0"
  printf "Run %s --help for options.\n\n" "$0"
  exit 1
fi

# Resolve to absolute path
TARGET="$(cd "$TARGET" 2>/dev/null && pwd)" || {
  error "Directory not found: $TARGET"
  exit 1
}

# ---------------------------------------------------------------------------
# Project name
# ---------------------------------------------------------------------------
DEFAULT_NAME="$(basename "$TARGET")"

printf "\n${BOLD}design-playbook${RESET} — AD + AI project methodology\n"
printf "${DIM}Target: %s${RESET}\n" "$TARGET"

if [ -n "$OPT_SKILL" ]; then
  # Single skill mode — no project name needed
  PROJECT_NAME="$DEFAULT_NAME"
elif [ -n "$OPT_NAME" ]; then
  PROJECT_NAME="$OPT_NAME"
  printf "  Project name: %s\n" "$PROJECT_NAME"
else
  printf "\n  Project name [%s]: " "$DEFAULT_NAME"
  read -r PROJECT_NAME
  PROJECT_NAME="${PROJECT_NAME:-$DEFAULT_NAME}"
fi

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
# Portable sed -i (macOS vs GNU)
# ---------------------------------------------------------------------------
sed_inplace() {
  if (sed --version 2>/dev/null || true) | grep -q GNU 2>/dev/null; then
    sed -i "$@"
  else
    sed -i '' "$@"
  fi
}

# ---------------------------------------------------------------------------
# Detect and migrate existing installations
# ---------------------------------------------------------------------------
migrate_existing() {
  local version_file="$TARGET/.playbook-version"
  local old_handoff="$TARGET/SESSION_HANDOFF.md"

  # Not an existing installation — skip
  if [ ! -f "$version_file" ] && [ ! -f "$old_handoff" ]; then
    return
  fi

  # Already on v2+ — skip
  if [ -f "$version_file" ]; then
    local current
    current="$(cat "$version_file")"
    case "$current" in
      2.*) return ;;
    esac
  fi

  header "Migrating from previous version..."

  # Migrate SESSION_HANDOFF.md content to docs/handoffs/
  if [ -f "$old_handoff" ]; then
    # Check if it has real content (not just the template)
    if grep -q "## Stato Attuale" "$old_handoff" 2>/dev/null && \
       ! grep -q "docs/handoffs/" "$old_handoff" 2>/dev/null; then
      mkdir -p "$TARGET/docs/handoffs"
      local migration_date
      migration_date="$(date +%Y-%m-%d_%H-%M)"
      local migrated_file="$TARGET/docs/handoffs/${migration_date}_migrated.md"
      cp "$old_handoff" "$migrated_file"
      info "SESSION_HANDOFF.md migrated to docs/handoffs/"
    fi
  fi

  # Create new directories if missing
  mkdir -p "$TARGET/docs/handoffs"
  mkdir -p "$TARGET/assets"
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

  # Remove obsolete entries from previous versions
  local cleaned=0
  for obsolete in "docs/" "lab/"; do
    if grep -qxF "$obsolete" "$gitignore" 2>/dev/null; then
      # Remove the exact line (portable sed)
      sed_inplace "s|^${obsolete}$||" "$gitignore"
      # Remove resulting blank lines (clean up)
      cleaned=$((cleaned + 1))
    fi
  done
  if [ "$cleaned" -gt 0 ]; then
    # Remove empty lines left by sed (collapse multiple blank lines)
    local tmp
    tmp="$(awk 'NF || !prev_empty {print; prev_empty=!NF} NF {prev_empty=0}' "$gitignore")"
    printf "%s\n" "$tmp" > "$gitignore"
    info ".gitignore cleaned ($cleaned obsolete entries removed)"
  fi

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
    if [ "$cleaned" -eq 0 ]; then
      warn ".gitignore (already up to date)"
    fi
  fi
}

# ---------------------------------------------------------------------------
# Single skill mode
# ---------------------------------------------------------------------------
if [ -n "$OPT_SKILL" ]; then
  if [ ! -f "$SCRIPT_DIR/skills/$OPT_SKILL/SKILL.md" ]; then
    error "Unknown skill: $OPT_SKILL"
    printf "\n  Available skills:\n"
    for skill_dir in "$SCRIPT_DIR"/skills/*/; do
      printf "    %s\n" "$(basename "$skill_dir")"
    done
    printf "\n"
    exit 1
  fi

  header "Installing skill..."
  copy_skill "$OPT_SKILL"
else

# ---------------------------------------------------------------------------
# Migration (existing installations)
# ---------------------------------------------------------------------------
migrate_existing

# ---------------------------------------------------------------------------
# Install scaffold
# ---------------------------------------------------------------------------
header "Installing scaffold..."

copy_scaffold "CLAUDE.md"
copy_scaffold "BRIEF.md"
copy_scaffold "SESSION_HANDOFF.md"
copy_scaffold "BACKLOG.md"
copy_scaffold "CREATIVE_DIRECTION.md"
copy_scaffold "lab/PROCESS.md"
copy_scaffold "lab/notes.md"
copy_scaffold "docs/sessions/TEMPLATE.md"
copy_scaffold "docs/handoffs/.gitkeep"
copy_scaffold "assets/.gitkeep"

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
copy_skill "storybook"
copy_skill "playbook"
copy_skill "setup"
copy_skill "benchmark"

fi # end single skill mode

# ---------------------------------------------------------------------------
# Write version file
# ---------------------------------------------------------------------------
echo "$PLAYBOOK_VERSION" > "$TARGET/.playbook-version"

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
header "Done."
printf "  %s files installed" "$INSTALLED"
if [ "$SKIPPED" -gt 0 ]; then
  printf ", %s skipped" "$SKIPPED"
fi
printf ".\n"

# Rich summary only for full install (not --skill mode)
if [ -z "$OPT_SKILL" ]; then
  printf "\n  ${BOLD}WHAT'S INSTALLED${RESET}\n\n"

  printf "  ${DIM}Scaffold files:${RESET}\n"
  printf "    CLAUDE.md              Project protocol (auto-loaded by Claude Code)\n"
  printf "    BRIEF.md               Project brief — fill this first\n"
  printf "    SESSION_HANDOFF.md     Pointer to docs/handoffs/\n"
  printf "    BACKLOG.md             Backlog and decisions\n"
  printf "    CREATIVE_DIRECTION.md  Creative direction\n"
  printf "    lab/PROCESS.md         Anti-sycophancy methodology\n"
  printf "    lab/notes.md           Working notes\n"
  printf "    docs/handoffs/         Session handoffs (shared, committed)\n"
  printf "    docs/sessions/         Session log template (personal, gitignored)\n"
  printf "    assets/                Source materials (brand, moodboard, etc.)\n"

  printf "\n  ${DIM}Skills (invoke with /command in Claude Code):${RESET}\n"
  for skill_dir in "$SCRIPT_DIR"/skills/*/; do
    local_name="$(basename "$skill_dir")"
    local_desc=""
    if [ -f "$skill_dir/SKILL.md" ]; then
      local_desc="$(sed -n 's/^description: *//p' "$skill_dir/SKILL.md" | head -1)"
    fi
    if [ -n "$local_desc" ]; then
      printf "    /${BOLD}%-16s${RESET} %s\n" "$local_name" "$local_desc"
    else
      printf "    /${BOLD}%s${RESET}\n" "$local_name"
    fi
  done

  printf "\n  ${BOLD}GETTING STARTED${RESET}\n\n"
  printf "  1. Open Claude Code in ${BOLD}%s${RESET}\n" "$TARGET"
  printf "  2. Run ${BOLD}/setup${RESET} for a guided project configuration\n"
  printf "  3. Or fill BRIEF.md and CREATIVE_DIRECTION.md manually\n"
  printf "  4. Start designing — Claude operates in Adjacent Possible mode\n"
  printf "\n  Type ${BOLD}/playbook${RESET} anytime for a quick reference.\n"
fi
printf "\n"
