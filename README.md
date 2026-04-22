# New computer setup

## Goal

A developer workstation with my favorite tools enabled. Preference for keyboard over mouse, Terminal over Windows, Node before Python before .NET, careful organization over controlled chaos, documentation, context, caching, reuse, and AI as a last resort.

## Requisites

- Fresh Windows 11 machine

## Contents

- [Setup sequence](#setup-sequence)
- [Optional setup](#optional-setup)

---

## Setup sequence

### Windows foundation

1. [WinGet](windows/winget/winget-install.md) — package manager; comes pre-installed on Windows 11, verify it works first
1. [PowerShell 7](windows/powershell-setup.md) — install via WinGet; required for WSL and most Windows setup steps
1. [WSL2](windows/wsl/wsl-setup.md) — Ubuntu on Windows; run via PowerShell as administrator
1. [WSL Config](windows/wsl/wsl-config.md) — enable systemd and configure the WSL environment

### Developer tools (in WSL)

5. [Git Install](git/git-installation.md)
1. [Git Configuration](git/git-configuration.md)
1. [Git Authentication](git/git-authentication.md) — GCM with Microsoft Entra ID
1. [Clone Repos](git/git-clone-repos.md)
1. [Neovim](nvim-install.md) — via Bob version manager
1. [Volta / Node.js](volta-install.md)

### Editor and AI

11. [VS Code Install](windows/vscode/vscode-install.md)
1. [VS Code Extensions](windows/vscode/vscode-extensions.md)
1. [Claude Code](claude-install.md) — AI coding assistant in VS Code + WSL

### AI assistant

14. [Molt: Choose a model](molt/which-model.md)
1. [Molt: Choose a channel](molt/which-channel.md)
1. [Molt: Install](molt/install-molt.md)
1. [Molt: Brave Search](molt/configure-brave-for-search.md)

---

## Optional setup

| Tool | Guide |
|---|---|
| Python | [python/python-setup.md](python/python-setup.md) |
| Docker | [windows/docker.md](windows/docker.md) |
| Windows Terminal | [windows/terminal/tips.md](windows/terminal/tips.md) |
| Terminal config backup | [windows/terminal-config.md](windows/terminal-config.md) |
| Windows settings | [windows/windows-settings.md](windows/windows-settings.md) |
| Ditto clipboard manager | [windows/ditto/ditto-setup.md](windows/ditto/ditto-setup.md) |
| Keyboard (Anne Pro 2) | [windows/keyboard-setup.md](windows/keyboard-setup.md) |
| Mouse (Magic Trackpad 2) | [windows/mouse/mouse-setup.md](windows/mouse/mouse-setup.md) |
| Microsoft Edge | [edge-setup.md](edge-setup.md) |
| Default text editor | [windows/text-editor.md](windows/text-editor.md) |
