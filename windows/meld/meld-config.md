# Meld Configuration (Windows)

<-- [Back to README](../../README.md)

Configure git on Windows to use Meld as the default diff and merge tool.

## Git configuration

Open your global git config:

```pwsh
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
        path = "C:\Users\Dominic.Hartjes\AppData\Local\Programs\Meld\meld.exe"
        cmd = meld "$LOCAL" "$MERGED" "$REMOTE" --output "$MERGED"
        # cmd = meld "$LOCAL" "$BASE" "$REMOTE" --output "$MERGED"
```

## Usage

```pwsh
# Compare working tree against HEAD
git difftool

# Resolve merge conflicts interactively
git mergetool
```

<-- Prev: [Meld Installation (Windows)](meld-install.md)
--> Next: [Neovim Installation](../../wsl/nvim/nvim-install.md)
