#!/usr/bin/env bash
# check-links.sh — validates markdown nav links and finds unreferenced files

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
ERRORS=0
WARNINGS=0

# Collect all .md files, excluding .planning/
mapfile -t ALL_MD < <(find "$REPO_ROOT" -name "*.md" -not -path "*/.planning/*" | sort)

# ── 1. BROKEN LINKS ──────────────────────────────────────────────────────────
echo "=== Broken Links ==="

while IFS= read -r source_file; do
  # Extract all markdown link targets: [text](target)
  while IFS= read -r link_target; do
    # Skip external URLs, protocol URLs, absolute paths, and anchor-only links
    if [[ "$link_target" =~ ^https?:// ]] || [[ "$link_target" =~ ^[a-z][a-z0-9+.-]+:// ]] \
       || [[ "$link_target" =~ ^/ ]] || [[ "$link_target" =~ ^# ]]; then
      continue
    fi

    # Strip any anchor fragment
    path_part="${link_target%%#*}"
    [[ -z "$path_part" ]] && continue

    source_dir="$(dirname "$source_file")"
    resolved="$(realpath --no-symlinks "$source_dir/$path_part" 2>/dev/null || true)"

    if [[ ! -e "$resolved" ]]; then
      rel_source="${source_file#"$REPO_ROOT/"}"
      echo "  BROKEN  $rel_source"
      echo "          -> $link_target"
      (( ERRORS++ )) || true
    fi
  done < <(grep -oP '\]\(\K[^)]+' "$source_file" 2>/dev/null || true)
done < <(printf '%s\n' "${ALL_MD[@]}")

[[ $ERRORS -eq 0 ]] && echo "  (none)"

# ── 2. UNREFERENCED FILES ─────────────────────────────────────────────────────
echo ""
echo "=== Files Never Referenced by a Prev/Next Nav Link ==="

# Collect every target path referenced in a <-- Prev or --> Next line
declare -A REFERENCED

while IFS= read -r source_file; do
  source_dir="$(dirname "$source_file")"
  while IFS= read -r link_target; do
    resolved="$(realpath --no-symlinks "$source_dir/$link_target" 2>/dev/null || true)"
    [[ -n "$resolved" ]] && REFERENCED["$resolved"]=1
  done < <(grep -P '^(<-- Prev:|-->? Next:)' "$source_file" 2>/dev/null \
           | grep -oP '\]\(\K[^)]+' || true)
done < <(printf '%s\n' "${ALL_MD[@]}")

UNREFERENCED=0
for md_file in "${ALL_MD[@]}"; do
  # README and CLAUDE.md are intentionally top-level; skip them
  basename_f="$(basename "$md_file")"
  if [[ "$basename_f" == "README.md" || "$basename_f" == "CLAUDE.md" ]]; then
    continue
  fi

  if [[ -z "${REFERENCED[$md_file]+set}" ]]; then
    rel="${md_file#"$REPO_ROOT/"}"
    echo "  UNREFERENCED  $rel"
    (( UNREFERENCED++ )) || true
    (( WARNINGS++ )) || true
  fi
done

[[ $UNREFERENCED -eq 0 ]] && echo "  (none)"

# ── Summary ──────────────────────────────────────────────────────────────────
echo ""
echo "=== Summary ==="
echo "  Broken links:       $ERRORS"
echo "  Unreferenced files: $WARNINGS"
echo ""

[[ $ERRORS -gt 0 ]] && exit 1 || exit 0
