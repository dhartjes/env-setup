# Winget Install Steps
This is the first step in PC setup. Winget is a single package manager for windows that covers almost all of the software needs I have on a Windows PC.

## Prereqs

Winget should come pre-installed with Windows 11.

## Testing
In terminal, launch a CMD, a Windows PowerShell, or a PowerShell session.
```winget -v```

## Installation
If missing, install via Windows Store (recommended by MS) or manually from GitHub. WinGet is distributed as part of the App Installer package. In most modern versions of Windows 10 and 11, simply updating this app through the store provides WinGet. The manual approach is described in [Winget Troubleshooting](.\troubleshooting.md).

1. Open the Microsoft Store and search for 'App Installer'.
1. Click Update or Get. If the button says "Open" it is already installed.

## Updating Winget
In CMD or PS:
```winget upgrade Microsoft.AppInstaller```

## Configuration

To retrieve list of winget applications from a former machine:
```winget export```

To install list of winget applications:
```winget import```

## 
