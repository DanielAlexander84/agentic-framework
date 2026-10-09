#!/usr/bin/env bash
# Installs or updates the framework in a project.
# Usage: ./install.sh /path/to/project [profile]   (profile defaults to rails-react)
#
# Framework-owned files are always overwritten, so re-running updates them:
#   docs/agentic/*.md, .claude/commands/*.md
# Project-owned files are created once and never overwritten:
#   CLAUDE.md, docs/STATUS.md, docs/DECISIONS.md, docs/critical-paths.md, docs/specs/_template.md
set -euo pipefail

FW="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:?Usage: ./install.sh /path/to/project [profile]}"
PROFILE="${2:-rails-react}"
TARGET="$(cd "$TARGET" && pwd)"

[ "$TARGET" = "$FW" ] && { echo "Target is the framework repo itself. Point it at a project."; exit 1; }
case "$TARGET/" in "$FW/"*) echo "Target is inside the framework repo."; exit 1;; esac
[ -f "$FW/profiles/$PROFILE.md" ] || { echo "Unknown profile: $PROFILE"; ls "$FW/profiles"; exit 1; }

overwrite() { mkdir -p "$(dirname "$2")"; cp "$1" "$2"; echo "  updated  ${2#$TARGET/}"; }
create_once() {
  mkdir -p "$(dirname "$2")"
  if [ -e "$2" ]; then echo "  kept     ${2#$TARGET/} (already exists)"
  else cp "$1" "$2"; echo "  created  ${2#$TARGET/}"; fi
}

echo "Framework files:"
for f in "$FW"/core/*.md; do overwrite "$f" "$TARGET/docs/agentic/$(basename "$f")"; done
overwrite "$FW/profiles/$PROFILE.md" "$TARGET/docs/agentic/$PROFILE.md"
for f in "$FW"/templates/.claude/commands/*.md; do overwrite "$f" "$TARGET/.claude/commands/$(basename "$f")"; done

echo "Project files:"
create_once "$FW/templates/CLAUDE.md" "$TARGET/CLAUDE.md"
for f in STATUS.md DECISIONS.md critical-paths.md specs/_template.md; do
  create_once "$FW/templates/docs/$f" "$TARGET/docs/$f"
done

if [ -d "$TARGET/agentic-framework" ]; then
  echo
  echo "Warning: $TARGET/agentic-framework exists. Remove it; Claude Code would read its blank templates."
fi
echo
echo "Next: fill in every [bracket] in CLAUDE.md, then open Claude Code and run /onboard (brownfield) or /feature (greenfield)."