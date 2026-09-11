# Install mise (WSL)

<-- [Back to README](../../README.md) | [Mise Tools](mise-tools.md) | [Migration Guide](../../migrations/migrate-to-mise.md)

`mise` (pronounced "meez") is a polyglot version manager and task runner. In this repository, it acts as the centralized system to manage Node.js, Python, Neovim, and the GitHub CLI. It replaces Volta, Pyenv, and Bob with a single, fast tool.

> [!IMPORTANT]
> **Migrating from Volta, NVM, fnm, Pyenv, or Bob?**
> Sourcing older version managers alongside `mise` will cause critical PATH conflicts, command hijacking, and terminal startup lag. You **must** completely uninstall those tools before using `mise`.
> Please read the [Migrating to mise Guide](../../migrations/migrate-to-mise.md#-wsl-migration-steps) before installing!

## 1. Install mise

```bash
curl https://mise.run | sh
```

## 2. Activate in shell

```bash
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
source ~/.bashrc
```

Verify:

```bash
mise --version
```

## Install tools

Once mise itself is installed and activated, see [Mise Tools (WSL)](mise-tools.md) to install Node, Python, Neovim, and the rest.

## Source

- [Official mise Documentation](https://mise.jdx.dev/getting-started.html)

<-- Prev: [Clone Repos](../git/git-clone-repos.md)
--> Next: [Mise Tools](mise-tools.md)
