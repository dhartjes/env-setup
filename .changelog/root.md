# Changelog: repo root

Running history of documentation changes to files at the repo root (not under any top-level subdirectory) — `README.md`, `CLAUDE.md`, `doctor.sh`, `doctor.ps1`.

## 2026-09-10 — Path updates for the mise doc restructuring

`README.md`'s "mise (Polyglot Tool Manager)" entry and `CLAUDE.md`'s setup-sequence entry both updated from `wsl/mise-install.md` to `wsl/mise/mise-install.md` (see `.changelog/wsl.md` and `.changelog/windows.md` for the full restructuring). `doctor.ps1` and `doctor.sh` had dangling references to the deleted `windows/migrate-to-mise.md` and `wsl/migrate-to-mise.md` fixed to point at the consolidated `migrations/migrate-to-mise.md` instead.

## 2026-09-11 — `check-links.sh`: exempt `.changelog/` from the unreferenced-files warning

`.changelog/*.md` files are standalone by design — not part of any Prev/Next setup-sequence chain — so they'd otherwise always show up as false-positive "unreferenced" warnings, the same way `README.md`/`CLAUDE.md` already are exempt. Broken-link checking still applies to `.changelog/` content.

## 2026-10-14 — Pandoc and MiKTeX

Added a `README.md` setup-sequence entry for `windows/pandoc-install.md` and two new `doctor.ps1` `Check-Package` checks, one for Pandoc (`pandoc`) and one for MiKTeX (`pdflatex`). `doctor.sh` is unchanged because these are Windows-side installs.

## 2026-10-14 — Pandoc and Tectonic (WSL)

Added a `README.md` entry for `wsl/pandoc-install.md` and two new `doctor.sh` `check_required_tool` checks, one for `pandoc` and one for `tectonic`, both managed by mise.
