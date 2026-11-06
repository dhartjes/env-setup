# Spire Setup

<-- [Back to CFG README](../README.md)

## Prerequisites

- Node.js installed — see [Mise Tools](../mise/mise-tools.md)

## Install frontend dependencies

```powershell
cd repoRoot\src\FrontEnd
npm install
```

## Configure the API target

By default, Spire forwards API requests to `http://commerce.local.com`. Change this to `http://<clientUrl>.local.com:8080`, the IIS Express port that is configured in <repo-root>/.vscode/launch.json (Not source controlled).

Edit `src\FrontEnd\config\settings.js`:

```js
apiUrl: 'http://<clientUrl>.local.com:8080',
```

## Start Spire

> **This normally happens when you press F5 or Ctrl+F5.** `.vscode/tasks.json`'s `Start Spire Dev Server` task is a dependency of both `Prepare Debug Session` (F5) and `Run Without Debugging (Fast)` (Ctrl+F5), so either one runs `mise run fix-relay-fetch-start` in a dedicated terminal panel alongside the rest of the launch (applies the Relay.ts native-fetch patch — see [Local Edits](../local-edits.md) — starts Spire, and reverts the patch when the server stops). Opening the folder does not start it. You generally won't need to run anything below by hand; it's here for when you want Spire without launching IIS Express, want to restart it manually, or want to understand what that terminal panel is doing.

```powershell
npm run start
```

Or from the repo root, without `cd`-ing into `src\FrontEnd`:

```powershell
mise run start
```

Navigate to `http://localhost:3000`.

A `mise run build-spire` task is likewise available from the repo root as a wrapper around `npm run build` — the underlying webpack build itself is unchanged, this just saves the `cd`.

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

## Troubleshooting

See [Troubleshooting: Spire Setup](spire-setup-troubleshooting.md).

<-- Prev: [Mise Tools](../mise/mise-tools.md)
