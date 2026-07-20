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

### Set TypeScript version to workspace version

> **Important:** This only works when you open `src\FrontEnd` directly in VS Code — not the entire solution root.

Setting the TypeScript version to the workspace version improves performance and aligns the errors shown in the editor with those from the build.

1. Open any `.ts` or `.tsx` file.
2. Click the TypeScript version shown in the lower-right status bar.
3. A prompt appears at the top of the screen — choose **Select TypeScript Version**.
4. Choose **Use Workspace Version**.

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
