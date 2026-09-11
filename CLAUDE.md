# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a personal developer workstation setup guide — a documentation-only repository with no build system, tests, or compiled code. It is a runbook for provisioning a fresh Windows 11 machine as a keyboard-centric, terminal-first developer environment.

## Setup Sequence

The intended order matters when following this guide on a fresh machine:

1. **WinGet** (`windows/winget/`) — verify package manager works first
2. **PowerShell 7** (`windows/powershell-setup.md`) — required before WSL and most Windows steps
3. **WSL2** (`windows/wsl/`) — foundation for all Linux-side tooling
4. **Git** (`wsl/git/`) — source control and authentication (gh / GCM)
5. **mise** (`wsl/mise/`) — tool manager (Node.js, Python, Neovim, gh)
6. **Tree-Sitter** (`wsl/tree-sitter-install.md`) — syntax tool (via mise)
7. **Neovim** (`wsl/nvim/`) — terminal editor (via mise)
8. **VS Code** (`windows/vscode/`) — editor with WSL integration
9. **Claude Code** (`wsl/claude-install.md`) — AI coding assistant in VS Code + WSL

Other setups (`wsl/python/`, `windows/docker.md`, `windows/ditto/`, etc.) are independent of this sequence.

## Workspace Layout

The VS Code workspace (`env-setup.code-workspace`) mounts two folders:
- The repo root (`env-setup/`)
- The Windows Terminal state directory (`LocalState/`) — so terminal settings can be edited and backed up as part of this repo

The live Windows Terminal settings live at `windows/terminal/settings.json`, which maps to the mounted `LocalState/` folder.

## Key Architectural Decisions Documented Here

- **Git authentication**: Standard GitHub CLI (`gh`) over HTTPS (Recommended). Git Credential Manager (GCM) with Microsoft Entra ID (MSAL) is **OPTIONAL (Work Only)** for corporate Azure DevOps. SSH keys are removed.
- **Version/Tool management**: `mise` serves as the single polyglot tool manager, replacing Volta, Bob, and Pyenv.
- **AI models**: Claude Code for coding.

## Navigation Pattern

Sequential files in a section use `<-- Prev` / `--> Next` links at the bottom. Files not in the main sequence use `<-- Top: [Back to Readme](README.md)`. Files with 3+ H2 sections include a table of contents.

Relative links in markdown must never use a `./` prefix — use `file.md` not `./file.md`, and `../dir/file.md` not `./../dir/file.md`. The `./` form can fail when GitHub renders files outside the standard tree view (e.g. blame, raw).

## Adding New Documentation

Before creating or editing setup docs, read **`.claude/adding-new-docs.md`**. It covers the full doc template, file placement rules, navigation chain wiring, Windows environment constraints (no admin access), and the doctor script sync checklist.

## `.changelog/` vs `.planning/`

These two directories look similar but serve opposite purposes — don't mix them up:

- **`.planning/` is transient scratch space.** Open questions, raw notes, not-yet-actioned ideas, future planned sections. Nothing here is finished or authoritative. **Never reference a `.planning/` file from anywhere else in the repo** — not from a main doc, not from a `.changelog/` entry, not from a script. Those references break the moment the transient content is cleaned up, reorganized, or deleted, which is expected to happen to `.planning/` content regularly.
- **`.changelog/` is the running history.** When a `.planning/` item is actually done, or when session-narration-style commentary ("an earlier version of this doc said...", "confirmed 2026-09-10...") gets trimmed out of a main doc, its record moves to `.changelog/` — it does not stay in `.planning/` and does not get silently deleted.
- **One changelog file per top-level directory**, not one per source file — e.g. `.changelog/optimizely.md` covers every file under `optimizely/`, not `.changelog/optimizely/cfg/admin-console.md`. Repo-root files (`README.md`, `CLAUDE.md`, `doctor.*`) go in `.changelog/root.md`. Use headings inside each file (date + which doc(s) it's about) to keep entries organized; aggregate into fewer files rather than mirroring the source tree.
- If a piece of setup content itself needs a permanent home rather than being a changelog entry, it's a **troubleshooting doc** (`<component>-troubleshooting.md`, alongside the main doc, or its own folder if that topic doesn't already have one) or a **migration doc** (`migrations/<name>.md`) instead — changelog is for narrating what changed and why, not for content someone following the guide today actually needs to act on.

## Editing Guidelines

All content is Markdown (with the exception of validation/doctor scripts). When updating setup instructions:
- Single-file topics belong directly in the parent directory, not inside their own subfolder. Only create a subdirectory when it contains multiple related files (e.g. `winget/` holds both `winget-install.md` and `winget-troubleshooting.md`).
- Commands should be copy-pasteable as-is (no placeholders like `<your-value>` unless unavoidable).
- Preserve the setup sequence rationale — note prerequisites explicitly.
- Every time `sudo apt` or `sudo apt-get` is used in setup instructions, ensure that package updates are run first (e.g., `sudo apt update && sudo apt upgrade` or `sudo apt-get update` before installation).
- The `.planning/` directory holds future planned sections (Dev Containers, Remote SSH) that are not yet implemented — do not treat these as current documentation. See "`.changelog/` vs `.planning/`" above for the full rule.

## Workstation Doctor Scripts

This repository contains two terminal diagnostic scripts that analyze local machine alignment with the setup guides:
- `doctor.sh` (Bash/WSL environment)
- `doctor.ps1` (PowerShell/Windows environment)

> [!IMPORTANT]
> **Synchronization Rule**: Whenever you modify the tool stack (e.g., adding a new standard package, upgrading a tool version, or retiring an outdated package), **you must update both `doctor.sh` and `doctor.ps1`** to keep them in lockstep:
> - **Additions**: Add the tool to the core required/active toolstack check.
> - **Retirements**: Add the tool to the retired tool list with a recommendation/command for its clean uninstallation.
> - **Work/Corporate Tools**: Add/maintain these within the `--work` / `-Work` parameter blocks.
