# Mise Tools (WSL)

<-- [Back to README](../../README.md) | [Install mise](mise-install.md)

General-purpose tools installed and managed via `mise` on WSL. You can register and install all your global workstation tools using `mise`.

> [!TIP]
> If you have cloned [ubuntu-config](../git/git-clone-repos.md) and run `./setup.sh`, your global toolchain and automation tasks are already configured in `~/.config/mise/config.toml`. Simply run `mise install` to install all pinned tools at once!

## Node.js

```bash
mise use --global node@lts
node -v
```

## Python (Recommended fallback for Pyenv)

```bash
mise use --global python@3.13
python --version
```

## Neovim

```bash
mise use --global neovim@stable
nvim --version
```

## GitHub CLI (gh)

```bash
mise use --global gh@latest
gh --version
```

## Python Package Manager (uv)

```bash
mise use --global uv@latest
uv --version
```

## Tree-Sitter CLI (npm Globals)

`mise` can manage globally installed npm packages natively:

```bash
# Install Tree-Sitter (required for LazyVim)
mise use --global npm:tree-sitter-cli
tree-sitter --version
```

## AI Coding Assistants

Depending on whether you are setting up your personal or work machine, configure the appropriate AI assistant:

### Option A: Google Antigravity CLI (Personal / Home Setup Only)

Google Antigravity (`agy`) is pre-installed on your home environment. To run and configure:

```bash
agy
```

### Option B: Claude Code (OPTIONAL - Work Setup Only)

For corporate work environments, install Claude Code via `mise`'s global npm manager:

```bash
mise use --global npm:@anthropic-ai/claude-code
claude --version
```

## Global Automation Tasks

Your global `~/.config/mise/config.toml` includes automation tasks defined under `[tasks]`:

### Format Markdown Files (`format`)

Format all Markdown files in a target directory (and its subdirectories) using the Neovim + Conform pipeline:

```bash
mise run format <path/to/folder>
# or shorthand:
mise r format <path/to/folder>
```

_(Omit the folder argument to format the current directory)._

<-- Prev: [Install mise](mise-install.md)
--> Next: [Tree-Sitter](../tree-sitter-install.md)
