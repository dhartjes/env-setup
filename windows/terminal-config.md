# Configure Terminal

## Path to settings file

Currently found at %LocalAppData%/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json

## To Backup

```pwsh
$settingsPath = Join-Path $env:LOCALAPPDATA "Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
$backupPath = "\\wsl$\Ubuntu\home\dhartjes\projects\env-setup\windows-setup\windows-terminal\"

# Ensure the destination folder exists
if (-not (Test-Path $settingsPath)) {
    Write-Host "Error backing up file: no file found at $settingsPath"
    New-Item -Path $destinationFolder -ItemType Directory -Force | Out-Null
}

if (-not (Test-Path $backupPath)) {
    Write-Host "No such path as $backupPath. Creating..."
    New-Item -Path $backupPath -ItemType Directory -Force | Out-Null
}

copy-item $settingsPath\settings.json $backupPath\settings.json
```

## To Restore

```pwsh
$settingsPath = Join-Path $env:LOCALAPPDATA "Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
$backupPath = "\\wsl$\Ubuntu\home\dhartjes\projects\env-setup\windows-setup\windows-terminal\"

# Ensure the destination folder exists
if (-not (Test-Path $settingsPath)) {
    Write-Host "No such path as $settingsPath. Creating..."
    New-Item -Path $settingsPath -ItemType Directory -Force | Out-Null
}

if (-not (Test-Path $backupPath)) {
    Write-Host "No such path as $backupPath. Creating..."
    New-Item -Path $backupPath -ItemType Directory -Force | Out-Null
}

copy-item $backupPath\settings.json $settingsPath\settings.json
```

## Links

<https://pureinfotech.com/backup-restore-settings-windows-terminal/>
