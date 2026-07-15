# Migration to mise — Future Phase

mise can replace several per-language version managers currently used in this setup. This document tracks what can be consolidated and what the migration path looks like.

## What mise replaces

| Current tool | Currently documented in | mise replacement |
| --- | --- | --- |
| Volta (Node.js, WSL) | `wsl/volta-install.md` | **Done** — replaced by `wsl/mise-install.md` |
| Volta/fnm (Node.js, Windows) | `optimizely/cfg/frontend-tools-setup.md` | **Done** — replaced by `winget install jdx.mise` |
| pyenv (Python) | `wsl/python/python-setup.md` | `mise use --global python@3.13` |
| Bob (Neovim) | `wsl/nvim/nvim-install.md` | `mise use --global neovim@stable` |
| Homebrew (tree-sitter-cli) | `wsl/homebrew-install.md` | `mise use --global npm:tree-sitter-cli` |

## Migration details

### Python via mise

The `wsl/python/python-setup.md` file currently documents two paths: `apt` (simple) and pyenv (version-controlled). Both can be replaced with mise:

```bash
# replaces: pyenv install 3.13.1 && pyenv global 3.13.1
mise use --global python@3.13
python --version
```

**Prerequisites removed:** No longer need the build dependencies (`libssl-dev`, `zlib1g-dev`, etc.) that pyenv requires to compile Python from source — mise downloads pre-built binaries.

**Consideration:** `apt install python3` installs the system Python tied to the Ubuntu release. This is still appropriate for scripts that should track the OS. Use mise Python for project-specific or version-pinned work.

### Neovim via mise

The `wsl/nvim/nvim-install.md` file uses Bob as a Neovim version manager. mise can manage Neovim directly:

```bash
# replaces: bob install stable && bob use stable
mise use --global neovim@stable
nvim --version
```

**Consideration:** Bob offers `bob pin` for locking to a specific version, and shell completion setup is already documented. mise covers both but the `.bashrc` path concern (noted in nvim-install.md) goes away since mise handles PATH via its activation hook. Verify that LazyVim's Treesitter still works after migration.

### tree-sitter-cli via mise (removing Homebrew dependency)

Homebrew is currently only used for `tree-sitter-cli`. If that is the only Homebrew package in use, Homebrew can be removed entirely:

```bash
# replaces: brew install tree-sitter
mise use --global npm:tree-sitter-cli
tree-sitter --version
```

**Impact on setup sequence:** Removes the Homebrew step from the main sequence, shortening onboarding. The `wsl/homebrew-install.md` file could then be moved to optional setup or deleted.

## Recommended migration order

1. **Python** — highest value; replaces both apt and pyenv paths with one tool and removes build dependency setup.
2. **tree-sitter-cli / Homebrew** — removes an entire tool from the sequence if Homebrew has no other uses.
3. **Neovim** — lowest urgency; Bob works fine and the migration needs a test pass to confirm LazyVim compatibility.

## Files to update when migrating

- `wsl/python/python-setup.md` — rewrite around `mise use --global python@<version>`
- `wsl/homebrew-install.md` — update or remove; redirect tree-sitter step to mise
- `wsl/nvim/nvim-install.md` — replace Bob steps with `mise use --global neovim@stable`
- `README.md` — remove Homebrew from the main sequence if it has no remaining uses
- `CLAUDE.md` — update setup sequence and architecture decisions sections
