# Getting/Updating NVIM

<-- [Back to README](../README.md)

Your OS package manager may have very outdated releases of NVIM. The Bob Neovim repo is a Neovim Package Manager meant to make it easy to get neovim and keep it up-to-date.

## Installation
1. Get Bob with ```curl -fsSL https://raw.githubusercontent.com/MordechaiHadad/bob/master/scripts/install.sh | bash```
1. Test with ```bob --version```

## Configuration
1. Enable shell auto-complete:
```
mkdir -p ~/.local/share/bash-completion/completions
bob complete bash >> ~/.local/share/bash-completion/completions/bob
```
1. Bob's add_neovim_binary_to_path option doesn't work if you don't use a .bash_profile file. I am currently only using .bashrc. When it asks if you'd like to automatically add neovim to your path, say no and it will give you the string that is needed to be added to your path in the .bashrc

## Usage
1. ```bob install stable```
1. ```bob use stable```
1. ```bob pin stable``` Pins it to a specific folder
1. ```nvim``` to launch nvim!

## LazyVim Setup

[LazyVim](https://www.lazyvim.org/) is a Neovim configuration distribution that provides a full IDE experience out of the box — LSP, completion, fuzzy find, formatting, and Git integration — with a large community and good documentation.

### Prerequisites

LazyVim requires a [Nerd Font](https://www.nerdfonts.com/) for icons to render correctly. Install one on the Windows side and configure your terminal to use it.

It also requires a few tools available in your WSL path:

```bash
sudo apt install ripgrep fd-find
```

### Install

Back up any existing Neovim config first, then clone the LazyVim starter:

```bash
# Back up existing config (skip if none)
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone the LazyVim starter
git clone https://github.com/LazyVim/starter ~/.config/nvim

# Remove the git history so you can manage it as your own repo
rm -rf ~/.config/nvim/.git
```

Then launch Neovim — LazyVim will automatically install all plugins on first start:

```bash
nvim
```

### Adding extras

LazyVim ships with optional "extras" for languages, tools, and UI tweaks. Enable them in `~/.config/nvim/lua/config/lazy.lua`:

```lua
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.lang.typescript" },  -- example extra
    { import = "plugins" },
  },
})
```

Run `:LazyExtras` inside Neovim for an interactive list of available extras.

<-- Prev: [Clone Repos](git/git-clone-repos.md)
--> Next: [Volta / Node.js](volta-install.md)