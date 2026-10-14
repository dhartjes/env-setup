# Changelog: wsl/

Running history of documentation changes under `wsl/`, aggregated into this one file rather than mirrored per-source-file.

## 2026-09-10 — mise docs given the same treatment as `windows/`

Noticed `wsl/migrate-to-mise.md` and `wsl/mise-install.md` needed identical treatment to the Windows split, and that having one migration-steps file per platform under `migrations/` was overkill.

- `wsl/volta-install.md` **deleted** — confirmed orphaned, nothing linked to it once WSL moved onto mise.
- `wsl/mise-install.md` **deleted**, split the same way as Windows: `wsl/mise/mise-install.md` (mise itself) + `wsl/mise/mise-tools.md` (Node/Python/Neovim/gh/uv/tree-sitter/AI-assistant installs).
- While rewiring this chain, fixed a pre-existing inconsistency: `wsl/git/git-clone-repos.md` and `wsl/tree-sitter-install.md` pointed straight at each other in their Prev/Next footers, skipping over mise entirely even though the root README's numbered sequence placed mise between them. Chain is now `git-clone-repos.md` → `mise/mise-install.md` → `mise/mise-tools.md` → `tree-sitter-install.md`.
- `wsl/migrate-to-mise.md`'s old-version-manager removal steps were folded into `migrations/migrate-to-mise.md` alongside the equivalent Windows steps, so `migrations/` holds a single file covering both platforms instead of one per platform.

Root `README.md` and `CLAUDE.md` were updated for the `wsl/mise-install.md` → `wsl/mise/mise-install.md` path change.

## 2026-10-14 — `pandoc-install.md` added (Pandoc + Tectonic via mise)

New `wsl/pandoc-install.md`. When VS Code is connected through Remote - WSL, the vscode-pandoc extension runs inside WSL (the extension doesn't declare an `extensionKind`), so the Windows Pandoc/MiKTeX install isn't used there. Pandoc comes from mise's registry. Tectonic comes through mise's `github:` backend because the registry doesn't list it. It was picked over TeX Live from `apt` because it's a single binary that fetches LaTeX packages on demand, much like MiKTeX's auto-install. The doc points the extension at Tectonic through a WSL remote setting (`pandoc.pdfOptString`) so Windows-side rendering stays on `pdflatex`. Tested 2026-10-14 with pandoc 3.12.1 and tectonic 0.17.0. In the sequence, it sits between `windows/pandoc-install.md` and `windows/vscode/vscode-extensions.md`.
