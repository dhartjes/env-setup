# Troubleshooting Winget Installation

## Possible Issues
A number of symptoms can indicate that winget is not installed correctly, and these symptoms can differ depending on whether you are running winget in CMD, PowerShell, or Windows PowerShell.

1. [Data required by the source is missing](https://github.com/microsoft/winget-cli/issues/4799)
1. [An error occurred because a user was logged off](https://github.com/microsoft/winget-cli/issues/3862)
1. [An Install File could not be found](https://github.com/microsoft/winget-cli/issues/5714)

[Source](https://learn.microsoft.com/en-us/windows/package-manager/winget/troubleshooting), [Source 2](https://github.com/microsoft/winget-cli/tree/master/doc/troubleshooting)

## Fixes

### 1. Enable App Execution Alias 
Windows uses aliases to recognize short commands like winget. If this is off, CMD will not recognize the command even if it is installed. 
- Open Settings > Apps > Advanced app settings
- Click on App execution aliases
- Locate Windows Package Manager Client (winget.exe) and toggle it On

[Source](https://github.com/microsoft/winget-cli/issues/725), [Source 2](https://www.koskila.net/how-to-fix-the-term-winget-is-not-recognized-as-a-name-of-a-cmdlet-function-script-file-or-executable-program-in-windows/#:~:text=And%20while%20it%20MIGHT%20actually,That%20said...)

### 2. Register WinGet for the Administrator Profile
Sometimes WinGet is installed for the user but not registered for elevated sessions. You can force registration using PowerShell. 

Open PowerShell (Admin).
* Note: it is not important that PowerShell 7 be installed yet.*
Run the following command to register the App Installer:
```Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe```

### 3. Manually Add to System PATH 
If CMD still cannot find it, the folder containing the executable might be missing from your system's Environment Variables. 

Path to add: %UserProfile%\AppData\Local\Microsoft\WindowsApps.
To add it: Search for "Edit the system environment variables" in Start > Environment Variables > Select Path under System Variables > Edit > New > Paste the path. 

### 4. Reinstall from GitHub (Advanced) 
If the Microsoft Store version is corrupted, you can download the .msixbundle directly from the official WinGet GitHub releases and run it to repair the installation.

1. Navigate to the [WinGet CLI Releases](https://github.com/microsoft/winget-cli/releases) page on GitHub.
1. Under the Assets section of the latest release, download the file ending in .msixbundle (e.g., Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle).
1. Double-click the downloaded .msixbundle file to launch the Windows app installer wizard and follow the on-screen prompts.

*Note: Some systems may also require manual installation of dependencies like VCLibs or Microsoft UI Xaml if they are missing.*

### 5. Register the AppXManifest file
In Windows PowerShell:
```Add-AppxPackage -DisableDevelopmentMode -Register $(Resolve-Path "C:\Program Files\WindowsApps\Microsoft.Winget.Source_*\AppXManifest.xml") -Verbose```

### 6. Run the PowerShell repair module
In Windows PowerShell:
```
# Register NuGet as a package provider
Install-PackageProvider -Name NuGet -Force | Out-Null

# Install the WinGet Client Module
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null

# Run the WinGet repair module
Repair-WinGetPackageManager -Force -Latest
```

[Source](https://learn.microsoft.com/en-us/windows/package-manager/winget/troubleshooting)

### 7. If all else fails...
Give up and run winget in a non-administrator session. Wait to see if issues arise in the use of the tools.
