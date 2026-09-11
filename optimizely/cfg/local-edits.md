# Local Edits

<-- [Back to CFG README](README.md)

This is the single reference for everything about this repo's local setup that diverges from Optimizely's out-of-the-box Configured Commerce template — so a future you (or a fresh clone) can tell "what's actually customized here" without hunting through several setup docs. Assumes [Initial Build](initial-build.md) has already run — that's what creates `connectionStrings.config` and `AppSettings.config` from their `.default.config` templates in the first place. Three different kinds of divergence get grouped together here on purpose:

- **Gitignored, local-only files** — never committed, copied from a `.default.config`/`-base` template and then hand-edited per developer/environment (`connectionStrings.config`, `AppSettings.config`, `settings.js`).
- **Tracked files with a transient local modification that must never actually be committed** — the baseline file is normal, tracked, vendor-supplied content; a mise task temporarily edits it and reverts it on exit (`Web.config`'s debug flag, `Relay.ts`'s native-fetch patch).
- **Permanent, tracked, client-specific customizations** layered on top of the vendor baseline, which Optimizely's own tooling knows nothing about (`mise.toml`).

## InsiteCommerce.Web

### `connectionStrings.config` (gitignored — not tracked)

Copied from `connectionStrings.default.config` during a build (or manually, if you skip creating a database first — the file won't exist until the repo has been built once in its current location). Current local value:

```xml
<add name="Insite.Commerce" connectionString="Data Source=127.0.0.1;Initial Catalog=<clientUrl>.local.com;User ID=sa;Password=<unchanged>;MultipleActiveResultSets=true;" providerName="System.Data.SqlClient" />
```

In the `Initial Catalog`, <clientUrl> should be the desired URL name for the client you are working with. Out of convention, it is made to match the site's domain rather than the default template's `Insite.Commerce`. It is also the name given to the SQL Server database on bacpac import. See [SSMS Setup](database/ssms-setup.md) for how the database itself is populated, and its troubleshooting doc for what happens if this value doesn't match the database that's actually there. `sa` / `password` should match `docker-compose.yml`'s `MSSQL_SA_PASSWORD`.

If you ever rename your database (useful for having separate local production/sandbox/ADE databases side by side), update `Initial Catalog` here to match.

### `AppSettings.config` (gitignored — not tracked)

Copied from `appSettings.default.config`, then diverges in three places:

| Key | Default template | Local value | Why |
| --- | --- | --- | --- |
| `Environment__CertificatePassword` | *(key doesn't exist)* | the password from `InsiteIdentityPassword.txt` | Added manually — required for the IdentityServer signing certificate. See [IIS Setup → Generate the identity server certificate](iis-setup.md). |
| `Environment__ElasticsearchNextServerUrl` | *(key doesn't exist)* | `http://localhost:9200` | Added manually — required or Spire throws `"There is not currently a setting for 'Environment__ElasticsearchNextServerUrl' in the AppSettings section of your web.config."` at runtime. See [Spire Setup Troubleshooting](spire/spire-setup-troubleshooting.md). |
| `Logging__ElasticServerUrl` | `http://localhost:9201` | `http://localhost:9200` | Changed — the default template assumes port 9201, but `docker-compose.yml`'s `elasticsearchnext` service (the one actually running here) binds 9200. If you ever see a mismatch, check `docker ps` / `docker-compose.yml` for the real bound port rather than assuming 9200 or 9201. |

### `Web.config` (tracked — do not commit this modification)

`<compilation debug="true">` is temporarily flipped to `debug="false"` by the `iis-debug-off` mise task — used by `start-iis-express-fast` (alias `iisf`), which is what the VS Code `Run Without Debugging (Fast)` task runs, which is what the globally-remapped Ctrl+F5 invokes (see [IIS Setup](iis-setup.md)). This disables batch-compile/JIT-optimization overhead for a snappier non-debug run. It's reverted automatically via `iis-debug-restore` (`git checkout -- src/InsiteCommerce.Web/Web.config`) in the same task's PowerShell `finally` block, so it survives Ctrl+C or a killed debug session. If that task ever gets killed hard enough to skip even `finally`, or you edit `Web.config` by hand while testing, check `git status` and revert before committing.

### `mise.toml` (tracked, permanent — but still a client-specific addition, not out-of-the-box Configured Commerce)

Optimizely's own `insite-commerce-cloud` template ships no `mise.toml` at all — this one was hand-built (Dominic + Claude) on top of it. It's git-tracked, so normal history/diffing protects it day to day, but a bad upstream vendor sync or merge could plausibly clobber or conflict with it since nothing about it is expected by Optimizely's tooling. This is the from-scratch reference: what it contains and why, so it can be rebuilt if it's ever lost or damaged. (Formerly documented directly in [Mise Tools](mise/mise-tools.md), which now just points here.)

Everything below is defined in `[tasks.*]` blocks in the repo-root `mise.toml`, run as `mise run <name>` (or its alias, e.g. `mise run b`) from anywhere in the repo. Several wrap a PowerShell script in `tools/` rather than a bare command — those are noted below, since if `mise.toml` is lost, the scripts it calls still need to exist for it to mean anything.

| Task | Alias | What it does |
| --- | --- | --- |
| `build` | `b` | `dotnet build src/InsiteCommerce.Web/InsiteCommerce.Web.csproj -c Debug` |
| `release` | `r` | Runs `dist/buildextensions.ps1` to produce a Release build of `Extensions.dll` |
| `build-spire` | `bs` | `npm run build` in `src/FrontEnd` (wrapper to avoid `cd`-ing) |
| `start` | `s` | Starts the Spire dev server directly: `node startDevelopment.js <clientBlueprintName>` in `src/FrontEnd` |
| `fix-relay-fetch-start` | `frfs` | Runs `tools/startSpireDev.ps1` — applies the Relay.ts native-fetch patch, starts Spire, and reverts Relay.ts to its committed state on exit (even on Ctrl+C) |
| `fix-relay-fetch` | `frf` | Runs `relay-fix-apply` — (re)applies the patch standalone, useful for testing it still applies after a vendor sync |
| `fix-relay-fetch-reset` | `frfr` | Runs `relay-fix-revert` — manually reverts `Relay.ts` to HEAD, a standalone escape hatch |
| `relay-fix-apply` | — (hidden) | Runs `tools/relayFixApply.ps1` — applies `patches/relay-native-fetch-fix.patch` to `src/FrontEnd/modules/server-framework/src/Relay.ts`, or no-ops if the fix is already present |
| `relay-fix-revert` | — (hidden) | `git checkout -- src/FrontEnd/modules/server-framework/src/Relay.ts` |
| `start-iis-express` | `iis` | Runs `iisexpress.exe /config:.vscode/iisexpress/applicationhost.config /site:InsiteCommerceWeb` directly — no admin required (see [IIS Setup](iis-setup.md)) |
| `start-iis-express-fast` | `iisf` | Runs `tools/startIisExpressNoDebug.ps1` — builds, flips `web.config`'s `<compilation debug>` to `false` first (see `Web.config` above), runs IIS Express directly with no debugger attached, then reverts `web.config` to HEAD on exit. This is what the `.vscode/tasks.json` task `Run Without Debugging (Fast)` runs, which is what VS Code's globally-remapped Ctrl+F5 invokes — see [IIS Setup](iis-setup.md). |
| `iis-debug-off` | — (hidden) | Runs `tools/iisDebugFlagOff.ps1` — flips `web.config`'s `debug="true"` to `debug="false"`, or no-ops if already `false` |
| `iis-debug-restore` | — (hidden) | `git checkout -- src/InsiteCommerce.Web/Web.config` |
| `ensure-dev-containers` | `edc` | Runs `tools/ensureDevContainers.ps1` — starts Rancher Desktop if it isn't running (via `rdctl start`, polling until the container engine responds), then `docker compose up -d --wait` for `mssql`, `mailhog`, `elasticsearchnext` |
| `setup-hooks` | `hooks` | One-time: `git config core.hooksPath .githooks` — points git at the repo's tracked hooks (blocks committing/pushing base-code changes to `sandbox` from any branch) |
| `recycle-app-pool` | `rap` | Touches `src/InsiteCommerce.Web/web.config`'s last-write time to force an AppDomain restart, without a real edit |

#### Why the "apply → run → revert on exit" pattern (`fix-relay-fetch-start`, `start-iis-express-fast`)

Both use a PowerShell `try`/`finally` rather than mise's `depends`/`depends_post`, because on Windows `depends_post` does not run when the task is stopped via Ctrl+C or a VS Code debug-session stop (confirmed empirically 2026-08-25) — `finally` does. The pattern exists so a working tree edit needed only transiently (a patched `Relay.ts`, or `web.config` with debug off) never gets left dirty or accidentally committed if the dev server is just killed rather than exited cleanly.

## src/FrontEnd

### `settings.js` (gitignored — not tracked)

Copied from the tracked template `settings-base.js` (default `apiUrl: "http://commerce.local.com"`), then locally overridden:

```js
apiUrl: "http://<clientUrl>.local.com:8080",
```

Matches the IIS Express binding from [IIS Setup](iis-setup.md) / `.vscode/launch.json` (also gitignored — see IIS Setup for why). See [Spire Setup → Configure the API target](spire/spire-setup.md).

### `Relay.ts` native-fetch patch (tracked — do not commit this modification)

`src/FrontEnd/modules/server-framework/src/Relay.ts`'s `relayRequest` function, as vendored, calls `node-fetch`-specific APIs — `(result as any).buffer()` and `(result.headers as any).raw()` — that don't exist on a standard `fetch` `Response`. `patches/relay-native-fetch-fix.patch` swaps those for the standard-`fetch` equivalents (`Buffer.from(await result.arrayBuffer())`, and `getSetCookie()` for `set-cookie` headers specifically, since those can contain commas and can't go through the combined header value).

Applied by `relay-fix-apply` (used by `fix-relay-fetch-start`, the task behind `mise run frfs` — the normal way to start Spire) and always reverted to HEAD on exit via `relay-fix-revert` (`git checkout -- src/FrontEnd/modules/server-framework/src/Relay.ts`), the same try/finally pattern as `Web.config` above. Like `Web.config`, if the revert is ever skipped (hard-killed process, manual testing), check `git status` before committing — the patched `Relay.ts` should never land in a commit.

<-- Prev: [Initial Build](initial-build.md)
--> Next: [Admin Console](admin-console/admin-console.md)
