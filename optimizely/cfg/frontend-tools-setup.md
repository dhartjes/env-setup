# Frontend Application Tools Setup

<-- [Back to CFG README](README.md)

Node.js and Grunt are required before building the Admin Console or starting Spire. Install them once here; both steps reference this file as a prerequisite.

## Install Node.js

Volta is the preferred version manager for this project (it reads the `volta` pin in `package.json` automatically), but it may be blocked by organization policy. Choose one option:

### Option A — Volta (preferred)

```powershell
winget install Volta.Volta
```

Restart your terminal. Verify:

```powershell
volta --version
```

Volta will automatically download and activate the correct Node version the first time you run `npm install` or `npm run` inside a project with a `volta` pin in `package.json`.

If the project's `package.json` does not have a `volta` pin, install Node 22 explicitly:

```powershell
volta install node@22
```

### Option B — fnm (if Volta is blocked by policy)

[fnm](https://github.com/Schniz/fnm) (Fast Node Manager) is a cross-platform alternative with similar per-project version pinning via `.node-version` or `.nvmrc` files.

```powershell
winget install Schniz.fnm
```

Restart your terminal. Install Node 22:

```powershell
fnm install 22
fnm use 22
```

### Option C — Direct install (no version manager)

If both Volta and fnm are blocked, install Node directly:

```powershell
winget install OpenJS.NodeJS.LTS
```

Verify:

```powershell
node --version
npm --version
```

## Install Grunt CLI

Grunt is required to build the Admin Console frontend (AngularJS):

```powershell
npm install -g grunt-cli
```

Verify:

```powershell
grunt --version
```

<-- Prev: [SSMS Setup](database/ssms-setup.md)
--> Next: [Admin Console](admin-console.md)
