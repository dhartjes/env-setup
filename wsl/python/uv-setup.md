# UV Setup

`uv` is a modern and extremely fast Python package and project manager. We manage the `uv` tool directly through **mise** to simplify our global workstation setup.

## Installation

Since `mise` is already installed, adding `uv` to your environment is a single command:

```bash
mise use --global uv@latest
```

Verify installation:

```bash
uv --version
```

## Why managed by mise?

- **No Curl Scripts**: Avoids downloading random shell scripts to install system binaries.
- **Unified Updates**: Upgrading `uv` alongside Node, Python, and Neovim is as simple as running `mise upgrade`.