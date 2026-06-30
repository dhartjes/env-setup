# Windows Terminal Backup and Restore

<-- [Back to README](../README.md)

## Overview

Windows Terminal settings are backed up by keeping `settings.json` in this repo at `windows/terminal/settings.json`. The VS Code workspace mounts the live `LocalState/` folder alongside the repo root, so settings can be edited and committed directly.

The live settings file is at:

```
%LocalAppData%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
```

## To Backup

Commit `windows/terminal/settings.json` to this repo after making changes in Windows Terminal.

## To Restore

Copy the backed-up settings file to the live location:

```pwsh
$settingsPath = Join-Path $env:LOCALAPPDATA "Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$backupPath = "\\wsl$\Ubuntu\home\dhartjes\projects\git\env-setup\windows\terminal"

Copy-Item "$backupPath\settings.json" "$settingsPath\settings.json"
```

## Links

<https://pureinfotech.com/backup-restore-settings-windows-terminal/>

<-- [Back to README](../README.md)
