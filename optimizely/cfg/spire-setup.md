# Spire Setup

<-- [Back to CFG README](README.md)

## Install Node.js via Volta

Volta manages Node versions per-project, pinning the correct version via a `volta` key in `package.json`. This mirrors the approach used for Neovim versions on Linux (Bob) and Node versions in WSL (Volta) — one tool handles versioning so you never need to manually match versions between projects.

Install Volta once on Windows:

```powershell
winget install Volta.Volta
```

Restart your terminal. Verify:

```powershell
volta --version
```

Volta will automatically download and activate the correct Node version the first time you run `npm install` or `npm run` inside a project that has a `volta` pin in `package.json`. No manual `node install` is needed in that case.

If the project's `package.json` does not have a `volta` pin, install Node 22 explicitly:

```powershell
volta install node@22
```

## Install frontend dependencies

```powershell
cd C:\Users\Dominic.Hartjes\projects\wausausupply\src\FrontEnd
npm install
```

## Configure the API target

By default, Spire forwards API requests to `http://commerce.local.com`. Change this to match your local IIS binding.

Edit `src\FrontEnd\config\settings.js`:

```js
apiUrl: 'http://localhost:8080',
```

## Start Spire

```powershell
npm run start
```

Navigate to `http://localhost:3000`.

VS Code launch configurations are already present in the `/FrontEnd` directory. The **Run and Debug** panel will show a Spire launch option that runs `npm run start` without additional configuration.

## Launch with a custom blueprint

To run Spire using a custom blueprint instead of the default:

```powershell
npm run start {customBlueprintName}
```

## Site page generation

Pages generate automatically on the first request to the server if none are present. To force regeneration, run the following against the CC database in SSMS, then reload the site:

```sql
DELETE FROM content.Node
```

<-- Prev: [Admin Console](admin-console.md)
