# Powershell Setup
PowerShell 7 is vastly preferred over Windows PowerShell. It can be downloaded via WinGet.

## Check
PowerShell 7 may have come pre-installed. To check:
1. Launch terminal by opening the Windows Start Menu and typing 'terminal'
1. The new tab dropdown should show what terminals are currently available on your system
1. Note that PowerShell 7 has a dark blue icon, not light blue for "Windows PowerShell" or "Windows PowerShell x86"

<img width="1471" height="762" alt="image" src="https://github.com/user-attachments/assets/5ba7f31b-b2cf-4c3f-8f3a-3d7d53a7e05d" />

## Installation  
Launch a "Windows PowerShell" administrator prompt by right clicking on "Windows PowerShell" in the terminal drop down and click then click "Run as Administrator"
```winget install --id Microsoft.PowerShell --source winget```

## Troubleshooting
It's possible installing this via winget in a non-administrator session is preferred based on group policy.
