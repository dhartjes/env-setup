# Windows Terminal Setup

<-- [Back to README](../../README.md)

## Settings

Open the Settings JSON file by holding Shift when clicking Settings in the main terminal dropdown.

Recommended changes:

- Set the default startup profile to **Ubuntu**
- In **Settings > Startup**, set "Launch on machine startup" to **On**

Settings are backed up in this repo — see [Backup and Restore](../../backup-and-restore/windows-terminal.md).

## Customize Prompt

Install Oh My Posh for a custom prompt: <https://learn.microsoft.com/en-us/windows/terminal/tutorials/custom-prompt-setup>

### Font configuration:

> Note: Font installation is still a manual process — no reliable WinGet option for Nerd Fonts.

| App | Font | Additional Appearance Setting Changes |
|-|-|-|
|VS Code|FiraCode Nerd Font|Ligatures enabled, Ligatures in Terminal enabled|
|Ubuntu|UbuntuSansMono Nerd Font Mono|Size 12|
|PowerShell|CaskaydiaMono Nerd Font Mono||

## Hotkeys

| Hotkey | Command |
|--------|---------|
| Ctrl+Shift+P | Command palette |
| Alt+Shift++ | New vertical pane |
| Alt+Shift+- | New horizontal pane |
| Ctrl+Shift+T | New tab with default profile |
| Ctrl+Shift+C | Copy from the command line |

<-- Prev: [PowerShell Setup](../powershell-setup.md)
--> Next: [WSL2 Installation](../wsl/wsl-install.md)
