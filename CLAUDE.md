# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a personal developer workstation setup guide — a documentation-only repository with no build system, tests, or compiled code. It is a runbook for provisioning a fresh Windows 11 machine as a keyboard-centric, terminal-first developer environment.

## Setup Sequence

The intended order matters when following this guide on a fresh machine:

1. **WSL2** (`windows-setup/wsl/`) — foundation for everything else
2. **Git** (`git-setup/`) — source control and authentication
3. **Neovim** (`nvim/`) — terminal editor via Bob version manager
4. **Node.js** (`npm-setup/`) — via Volta version manager
5. **Claude Code** (`claude-setup/`) — AI coding assistant in VS Code + WSL
6. **Molt** (`molt-setup/`) — Gemini-based general assistant via WhatsApp

Other setups (Python, Docker, Windows Terminal, VS Code extensions, keyboard, mouse) are independent of this sequence.

## Workspace Layout

The VS Code workspace (`env-setup.code-workspace`) mounts two folders:
- The repo root (`env-setup/`)
- The Windows Terminal state directory (`LocalState/`) — so terminal settings can be edited and backed up as part of this repo

The live Windows Terminal settings live at `windows-setup/windows-terminal/settings.json`, which maps to the mounted `LocalState/` folder.

## Key Architectural Decisions Documented Here

- **Git authentication**: Uses Git Credential Manager (GCM) with Microsoft Entra ID (MSAL), not SSH keys. Requires .NET SDK 8.0, systemd in WSL2, and gnome-keyring-daemon for token persistence. The deprecated SSH approach is kept in `git-setup/git-authentication.md` for reference.
- **Node version management**: Volta (not nvm or asdf).
- **Neovim version management**: Bob (not manually installed).
- **AI models**: Claude Code for coding; Molt (Gemini Flash-Lite) for general tasks via WhatsApp — chosen for efficiency and environmental impact.
- **Brave Search API**: Used by Molt with a 1 req/sec limit and $5 usage cap configured in `molt-setup/configure-brave-for-search.md`.

## Editing Guidelines

All content is Markdown. When updating setup instructions:
- Commands should be copy-pasteable as-is (no placeholders like `<your-value>` unless unavoidable).
- Preserve the setup sequence rationale — note prerequisites explicitly.
- The `.planning/` directory holds future planned sections (Dev Containers, Remote SSH) that are not yet implemented — do not treat these as current documentation.
