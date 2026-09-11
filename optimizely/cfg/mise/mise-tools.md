# Configured Commerce Mise Tools

<-- [Back to CFG README](../README.md)

Assumes `mise` itself is already installed — see [Install mise (Windows)](../../../windows/mise/mise-install.md) if not. This page covers only what's specific to Configured Commerce; general-purpose tools (Python, Neovim, GitHub CLI, etc.) are documented generically in [Mise Tools (Windows)](../../../windows/mise/mise-tools.md), not here.

> [!IMPORTANT]
> **wausausupply's `mise.toml` (repo root) is a custom addition, not an out-of-the-box Configured Commerce file.** It was hand-built (Dominic + Claude) on top of the vendor-supplied `insite-commerce-cloud` base — Optimizely's own template ships no `mise.toml` at all. It's git-tracked, so normal history/diffing protects it, but a bad upstream vendor sync or merge could plausibly clobber or conflict with it since nothing about it is expected by Optimizely's tooling. This page is the from-scratch reference: what it contains and why, so it can be rebuilt if it's ever lost or damaged.

## Node.js

Node is required for building and running **Spire** (the React storefront) — it is **not** needed for the Admin Console; see [Admin Console](../admin-console/admin-console.md).

`mise.toml` pins `node = "22.12.0"` under `[tools]` at the repo root. mise installs and activates that exact version automatically the first time you `cd` into the repo (or open it in VS Code / a terminal that runs mise's shell hook) — no manual `mise use --global node@...` needed for this project.

## `mise.toml` tasks reference

Everything below is defined in `[tasks.*]` blocks in the repo-root `mise.toml`, run as `mise run <name>` (or its alias, e.g. `mise run b`) from anywhere in the repo. Several wrap a PowerShell script in `tools/` rather than a bare command — those are noted below, since if `mise.toml` is lost, the scripts it calls still need to exist for it to mean anything.

| Task | Alias | What it does |
| --- | --- | --- |
| `build` | `b` | `dotnet build src/InsiteCommerce.Web/InsiteCommerce.Web.csproj -c Debug` |
| `release` | `r` | Runs `dist/buildextensions.ps1` to produce a Release build of `Extensions.dll` |
| `build-spire` | `bs` | `npm run build` in `src/FrontEnd` (wrapper to avoid `cd`-ing) |
| `start` | `s` | Starts the Spire dev server directly: `node startDevelopment.js wausauCustomBlueprint` in `src/FrontEnd` |
| `fix-relay-fetch-start` | `frfs` | Runs `tools/startSpireDev.ps1` — applies the Relay.ts native-fetch patch, starts Spire, and reverts Relay.ts to its committed state on exit (even on Ctrl+C) |
| `fix-relay-fetch` | `frf` | Runs `relay-fix-apply` — (re)applies the patch standalone, useful for testing it still applies after a vendor sync |
| `fix-relay-fetch-reset` | `frfr` | Runs `relay-fix-revert` — manually reverts `Relay.ts` to HEAD, a standalone escape hatch |
| `relay-fix-apply` | — (hidden) | Runs `tools/relayFixApply.ps1` — applies `patches/relay-native-fetch-fix.patch` to `src/FrontEnd/modules/server-framework/src/Relay.ts`, or no-ops if the fix is already present |
| `relay-fix-revert` | — (hidden) | `git checkout -- src/FrontEnd/modules/server-framework/src/Relay.ts` |
| `start-iis-express` | `iis` | Runs `iisexpress.exe /config:.vscode/iisexpress/applicationhost.config /site:InsiteCommerceWeb` directly — no admin required (see [IIS Setup](../iis-setup.md)) |
| `start-iis-express-fast` | `iisf` | Runs `tools/startIisExpressNoDebug.ps1` — builds, flips `web.config`'s `<compilation debug>` to `false` first (skips batch-compile/JIT-optimization penalties), runs IIS Express directly with no debugger attached, then reverts `web.config` to HEAD on exit. This is what the `.vscode/tasks.json` task `Run Without Debugging (Fast)` runs, which is what VS Code's globally-remapped Ctrl+F5 invokes — see [IIS Setup](../iis-setup.md). |
| `iis-debug-off` | — (hidden) | Runs `tools/iisDebugFlagOff.ps1` — flips `web.config`'s `debug="true"` to `debug="false"`, or no-ops if already `false` |
| `iis-debug-restore` | — (hidden) | `git checkout -- src/InsiteCommerce.Web/Web.config` |
| `ensure-dev-containers` | `edc` | Runs `tools/ensureDevContainers.ps1` — starts Rancher Desktop if it isn't running (via `rdctl start`, polling until the container engine responds), then `docker compose up -d --wait` for `mssql`, `mailhog`, `elasticsearchnext` |
| `setup-hooks` | `hooks` | One-time: `git config core.hooksPath .githooks` — points git at the repo's tracked hooks (blocks committing/pushing base-code changes to `sandbox` from any branch) |
| `recycle-app-pool` | `rap` | Touches `src/InsiteCommerce.Web/web.config`'s last-write time to force an AppDomain restart, without a real edit |

### Why the "apply → run → revert on exit" pattern (`fix-relay-fetch-start`, `start-iis-express-fast`)

Both use a PowerShell `try`/`finally` rather than mise's `depends`/`depends_post`, because on Windows `depends_post` does not run when the task is stopped via Ctrl+C or a VS Code debug-session stop (confirmed empirically 2026-08-25) — `finally` does. The pattern exists so a working tree edit needed only transiently (a patched `Relay.ts`, or `web.config` with debug off) never gets left dirty or accidentally committed if the dev server is just killed rather than exited cleanly.

## Troubleshooting

See [Troubleshooting: Mise Tools](mise-tools-troubleshooting.md).

<-- Prev: [Admin Console](../admin-console/admin-console.md)
--> Next: [Spire Setup](../spire/spire-setup.md)
