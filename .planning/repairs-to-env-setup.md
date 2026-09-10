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

Can be simplified based on which steps actually prove necessary.

## Sequencing `cd src/Frontend && npm install` before opening vs code

Opening vs code initializes npm script runs. We should do npm install before launching vs code for the first time in the WausauSupply repo.

## Never before documented changes (I think)

### InsiteCommerce.Web/config/connectionStrings.config

If you want to rename your database to something besides Insite.Commerce, you need to also update this connectionStrings.config file. This can be useful if you have a local production database, a sandbox database and/or an ade database.

Troubleshooting: the file won't exist until the repo has been built once in its current location.
