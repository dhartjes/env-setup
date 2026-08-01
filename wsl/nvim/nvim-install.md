# Getting/Updating NVIM

<-- [Back to README](../../README.md)

Your OS package manager may have very outdated releases of NVIM. We use **mise** to easily install Neovim and keep it up-to-date, replacing the need for separate version managers like Bob.

## Installation

Since `mise` is already installed, adding Neovim is a single command:

```bash
mise use --global neovim@stable
```

Verify with:

```bash
nvim --version
```

## Configuration

For the initial setup, we use LazyVim to configure Neovim.

> [!NOTE]
> `mise` automatically manages the PATH and environment configuration when activated via your shell hook, so there is no need for manual PATH hacks or separate auto-completions as required by other version managers.

<-- Prev: [Tree-Sitter](../tree-sitter-install.md)
--> Next: [Neovim Configuration with LazyVim](nvim-lazyvim-config.md)