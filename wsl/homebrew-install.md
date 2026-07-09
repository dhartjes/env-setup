# Homebrew Installation

<-- [Back to README](../README.md)

Homebrew is used to install `tree-sitter-cli`, which is required for LazyVim's Treesitter integration.

## Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the instructions in your terminal. At the end, Homebrew will print a "Next steps" section — run the two `eval` commands it shows to add `brew` to your current shell session and to your `~/.bashrc`.

Test with ```brew --version```.

## Install tree-sitter-cli

```bash
brew install tree-sitter
```

Verify with:

```bash
tree-sitter --version
```

<-- Prev: [Clone Repos](git/git-clone-repos.md)
--> Next: [Neovim](nvim/nvim-install.md)
