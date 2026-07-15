# Frontend Application Tools Setup

<-- [Back to CFG README](README.md)

Node.js and Grunt are required before building the Admin Console or starting Spire. Install them once here; both steps reference this file as a prerequisite.

## Tool versions

The Admin Console frontend (classic CMS) uses **Dart Sass** via npm — no Ruby or Compass required, despite what the Optimizely Classic CMS docs say. The project pins Node 22.12.0 via `.node-version`.

| Tool | Version | Notes |
| --- | --- | --- |
| Node.js | 22.12.0 | pinned in `.node-version` |
| grunt-cli | latest global | task runner CLI |
| sass | 1.82.0 | Dart Sass, installed via `npm install` |
| grunt-sass | 3.1.0 | installed via `npm install` |

## Install Node.js

[mise](https://mise.jdx.dev) is the preferred version manager. It reads `.node-version` and switches automatically when you enter the project directory.

### Install mise

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

### Install Node.js via mise

```powershell
mise use --global node@lts
node --version
```

When you `cd` into `InsiteCommerce.Web`, mise will switch to Node 22.12.0 automatically.

### Option B — Direct install (no version manager)

If mise is blocked by policy, install Node 22 directly:

```powershell
winget install OpenJS.NodeJS.LTS
```

Verify:

```powershell
node --version
npm --version
```

## Install Grunt CLI

```powershell
mise use --global npm:grunt-cli
```

Verify:

```powershell
grunt --version
```

## Build the Admin Console frontend

From inside `InsiteCommerce.Web`:

```powershell
npm install
grunt build
```

`grunt build` compiles all `.scss` files in `Themes/` and `Styles/` to `.css`. For watch mode during active development:

```powershell
grunt
```

<-- Prev: [SSMS Setup](database/ssms-setup.md)
--> Next: [Admin Console](admin-console.md)
