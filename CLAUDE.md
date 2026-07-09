# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a personal developer workstation setup guide — a documentation-only repository with no build system, tests, or compiled code. It is a runbook for provisioning a fresh Windows 11 machine as a keyboard-centric, terminal-first developer environment.

## Setup Sequence

The intended order matters when following this guide on a fresh machine:

1. **WinGet** (`windows/winget/`) — verify package manager works first
2. **PowerShell 7** (`windows/powershell-setup.md`) — required before WSL and most Windows steps
3. **WSL2** (`windows/wsl/`) — foundation for all Linux-side tooling
4. **Git** (`wsl/git/`) — source control and authentication
5. **Homebrew** (`wsl/homebrew/`) — required for tree-sitter-cli (LazyVim Treesitter)
6. **Neovim** (`wsl/nvim/`) — terminal editor via Bob version manager
7. **Node.js** (`wsl/volta-install.md`) — via Volta version manager
8. **VS Code** (`windows/vscode/`) — editor with WSL integration
9. **Claude Code** (`wsl/claude-install.md`) — AI coding assistant in VS Code + WSL

Other setups (`wsl/python/`, `windows/docker.md`, `windows/ditto/`, etc.) are independent of this sequence.

## Workspace Layout

The VS Code workspace (`env-setup.code-workspace`) mounts two folders:
- The repo root (`env-setup/`)
- The Windows Terminal state directory (`LocalState/`) — so terminal settings can be edited and backed up as part of this repo

The live Windows Terminal settings live at `windows/terminal/settings.json`, which maps to the mounted `LocalState/` folder.

## Key Architectural Decisions Documented Here

- **Git authentication**: Uses Git Credential Manager (GCM) with Microsoft Entra ID (MSAL), not SSH keys. Requires .NET SDK 8.0, systemd in WSL2, and gnome-keyring-daemon for token persistence. The deprecated SSH approach is kept in `wsl/git/git-auth.md` for reference.
- **Node version management**: Volta (not nvm or asdf).
- **Neovim version management**: Bob (not manually installed).
- **AI models**: Claude Code for coding.

## Navigation Pattern

Sequential files in a section use `<-- Prev` / `--> Next` links at the bottom. Files not in the main sequence use `<-- Top: [Back to Readme](README.md)`. Files with 3+ H2 sections include a table of contents.

## Editing Guidelines

All content is Markdown. When updating setup instructions:
- Commands should be copy-pasteable as-is (no placeholders like `<your-value>` unless unavoidable).
- Preserve the setup sequence rationale — note prerequisites explicitly.
- The `.planning/` directory holds future planned sections (Dev Containers, Remote SSH) that are not yet implemented — do not treat these as current documentation.
