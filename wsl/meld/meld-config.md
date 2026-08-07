# Meld Configuration (WSL/Ubuntu)

<-- [Back to README](../../README.md)

Configure git to use Meld as the default diff and merge tool.

## Git configuration

Open your global git config:

```bash
git config --global -e
```

Add the following:

```ini
[diff]
        tool = meld
[difftool]
        prompt = false
[difftool "meld"]
        cmd = meld "$LOCAL" "$REMOTE"
[merge]
        tool = meld
        conflictstyle = diff3
[mergetool "meld"]
        cmd = meld "$LOCAL" "$MERGED" "$REMOTE" --output "$MERGED"
        # cmd = meld "$LOCAL" "$BASE" "$REMOTE" --output "$MERGED"
```

## Usage

```bash
# Compare working tree against HEAD
git difftool

# Resolve merge conflicts interactively
git mergetool
```

<-- Prev: [Meld Installation (WSL)](meld-install.md)
--> Next: [Meld Installation (Windows)](../../windows/meld/meld-install.md)
