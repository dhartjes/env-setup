# Tree-Sitter Installation

<-- [Back to README](../README.md)

`tree-sitter-cli` is required for LazyVim's Treesitter integration to build and compile syntax trees. We manage this directly with **mise**, eliminating the need for heavy external package managers like Homebrew on both personal and work machines.

## Installation

Since you already have `node` and `npm` managed by `mise`, you can register `tree-sitter-cli` directly:

```bash
# Install tree-sitter-cli via npm using mise
mise use --global npm:tree-sitter-cli

# Verify installation
tree-sitter --version
```

---

## Why mise?

- **Zero overhead**: Avoids installing Homebrew, which can take 10-15 minutes and consume gigabytes of disk space on WSL.
- **Unified updates**: `tree-sitter-cli` is updated alongside your other global node packages via `mise`.

<-- Prev: [Clone Repos](git/git-clone-repos.md)
--> Next: [Neovim](nvim/nvim-install.md)
