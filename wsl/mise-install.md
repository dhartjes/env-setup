# Install mise

<-- [Back to README](../README.md)

mise (pronounced "meez") is a polyglot version manager and task runner. It replaces per-language version managers like Volta, nvm, pyenv, and asdf with a single tool.

## Install

```bash
curl https://mise.run | sh
```

## Activate in shell

```bash
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
source ~/.bashrc
```

Verify:

```bash
mise --version
```

## Install Node.js

```bash
mise use --global node@lts
node -v
```

## Install Claude Code

mise can manage npm global packages directly:

```bash
mise use --global npm:@anthropic-ai/claude-code
claude --version
```

## Source

- <https://mise.jdx.dev/getting-started.html>

<-- Prev: [Neovim](nvim/nvim-lazyvim-config.md)
--> Next: [Claude Code](claude-install.md)
