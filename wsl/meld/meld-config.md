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

## Editor Preferences (GSettings)

> [!TIP]
> If you have cloned [ubuntu-config](../git/git-clone-repos.md) and run `./setup.sh`, these editor preferences are automatically applied.

Meld stores its GUI editing preferences in GNOME's GSettings database (`~/.config/dconf/user`). You can configure Meld to use 4-space indentation, insert spaces instead of tabs, show line numbers, and disable line wrapping:

```bash
gsettings set org.gnome.meld indent-width 4
gsettings set org.gnome.meld insert-spaces-instead-of-tabs true
gsettings set org.gnome.meld show-line-numbers true
gsettings set org.gnome.meld wrap-mode 'none'
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
