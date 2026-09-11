# fixes for env-setup:

## mise out of order
mise install is not a part of the setup instructions before we get to git authentication.

## tree-sitter --version failure
node:events:505
    throw er; // Unhandled 'error' event
    ^

Error: spawn /home/dhartjes/.local/share/mise/installs/npm-tree-sitter-cli/0.27.0/node_modules/.mise/tree-sitter-cli@0.27.0/node_modules/tree-sitter-cli/tree-sitter ENOENT
    at ChildProcess._handle.onexit (node:internal/child_process:287:19)
    at onErrorNT (node:internal/child_process:525:16)
    at process.processTicksAndRejections (node:internal/process/task_queues:90:21)
Emitted 'error' event on ChildProcess instance at:
    at ChildProcess._handle.onexit (node:internal/child_process:293:12)
    at onErrorNT (node:internal/child_process:525:16)
    at process.processTicksAndRejections (node:internal/process/task_queues:90:21) {
  errno: -2,
  code: 'ENOENT',
  syscall: 'spawn /home/dhartjes/.local/share/mise/installs/npm-tree-sitter-cli/0.27.0/node_modules/.mise/tree-sitter-cli@0.27.0/node_modules/tree-sitter-cli/tree-sitter',
  path: '/home/dhartjes/.local/share/mise/installs/npm-tree-sitter-cli/0.27.0/node_modules/.mise/tree-sitter-cli@0.27.0/node_modules/tree-sitter-cli/tree-sitter',
  spawnargs: [ '--version' ]
}

Node.js v24.20.0

## claude --version failure
Claude has a postinstall script. Since I install node globally with mise, the path to run the claude post install script is:

```
cd ~/.local/share/mise/installs/npm-anthropic-ai-claude-code/latest
node node_modules/@anthropic-ai/claude-code/install.cjs
```

## wslu isn't compatible with ubuntu 26

to replace it, let's simply use this script to set the BROWSER variable to an available windows browser.

bash -c "$(curl -s https://raw.githubusercontent.com/julesvanrie/wslsetbrowser/refs/heads/main/wslsetbrowser.sh)"

## Remove volta install

## Save Linux .config in a new repo

https://github.com/dhartjes/linux-config.git

Only thing is, this has the nvim repo inside it which is annoying. Any ideas?

## Firefox

winget install Mozilla.Firefox

Preferably before dbeaver-install in the setup as I use different firefox profiles for different tenants in dbeaver.

## Dbeaver install and setup should be separated

## Rancher Desktop Setup

Add to troubleshooting: Error response from daemon: failed to connect to the backend: timed out dialing Hyper-V socket

indicates that hyper-v must be running. This is a windows feature. Windows features should be added to the main setup path and should occur before rancher desktop setup.


## SSMS Setup

From ssms-setup.md, the following should be a step rather than a prerequisite:
- Rancher Desktop running with `docker compose up -d` executed from the CC repo root

## iis-setup.md

DONE 2026-09-10: rewritten around IIS Express instead of full IIS Manager. Covers rebuilding the gitignored `.vscode/launch.json` and `.vscode/iisexpress/applicationhost.config` on a new machine, the two config gotchas that broke a fresh setup (`%IIS_USER_HOME%` vs `%IIS_BIN%\config\templates\PersonalWebServer` CLR config path, and stripping `AspNetCoreModule`/`AspNetCoreModuleV2` global modules when the Hosting Bundle isn't installed), and the one-time elevated hosts-file + `netsh http add urlacl` steps. generatePfx.ps1 is still required and documented.

## We have no IIS Express install instructions

DONE 2026-09-10, folded into iis-setup.md:
1. There's no winget package for IIS Express, so it's a manual download: IIS Express 10 from https://www.microsoft.com/en-us/download/details.aspx?id=48264. (The old "winget install Microsoft.WebDeploy" note here looks like it was for something else — Web Deploy is a separate publishing tool, not IIS Express — dropped it rather than carry it forward unverified.)
2. One-time elevated steps, per machine:
    a. In an admin PowerShell prompt: `netsh http add urlacl url=http://wausau.local.com:8080/ user=wausaudc\dominic.hartjes`
    b. Modify hosts file at `C:\Windows\System32\drivers\etc\hosts`; include `127.0.0.1  wausau.local.com`

## admin-console.md

DONE 2026-09-10: removed the "Build the frontend CSS" (`npm install` + `grunt build`) and "Build the Admin Console TypeScript" (`tsc`) sections — validated locally that none of grunt, npm install, or a TypeScript compile are needed to make the Admin Console work; only the `.css` MIME-type fix (already documented under Troubleshooting) matters. The corresponding `build-admin-ts`/`watch-admin-ts` mise tasks were also removed from wausausupply's `mise.toml`.

## frontend-tools-setup.md + setup sequencing

DONE 2026-09-10: rewrote to drop the "Install mise" instructions (already covered generically outside CC setup) and corrected "required before Admin Console" — Node is only needed for Spire now. Reordered README's "Existing customer site" setup path so this step comes right before Spire instead of before Admin Console (SSMS → Admin Console → this step → Spire), and updated the Prev/Next footer links on admin-console.md and spire-setup.md to match. Also dropped a stray "Grunt CLI" mention from spire-setup.md's prerequisites (Spire never needed grunt — that was always specific to the admin-console CSS build we just removed). Superseded the same day, see below.

## mise doc restructuring (2026-09-10)

Follow-on from the above, once the CC mise setup was confirmed fully working:

- `optimizely/cfg/frontend-tools-setup.md` **deleted** — replaced by `optimizely/cfg/mise-tools.md`, containing only what's CC-specific (the `mise.toml`-pinned Node version, no manual `mise use --global` needed). README/admin-console.md/spire-setup.md updated to point at it instead.
- `windows/migrate-to-mise.md` **deleted**, split three ways per this repo's own two-related-files-get-a-subdirectory convention (`.claude/adding-new-docs.md`):
  - `windows/mise/mise-install.md` — just installing mise itself.
  - `windows/mise/mise-tools.md` — general tool installs via mise (Node, optional Neovim).
  - `migrations/windows-migrate-to-mise.md` (temporary) — the old-version-manager removal steps, moved into `migrations/` alongside the existing migration overview rather than living under `windows/`.
- `.planning/migrate-to-mise.md` **deleted** — it was a "Future Phase" tracker for migrating Python/Neovim/tree-sitter onto mise, but checking `wsl/python/python-setup.md`, `wsl/nvim/nvim-install.md`, and `wsl/tree-sitter-install.md` confirmed all three are already fully on mise (the tracker itself was stale). Its content was folded into `migrations/migrate-to-mise.md` as a "✅ Status: complete" historical record instead of being lost.
- `doctor.ps1`'s dangling reference to the deleted `windows/migrate-to-mise.md` was fixed to point at `migrations/migrate-to-mise.md`.

### Round 2 (same day): noticed `wsl/migrate-to-mise.md` + `wsl/mise-install.md` needed the identical treatment, and that per-platform migration files in `migrations/` was overkill

- `wsl/volta-install.md` **deleted** — confirmed orphaned (nothing linked to it since WSL moved to mise), no longer just flagged.
- `wsl/mise-install.md` **deleted**, split the same way as Windows: `wsl/mise/mise-install.md` (mise itself) + `wsl/mise/mise-tools.md` (Node/Python/Neovim/gh/uv/tree-sitter/AI-assistant installs). While rewiring this chain, also fixed a pre-existing inconsistency: `wsl/git/git-clone-repos.md` and `wsl/tree-sitter-install.md` pointed straight at each other, skipping over mise entirely even though README's numbered sequence placed mise between them — now `git-clone-repos.md` → `mise/mise-install.md` → `mise/mise-tools.md` → `tree-sitter-install.md`.
- `migrations/windows-migrate-to-mise.md` **deleted** again — folded directly into `migrations/migrate-to-mise.md` alongside a new "WSL Migration Steps" section (from the now-deleted `wsl/migrate-to-mise.md`), so `migrations/` holds a single `migrate-to-mise.md` file covering both platforms instead of one-file-per-platform.
- Updated `README.md`, `CLAUDE.md`, and `doctor.sh`/`doctor.ps1` for all of the above path changes.
- `optimizely/cfg/mise-tools.md` expanded with a full reference for wausausupply's root `mise.toml` — flagged as a **custom addition, not an out-of-the-box Configured Commerce file** (hand-built by Dominic + Claude), with every task documented (including the `tools/*.ps1` scripts each one calls) so it can be reconstructed if a vendor sync or merge ever damages it.

## Sequencing `cd src/Frontend && npm install` before opening vs code

Opening vs code initializes npm script runs. We should do npm install before launching vs code for the first time in the WausauSupply repo.

## Never before documented changes (I think)

### InsiteCommerce.Web/config/connectionStrings.config

If you want to rename your database to something besides Insite.Commerce, you need to also update this connectionStrings.config file. This can be useful if you have a local production database, a sandbox database and/or an ade database.

Troubleshooting: the file won't exist until the repo has been built once in its current location.

### Need to indicate the nvim troubleshooting issue relating to win32yank to the standard setup sequence

Needs to go after winget and before wsl nvim. Or perhaps in wsl/nvim