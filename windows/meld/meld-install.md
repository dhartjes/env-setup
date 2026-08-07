# Meld Installation (Windows)

<-- [Back to README](../../README.md)

Install Meld on Windows so it can be used as a visual diff tool from PowerShell or Windows git clients.

## Install via WinGet

```pwsh
winget install Meld.Meld
```

## Add Meld to PATH

WinGet does not add Meld to your PATH automatically. Run the following in PowerShell to add it to your user PATH permanently:

```pwsh
[System.Environment]::SetEnvironmentVariable(
    "Path",
    [System.Environment]::GetEnvironmentVariable("Path", "User") + ";$env:LOCALAPPDATA\Programs\Meld",
    "User"
)
```

Restart your terminal, then verify:

```pwsh
meld --version
```

<-- Prev: [Meld Configuration (WSL)](../../wsl/meld/meld-config.md)
--> Next: [Meld Configuration (Windows)](meld-config.md)
