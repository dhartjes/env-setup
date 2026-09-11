# Changelog: optimizely/

Running history of documentation changes under `optimizely/`, aggregated into this one file rather than mirrored per-source-file. Entries are chronological (oldest first); each is headed with the date and the file(s) it's about.

## 2026-09-10 — `iis-setup.md`: rewritten around IIS Express instead of full IIS Manager

An earlier version of this doc described creating the site in full IIS Manager (Site Manager UI, app pool permissions, port bindings via IIS Manager). That was the wrong tool for this project — it actually runs on IIS Express, launched from VS Code (`launch.json`) or the repo-root `mise run start-iis-express*` tasks, never from full IIS. Rewrite covered: the gitignored `.vscode/launch.json` / `.vscode/iisexpress/applicationhost.config` needing to be rebuilt per machine; two config gotchas that broke a fresh setup (CLR app pools pointing at `%IIS_USER_HOME%\config\aspnet.config`, which only exists after IIS Express's legacy per-user first-run wizard, instead of `%IIS_BIN%\config\templates\PersonalWebServer\aspnet.config`; and the modern default template registering `AspNetCoreModule`/`AspNetCoreModuleV2` which crashes IIS Express entirely — `Error loading global modules. hr = 8007007e` — when the ASP.NET Core Hosting Bundle isn't installed); and the one-time elevated host setup (`netsh http add urlacl` + a hosts file entry) needed for the `wausau.local.com:8080` binding, independent of where the repo is cloned.

## 2026-09-10 — `admin-console.md`: removed the frontend build steps

Confirmed locally: no `npm install`, `grunt`, or TypeScript compile step is needed to make the Admin Console work. Two sections were removed:

- **"Build the frontend CSS"** — `npm install` + `npx grunt build` to compile `.scss` → `.css`.
- **"Build the Admin Console TypeScript"** — `npx tsc -p tsconfig.json` (or `mise run build-admin-ts`) to compile the Angular scripts under `_SystemResources/Themes/Responsive/Scripts`.

The corresponding `build-admin-ts` / `watch-admin-ts` mise tasks were also removed from wausausupply's `mise.toml`. The only thing that actually matters for the Admin Console rendering correctly is the `.css` MIME-type fix, still documented in the doc's own Troubleshooting → "Gigantic Opti logo" section (that one was never a workaround for a skipped build step — it's the actual fix).

## 2026-09-10 — `frontend-tools-setup.md`: rewritten, then superseded the same day

First pass: dropped the "Install mise" instructions (already covered generically outside CC setup) and corrected "required before Admin Console" — Node is only needed for Spire. Reordered the CC README's "Existing customer site" setup path so this step comes right before Spire instead of before Admin Console (SSMS → Admin Console → this step → Spire), with matching Prev/Next updates on `admin-console.md` and `spire-setup.md`. Also dropped a stray "Grunt CLI" mention from `spire-setup.md`'s prerequisites (Spire never needed grunt — that was always specific to the Admin Console CSS build removed above).

This whole file was superseded later the same day — see the mise doc restructuring entry below.

## 2026-09-10 — mise doc restructuring: `frontend-tools-setup.md` → `mise-tools.md`

Once the CC mise setup was confirmed fully working, `optimizely/cfg/frontend-tools-setup.md` was deleted and replaced by `optimizely/cfg/mise-tools.md`, containing only what's CC-specific (the `mise.toml`-pinned Node version, no manual `mise use --global` needed). README, `admin-console.md`, and `spire-setup.md` were updated to point at it instead.

`mise-tools.md` was later expanded with a full reference for wausausupply's root `mise.toml` — flagged as a **custom addition, not an out-of-the-box Configured Commerce file** (hand-built by Dominic + Claude, since Optimizely's own template ships no `mise.toml` at all), with every task documented (including the `tools/*.ps1` scripts each one calls) so it can be reconstructed if a vendor sync or merge ever damages it.

## 2026-09-11 — WIP-commentary cleanup pass

A full pass through every folder except `migrations/`, `.planning/`, `.claude/`, and `backup-and-restore/`, looking for content that reads as session narration or unfinished scratch work rather than documentation. This `.changelog/` convention was created as a result — a place to move that commentary to instead of deleting it or leaving it in the main docs.

- `iis-setup.md` — removed the "an earlier version of this doc described full IIS Manager" blockquote (see entry above, that's where it went) and a "both were hit and fixed while setting this up on a fresh machine (2026-09-10)" date-stamp (kept the actual gotcha content in place — it's real setup instruction, not history).
- `admin-console.md` — removed the "Confirmed 2026-09-10 ... Earlier versions of this doc had ..." blockquote (folded into the entry above), replaced in the main doc with one plain sentence.
- `spire-setup.md` — removed Dominic's inline "Possibly Obsolete" flag on the "Set TypeScript version to workspace version" section (added independently outside this session). Logged as an open question below instead of silently dropping it — the underlying instructions stay in `spire-setup.md` since removing an unverified step is riskier than leaving it.
- `possibly-missing-setup-steps.md` **deleted** — see the dedicated entry below.
- `dev-docs/environment-setup-for-developers.md` — this is a local, unlinked pasted copy of Optimizely's external dev docs (the CC README links the external URL directly, not this file). It had 5 embedded `<!-- Claude TODO -->` / `<!-- Claude NOTE -->` comments asking for VS-Code-specific rewrites; all 5 questions turned out to already be answered by docs fixed earlier the same day (`admin-console.md` for NuGet/build, `ssms-setup.md` for database restore, `iis-setup.md` for IIS/bindings/cert, `spire-setup.md` for Spire API config). Replaced the stale Visual-Studio-specific and full-IIS-Manager instructions with pointers to those docs instead of leaving the TODOs open.

### `possibly-missing-setup-steps.md` — archived, then deleted

This file was raw scratch notes (title was literally "# Prompt") — a pasted checklist from a different customer's ("Lowes") Configured Commerce setup guide, shared 2024-2025, that Dominic flagged as possibly containing steps missing from this repo's own docs. It wasn't linked from anywhere in the main doc tree. Most of what was useful in it had already been absorbed into the real docs by this point:

- Elasticsearch port check (9200 vs 9201) — matches `docker-compose.yml`'s actual `elasticsearchnext` binding (9200).
- `connectionStrings.config` setup — covered in `mise-tools.md` and elsewhere.
- The npm install / grunt / TypeScript build steps — superseded, see the `admin-console.md` entry above; none of that is actually needed.
- The Windows Features / full-IIS checklist — superseded, this project uses IIS Express, not full IIS (see the `iis-setup.md` entry above). That specific checklist was also explicitly flagged by its own source note as possibly out of date and superseded by a newer, unrecorded setup meeting — historical reference only, never something to follow.

Full original content, preserved verbatim:

> These notes may be missing from my env-setup description of configured commerce. This is from a Configured Commerce Project Setup Guide file that was shared with Lowes in 2024-2025. It may be out of date as well. Also, the latest setup meeting with configured commerce team (described in the notes repo) has another set of instructions relating to windows features that involved more items toggled on than is described here.
>
> • Go to Turn Windows features on or off from control panel:
>
> From Lowes Setup Doc
> Tum Windows features on or off
>
> - [-] Internet Information Services
>   ○ [ ] FTP Server
>   ○ [-] Web Management Tools
>   ○ [-] World Wide Web Services
>    § [-] Application Development Features
>     □ [ ] .NET Extensibility 3.5
>     □ [x] .NET Extensibility 4.8
>     □ [ ] Application Initialization
>     □ [ ] ASP
>     □ [ ] ASP .NET 3.5
>     □ [ ] ASP.NET 4.8
>     □ [ ] CGI
>     □ [x] ISAPI Extensions
>     □ [x] ISAPI Filters
>     □ [ ] Server-Side Includes
>     □ [ ] WebSocket Protocol
>    § [-] Common HTTP Features
>     □ [x] Default Document
>     □ [x] Directory Browsing
>     □ [x] HTTP Errors
>     □ [ ] HTTP Redirection
>     □ [x] Static Content
>     □ [ ] WebDAV Publishing
>    § [-] Health and Diagnostics
>     □ [ ] Custom Logging
>     □ [x] HTTP Logging
>     □ [ ] Logging Tools
>     □ [ ] Request Monitoring
>     □ [ ] Tracing
>    § [-] Performance Features
>     □ [ ] Dynamic Content Compression
>     □ [x] Static Content Compression
>    § [-] Security
>     □ [ ] Basic Authentication
>     □ [ ] IP Security
>     □ [x] Request Filtering
>     □ [ ] URL Authorization
> - [ ] Internet Information Services Hostable Web Core
> - [ ] Legacy Components
> - [x] Media Features
>
> • Check localhost:9201 or localhost:9200 to verify elastic search port. If not in 9201 you have to change the `<add key="Elasticsearch5ServerUrl" value="http://localhost:9200" />` in application's appsettings.config file.
> • Open visual studio as administrator. Click open project or solution and open the solution.
> • Set InsiteCommerce.Web as startup. Open file /config/connectionStrings.config and set the proper connectionString. Example: `<add name="InSite.Commerce" connectionString="Server=JUARAF020;User Id=sa;Password=Optimizely@13;Initial Catalog=fox_database-backup-bacpac-fox-mqsww;MultipleActiveResultSets=true;" providerName="System.Data.SqlClient" />`
> • If the project is classic themed one find out the project folder inside \src\InsiteCommerce.Web\Themes\ folder. Open any typescript file from inside scripts folder. Put a space inside the ts file and save. This will trigger the scripts files build. (Skip this if Spire)
> • Rebuild InsiteCommerce.Web project.
> • For spire project open folder /src/frontend using visual studio code.
> • Paste in the commerce link in /config/settings-base.js > apiUrl.
> • In the terminal of vs code run command npm install.
> • Once installed run command npm run start [BluePrintName]
> • Open the link in browser and login into console lpscommerce.local.com/admin (lpscommerce.local.com:3000/admin for spire).
> • Goto Marketing > Indexing and click rebuild index.
> • Once the search index is built, we are ready for development.
>
> OH, nothing to do with schema at all. Just the text that I pasted. That schema doc seems to be stuck in all of my new chat sessions.

## 2026-09-11 — Open question: `spire-setup.md`'s "Set TypeScript version to workspace version" section

Dominic flagged this section as possibly obsolete in-doc ("skip unless needed while working on Spire"), but it hasn't been verified either way. The instructions are kept in `spire-setup.md` since removing an unverified optional step is riskier than leaving it — if you find yourself not needing it, or find a concrete reason it's no longer required with the current tsconfig/extension versions, update this entry and simplify or remove that section.

## 2026-09-11 — Troubleshooting sections split into `<component>-troubleshooting.md`

`admin-console.md`, `mise-tools.md`, and `spire-setup.md` each had an embedded "## Troubleshooting" section. Since each is now two related files (main doc + troubleshooting), they moved into their own component subfolders per this repo's file-placement convention (`.claude/adding-new-docs.md`):

- `optimizely/cfg/admin-console.md` → `optimizely/cfg/admin-console/admin-console.md` + `admin-console-troubleshooting.md`
- `optimizely/cfg/mise-tools.md` → `optimizely/cfg/mise/mise-tools.md` + `mise-tools-troubleshooting.md`
- `optimizely/cfg/spire-setup.md` → `optimizely/cfg/spire/spire-setup.md` + `spire-setup-troubleshooting.md`

`optimizely/cfg/database/ssms-setup.md` also had its Troubleshooting section extracted to a new `ssms-setup-troubleshooting.md` sibling — no new folder needed there since `database/` already held multiple files.

Every inbound reference was updated to match: the CC `README.md`'s numbered setup path, `iis-setup.md`'s pointer to the Admin Console's "Gigantic Opti logo" fix (now at `admin-console/admin-console-troubleshooting.md#gigantic-opti-logo`), `dev-docs/environment-setup-for-developers.md`'s pointers, and each moved file's own Prev/Next footer and cross-links to the others (all now one directory deeper, so `../../` became `../../../` etc. inside `mise-tools.md`). `windows/mise/mise-tools.md`'s pointer to this CC page was fixed too.

New troubleshooting docs link back to their main doc only (`<-- [Back to X](x.md)`), not a full Prev/Next chain — they're reference material, not a mandatory step in the linear setup sequence.

## 2026-09-11 — New `local-edits.md`: aggregates every local/gitignored/transient customization

Created `optimizely/cfg/local-edits.md` as the single reference for everything about this repo's local setup that diverges from Optimizely's out-of-the-box template, spanning three different kinds of divergence that were previously scattered (or, in one case, never actually documented at all):

- **Gitignored, local-only files**: `connectionStrings.config` (the `Initial Catalog=wausau.local.com` naming, confirmed intentional — it's the database's real name, not a stale placeholder), `AppSettings.config` (three keys), `settings.js` in `src/FrontEnd`.
- **Tracked files with a transient modification that must never be committed**: `Web.config`'s `<compilation debug>` flip, and `Relay.ts`'s native-fetch patch (now explained precisely — it swaps `node-fetch`-only APIs, `.buffer()` and `.raw()`, for standard-`fetch` equivalents, `arrayBuffer()` and `getSetCookie()`).
- **Permanent tracked customization**: the full `mise.toml` task reference, moved here verbatim from `mise/mise-tools.md` (which now just points here).

The trigger was a genuinely missing step: `spire-setup-troubleshooting.md`'s existing "Environment\_\_ElasticsearchNextServerUrl" error entry never said what the actual fix was. Diffed the live `AppSettings.config` against `appSettings.default.config` to get it right — two keys don't exist in the default template at all (`Environment__CertificatePassword`, `Environment__ElasticsearchNextServerUrl`) and one default value is wrong for this environment (`Logging__ElasticServerUrl` defaults to port `9201`, but `docker-compose.yml`'s `elasticsearchnext` service actually binds `9200`). This is also more accurate than the old archived Lowes scratch notes (`.changelog/optimizely.md`'s earlier "possibly-missing-setup-steps.md" entry), which named a key, `Elasticsearch5ServerUrl`, that doesn't exist anywhere in this codebase — likely from an older ES5-based CC version.

`iis-setup.md` and `mise/mise-tools.md` updated to point here instead of duplicating content; CC `README.md` gained a pointer alongside the numbered setup path.

Reclassified the same day: Dominic pointed out `local-edits.md` isn't just background reference — `connectionStrings.config` and `AppSettings.config` need to actually exist before the Admin Console's `dotnet build` step can work at all. Promoted it into the numbered setup path as step 5, between SSMS Setup and Admin Console (which shifted from 5/6/7 to 6/7/8). Updated the Prev/Next chain (`ssms-setup.md` → `local-edits.md` → `admin-console.md`) and the "New project from scratch" step-range note (1–6 → 1–7) to match.

Corrected again the same day: the causality actually runs the other way — the local config files don't exist until an initial `dotnet restore`/`dotnet build` creates them (copied from their `.default.config` templates), so Local Edits has to come *after* a build, not before Admin Console's build section. Split that build step out into a new `optimizely/cfg/initial-build.md` (NuGet source config + `dotnet restore`/`dotnet build`, explicitly from a terminal rather than VS Code, so the first VS Code open is clean — see below) and trimmed `admin-console.md` down to just login verification. Final numbered sequence: `...SSMS Setup → Initial Build → Local Edits → Admin Console (verify login) → Mise Tools → Spire Setup`. Step-range note updated again (1–7 → 1–8).

Also documented, for the first time anywhere in this repo, that `.vscode/tasks.json`'s `Start Spire Dev Server` task has `"runOn": "folderOpen"` — opening this repo's folder in VS Code auto-runs `mise run fix-relay-fetch-start` (applies the Relay.ts patch, starts Spire, reverts the patch on stop) without anyone asking it to. Added to `spire-setup.md`'s "Start Spire" section, and referenced from `initial-build.md` as part of why the terminal-first build matters — that auto-start assumes the solution already builds and local config already exists. Also fixed a stray inaccuracy while in `spire-setup.md`: the doc said `mise run start-spire`, but the actual task in `mise.toml` is just `start` (alias `s`) — no task named `start-spire` exists.
