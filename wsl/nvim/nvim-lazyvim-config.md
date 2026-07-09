# LazyVim Setup

<-- [Back to README](../../README.md)

[LazyVim](https://www.lazyvim.org/) is a Neovim configuration distribution that provides a full IDE experience out of the box — LSP, completion, fuzzy find, formatting, and Git integration — with a large community and good documentation.

## Prerequisites

LazyVim requires a [Nerd Font](https://www.nerdfonts.com/) for icons to render correctly. Install one on the Windows side and configure your terminal to use it.

It also requires a few tools available in your WSL path:

```bash
sudo apt update && sudo apt upgrade
sudo apt install ripgrep fd-find
```

## Install

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

## Adding extras

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

### Current Extras

|Extra/Plugin Name|How to use|Description|Adoption Status|More Info|
|-|-|-|-|-|
|coding.blink|||LazyVim default|https://github.com/Saghen/blink.cmp|
|editor.snacks||A collection of QoL improvements for Nvim|LazyVim default|https://github.com/folke/snacks.nvim|
|editor.snacks_explorer|Open a directory in nvim or launch nvim with a directory argument|Snacks File Explorer|LazyVim default|https://github.com/folke/snacks.nvim/blob/main/doc/snacks.nvim-explorer.txt|
|editor.snacks_picker|Anytime a filepicker is shown. space-ff|Fast and modern file picker|LazyVim default|https://github.com/folke/snacks.nvim/blob/main/doc/snacks.nvim-picker.txt|
|editor.dial|<c-a> to increment <c-x> to decrement|Add or minus one to the number/word under cursor|Testing|https://www.lazyvim.org/extras/editor/dial|
|

<-- Prev: [Nvim Installation](nvim-install.md)
--> Next: [Volta / Node.js](../volta-install.md)