# Python setup

<-- [Back to README](../../README.md)

Python can be installed either via standard system packages (simple, tracks OS) or via a tool manager like **mise** (recommended for project-specific version control).

> [!NOTE]
> **OPTIONAL (Personal / Work)**: Standard system Python (`apt`) is sufficient for basic scripting. If you need specific Python versions for different projects or want to avoid compile-from-source overhead, use **mise** (recommended).

## Option 1: Version Management via `mise` (Recommended)

Instead of using `pyenv` (which compiles from source and requires many build dependencies like `libssl-dev`), we use **mise** to download precompiled standalone Python binaries.

### Installation & Configuration

Since `mise` is already installed, you can activate the desired global version instantly:

```bash
# Install and set global Python version
mise use --global python@3.13

# Verify the version in use
python --version
```

### local/Project Version Control

If you have a project that requires a different Python version, you can pin it locally within that directory:

```bash
# Set a local python version for the current directory
mise use --local python@3.12
```

## Option 2: Standard Installation (Simple)

This installs the standard Ubuntu system package. It is appropriate for general-purpose scripting and tools that track the OS releases.

```bash
sudo apt update && sudo apt upgrade
sudo apt install -y python3 python3-pip python3-dev python3-venv build-essential
```

## Test

```bash
python --version
pip --version
```

## Source

- [Python installation](https://www.geeksforgeeks.org/python/how-to-install-python-on-linux/)
- [mise Python backend](https://mise.jdx.dev/lang/python.html)

--> Next: [Python VS Code](python-vscode.md)
