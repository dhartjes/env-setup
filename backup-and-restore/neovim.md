# Neovim Backup and Restore

Neovim configuration lives in `~/.config/nvim/`. If your config is already tracked in a git repository, that repo is your backup — just clone it on the new machine.

If your config is **not** in version control, use the steps below.

## Backup

```bash
cp -r ~/.config/nvim ~/nvim-config-backup
```

Also back up installed plugins if you want to avoid re-downloading them (optional — plugins reinstall automatically on first launch):

```bash
cp -r ~/.local/share/nvim ~/nvim-data-backup
```

## Restore

```bash
# Copy config into place
cp -r ~/nvim-config-backup ~/.config/nvim
```

Then open Neovim — your plugin manager (lazy.nvim, packer, etc.) will detect missing plugins and install them automatically on first launch.

## Recommended: track your config in git

The cleanest approach is to keep `~/.config/nvim/` as its own git repository. On a new machine:

```bash
git clone <your-nvim-config-repo> ~/.config/nvim
```

Then open Neovim and let the plugin manager run.

<-- Top: [Back to Readme](../README.md)
