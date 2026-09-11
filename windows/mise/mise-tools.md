# Mise Tools (Windows)

<-- [Back to README](../../README.md) | [Install mise](mise-install.md)

General-purpose tools installed and managed via `mise` on Windows. Project-specific tools (e.g. a pinned Node version for one repo) don't need anything here — they're picked up automatically from that project's own `mise.toml`/`.node-version`. See [Configured Commerce Mise Tools](../../optimizely/cfg/mise-tools.md) for what's specific to that project.

## Node.js

```powershell
mise use --global node@lts
node --version
```

## Neovim (optional)

This environment runs Neovim inside WSL by default — see [wsl/nvim/nvim-install.md](../../wsl/nvim/nvim-install.md), no separate Windows-side install needed unless you also use Neovim natively on Windows:

```powershell
mise use --global neovim@stable
nvim --version
```

<-- Prev: [Install mise](mise-install.md)
