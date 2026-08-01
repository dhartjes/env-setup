# Install mise (Polyglot Tool Manager)

<-- [Back to README](../README.md)

`mise` (pronounced "meez") is a polyglot version manager and task runner. In this repository, it acts as the centralized system to manage Node.js, Python, Neovim, and the GitHub CLI. It replaces Volta, Pyenv, and Bob with a single, fast tool.

---

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

---

## 3. Install Core Workspace Tools

You can register and install all your global workstation tools using `mise`.

### Node.js

```bash
mise use --global node@lts
node -v
```

### Python (Recommended fallback for Pyenv)

```bash
mise use --global python@3.13
python --version
```

### Neovim

```bash
mise use --global neovim@stable
nvim --version
```

### GitHub CLI (gh)

```bash
mise use --global gh@latest
gh --version
```

### Tree-Sitter CLI & Claude Code (npm Globals)

`mise` can manage globally installed npm packages natively:

```bash
# Install Tree-Sitter (required for LazyVim)
mise use --global npm:tree-sitter-cli
tree-sitter --version

# Install Claude Code (AI coding assistant)
mise use --global npm:@anthropic-ai/claude-code
claude --version
```

---

## Source

- [Official mise Documentation](https://mise.jdx.dev/getting-started.html)

<-- Prev: [Clone Repos](git/git-clone-repos.md)
--> Next: [Tree-Sitter](tree-sitter-install.md)
