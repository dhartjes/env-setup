# Spire Setup

<-- [Back to CFG README](README.md)

## Prerequisites

- Node.js and Grunt CLI installed — see [Frontend Tools Setup](frontend-tools-setup.md)

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
