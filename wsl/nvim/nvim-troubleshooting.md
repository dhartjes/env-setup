# Neovim on WSL Troubleshooting

Copy/paste in Neovim gives the error: Clipboard: no provider

To Fix: 

To make Neovim copy/paste work in WSL, you need to connect Neovim’s internal registers to the Windows clipboard using a clipboard-aware provider — the easiest is to install win32yank and set vim.opt.clipboard = "unnamedplus".

1. Install win32yank on Windows

    ```pwsh
    winget install win32yank
    ```
1. Configure Neovim. In the .config/nvim/lua/config/options.lua file, add:

```lua
vim.opt.clipboard = "unnamedplus"
```
