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
5. **mise** (`wsl/mise-install.md`) — tool manager (Node.js, Python, Neovim, gh)
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

## Editing Guidelines

All content is Markdown (with the exception of validation/doctor scripts). When updating setup instructions:
- Single-file topics belong directly in the parent directory, not inside their own subfolder. Only create a subdirectory when it contains multiple related files (e.g. `winget/` holds both `winget-install.md` and `troubleshooting.md`).
- Commands should be copy-pasteable as-is (no placeholders like `<your-value>` unless unavoidable).
- Preserve the setup sequence rationale — note prerequisites explicitly.
- Every time `sudo apt` or `sudo apt-get` is used in setup instructions, ensure that package updates are run first (e.g., `sudo apt update && sudo apt upgrade` or `sudo apt-get update` before installation).
- The `.planning/` directory holds future planned sections (Dev Containers, Remote SSH) that are not yet implemented — do not treat these as current documentation.

## Workstation Doctor Scripts

This repository contains two terminal diagnostic scripts that analyze local machine alignment with the setup guides:
- `doctor.sh` (Bash/WSL environment)
- `doctor.ps1` (PowerShell/Windows environment)

> [!IMPORTANT]
> **Synchronization Rule**: Whenever you modify the tool stack (e.g., adding a new standard package, upgrading a tool version, or retiring an outdated package), **you must update both `doctor.sh` and `doctor.ps1`** to keep them in lockstep:
> - **Additions**: Add the tool to the core required/active toolstack check.
> - **Retirements**: Add the tool to the retired tool list with a recommendation/command for its clean uninstallation.
> - **Work/Corporate Tools**: Add/maintain these within the `--work` / `-Work` parameter blocks.
