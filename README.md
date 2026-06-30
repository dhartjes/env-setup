# New computer setup

## Goal

A developer workstation with my favorite tools enabled. Preference for keyboard over mouse, Terminal over Windows, Node before Python before .NET, careful organization over controlled chaos, documentation, context, caching, reuse, and AI as a last resort.

## Requisites

- Fresh Windows 11 machine

## Contents

- [Setup sequence](#setup-sequence)
- [Backup and Restore](#backup-and-restore)
- [Optional setup](#optional-setup)

---

## Setup sequence

### Windows foundation

1. [WinGet](windows/winget/winget-install.md) — package manager; comes pre-installed on Windows 11, verify it works first
1. [PowerShell 7](windows/powershell-setup.md) — install via WinGet; required for WSL and most Windows setup steps
1. [Windows Terminal](windows/terminal/tips.md) — set default profile and startup behavior
1. [WSL2](windows/wsl/wsl-setup.md) — Ubuntu on Windows; run via PowerShell as administrator
1. [WSL Config](windows/wsl/wsl-config.md) — enable systemd and configure the WSL environment

### Developer tools (in WSL)

5. [Git Install](wsl/git/git-installation.md)
1. [Git Configuration](wsl/git/git-configuration.md)
1. [Git Authentication](wsl/git/git-authentication.md) — GCM with Microsoft Entra ID
1. [Clone Repos](wsl/git/git-clone-repos.md)
1. [Neovim](wsl/nvim-install.md) — via Bob version manager
1. [Volta / Node.js](wsl/volta-install.md)

### Editor and AI

11. [VS Code Install](windows/vscode/vscode-install.md)
1. [VS Code Extensions](windows/vscode/vscode-extensions.md)
1. [Claude Code](wsl/claude-install.md) — AI coding assistant in VS Code + WSL

---

## Backup and Restore

| Tool | Guide |
|---|---|
| WSL instance backup/restore | [backup-and-restore/wsl.md](backup-and-restore/wsl.md) |
| GnuPG backup/restore | [backup-and-restore/gnupg.md](backup-and-restore/gnupg.md) |
| pass backup/restore | [backup-and-restore/pass-transfer.md](backup-and-restore/pass-transfer.md) |
| Neovim backup/restore | [backup-and-restore/neovim.md](backup-and-restore/neovim.md) |
| Windows Terminal backup/restore | [backup-and-restore/windows-terminal.md](backup-and-restore/windows-terminal.md) |

---
## Optional setup

| Tool | Guide |
|---|---|
| Python | [wsl/python/python-setup.md](wsl/python/python-setup.md) |
| Rancher Desktop | [windows/docker.md](windows/docker.md) |
| Windows settings | [windows/windows-settings.md](windows/windows-settings.md) |
| Ditto clipboard manager | [windows/ditto/ditto-setup.md](windows/ditto/ditto-setup.md) |
| Keyboard (Anne Pro 2) | [windows/peripherals/keyboard-setup.md](windows/keyboard-setup.md) |
| Mouse (Magic Trackpad 2) | [windows/peripherals/mouse-setup.md](windows/mouse/mouse-setup.md) |
| Microsoft Edge | [windows/edge-setup.md](edge-setup.md) |
| Default text editor | [windows/text-editor.md](windows/text-editor.md) |
| Google Antigravity (personal PC) | [google-antigravity.md](google-antigravity.md) |
