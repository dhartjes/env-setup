# New computer setup

## Goal

A developer workstation with my favorite tools enabled. Preference for keyboard
over mouse, Terminal over Windows, Node before Python before .NET, careful
organization over controlled chaos, documentation, context, caching, reuse, and AI as a last resort.

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
1. [Windows Terminal](windows/terminal/terminal-setup.md) — set default profile and startup behavior
1. [WSL2 Installation](windows/wsl/wsl-install.md) - Ubuntu on Windows; run via PowerShell as administrator

### Developer tools

1. [Git Install](wsl/git/git-install.md)
1. [Git Configuration](wsl/git/git-config.md)
1. [Git Authentication](wsl/git/git-auth.md) — GitHub CLI via HTTPS (Recommended) or GCM with Entra ID (**OPTIONAL**: Work only)
1. [Clone Repos](wsl/git/git-clone-repos.md)
1. [mise (Polyglot Tool Manager)](wsl/mise-install.md) — replaces Volta, Bob, and Pyenv (see [Migrating to mise](migrations/migrate-to-mise.md) if upgrading from an older setup)
1. [Tree-Sitter](wsl/tree-sitter-install.md) — via mise
1. [Python & uv](wsl/python/python-setup.md) — Python runtime and package/dependency management via mise and uv
1. [SQLite & Harlequin](wsl/python/python-setup.md) — Database CLI utilities (SQLite3 and Harlequin SQL TUI)
1. [Meld Installation (WSL)](wsl/meld/meld-install.md) — visual diff and merge tool
1. [Meld Configuration (WSL)](wsl/meld/meld-config.md) — configure as git difftool/mergetool
1. [Meld Installation (Windows)](windows/meld/meld-install.md)
1. [Meld Configuration (Windows)](windows/meld/meld-config.md)
1. [Neovim](wsl/nvim/nvim-install.md) — via mise

### Editor and AI

1. [VS Code Install](windows/vscode/vscode-install.md)
1. [VS Code Extensions](windows/vscode/vscode-extensions.md)
1. [Google Antigravity](google-antigravity.md) — AI coding assistant in terminal (**RECOMMENDED**: Home only)
1. [Claude Code](wsl/claude-install.md) — AI coding assistant in VS Code + WSL (**OPTIONAL**: Work only)

### Database tools (**OPTIONAL**: Work setup only)

1. [Rancher Desktop](windows/rancher-desktop.md) — Docker daemon for running SQL Server and other services in containers
1. [SSMS](windows/ssms-install.md) — SQL Server Management Studio
1. [DBeaver](windows/dbeaver-install.md) — SQL query tool for Infor Data Fabric via JDBC
1. [LINQPad 5](windows/linqpad5-install.md) — .NET 4.8 query tool for legacy codebases

### Optimizely Configured Commerce (**OPTIONAL**: Work setup only)

[Configured Commerce local dev setup](optimizely/cfg/README.md) — container stack, .NET projects, and branch structure for Wausau's CC repositories.

---

## Backup and Restore

| Tool | Guide |
| --- | --- |
| WSL instance backup/restore | [backup-and-restore/wsl.md](backup-and-restore/wsl.md) |
| GnuPG backup/restore | [backup-and-restore/gnupg.md](backup-and-restore/gnupg.md) |
| pass backup/restore | [backup-and-restore/pass-transfer.md](backup-and-restore/pass-transfer.md) |
| Neovim backup/restore | [backup-and-restore/neovim.md](backup-and-restore/neovim.md) |
| Windows Terminal backup/restore | [backup-and-restore/windows-terminal.md](backup-and-restore/windows-terminal.md) |

---

## Optional setup

| Tool | Guide |
| --- | --- |
| Python | [wsl/python/python-setup.md](wsl/python/python-setup.md) |
| Windows settings | [windows/windows-settings.md](windows/windows-settings.md) |
| Ditto clipboard manager | [windows/ditto/ditto-setup.md](windows/ditto/ditto-setup.md) |
| Keyboard (Anne Pro 2) | [windows/peripherals/keyboard-setup.md](windows/peripherals/keyboard-setup.md) |
| Mouse (Magic Trackpad 2) | [windows/peripherals/mouse-setup.md](windows/peripherals/mouse-setup.md) |
| Microsoft Edge | [windows/edge-setup.md](windows/edge-setup.md) |
| Default text editor | [windows/text-editor.md](windows/text-editor.md) |
| Google Antigravity (personal PC) | [google-antigravity.md](google-antigravity.md) |

## Setup Doctor

This repo contains a `doctor.ps1` and a `doctor.sh` script for checking your completed environment for alignment with these setup instructions.

• Active Tool Alignment: Checks for the existence and activation of mise, node, python, nvim, gh, tree-sitter-cli, and claude. If installed but not managed by mise, it suggests migrating them to mise.
• Retired Tool Detection: Scans the environment for conflicting or deprecated tools and provides exact commands to remove them. This includes checking for:
    • bob (Neovim manager)
    • pyenv (Python manager)
    • volta & fnm (Node managers)
    • nvm & asdf
    • Homebrew (on WSL)
• Authentication Check: Verifies that your Git global configuration is set to use the modern GitHub CLI (gh) as your
credential helper.

### Optional Work-Specific Inspection (--work / -Work)

If passed, the scripts inspect requirements specific to your corporate setup:

• Linux/WSL: Checks for the .NET SDK 8.0, Git Credential Manager (GCM), gpg, pass, GNOME Keyring daemon status, and GCM's credential store bindings.
• Windows: Checks for IIS (Internet Information Services Windows Feature), .NET Framework 4.8 registry presence, Rancher Desktop (or active Docker daemon), SSMS (SQL Server Management Studio), and DBeaver.
• If the work flag is omitted, all enterprise database, IIS, and GCM/.NET checks are gracefully bypassed.

### 💻 How to Run the Scripts

#### 🟢 On a Personal / Home Machine (Standard Checks Only)

```bash
./doctor.sh
```

```pwsh
.\doctor.ps1
```

#### 🏢 On a Work Machine (Includes GCM, .NET, IIS, and Databases)

```bash
./doctor.sh --work
```

```pwsh
.\doctor.ps1 -Work
```

---

## Contributing / Adding New Docs

See [`.claude/adding-new-docs.md`](.claude/adding-new-docs.md) for the full guide on adding new setup sections — doc template, navigation chain wiring, Windows constraints, and doctor script sync rules.
