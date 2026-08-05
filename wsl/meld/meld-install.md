# Meld Installation (WSL/Ubuntu)

<-- [Back to README](../../README.md)

Meld is a visual diff and merge tool. Install it on WSL so git can invoke it as a difftool and mergetool from the terminal.

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install meld
```

Verify:

```bash
meld --version
```

<-- Prev: [Python VS Code](../python/python-vscode.md)
--> Next: [Meld Configuration (WSL)](meld-config.md)
