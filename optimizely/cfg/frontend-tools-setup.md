# Frontend Application Tools Setup

<-- [Back to CFG README](README.md)

Node.js is required before building the Admin Console or starting Spire. Install mise once here; it will manage Node versions per-project automatically based on each project's `.node-version` file — no global Node install needed.

## Install mise

```powershell
winget install jdx.mise
```

Activate mise in PowerShell by adding it to your profile:

```powershell
echo '(&mise activate pwsh) | Out-String | Invoke-Expression' >> $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
```

Restart your terminal. Verify:

```powershell
mise --version
```

mise will download and activate the correct Node version automatically the first time you `cd` into a project that has a `.node-version` file.

## Option B — Direct install (no version manager)

If mise is blocked by policy, install Node 22 directly:

```powershell
winget install OpenJS.NodeJS.LTS
```

Verify:

```powershell
node --version
npm --version
```

<-- Prev: [SSMS Setup](database/ssms-setup.md)
--> Next: [Admin Console](admin-console.md)
