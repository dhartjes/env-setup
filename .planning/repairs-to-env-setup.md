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

## Sequencing `cd src/Frontend && npm install` before opening vs code

Opening vs code initializes npm script runs. We should do npm install before launching vs code for the first time in the client's repo.

## Never before documented changes (I think)

### InsiteCommerce.Web/config/connectionStrings.config

If you want to rename your database to something besides Insite.Commerce, you need to also update this connectionStrings.config file. This can be useful if you have a local production database, a sandbox database and/or an ade database.

Troubleshooting: the file won't exist until the repo has been built once in its current location.

### Need to indicate the nvim troubleshooting issue relating to win32yank to the standard setup sequence

Needs to go after winget and before wsl nvim. Or perhaps in wsl/nvim

### Troubleshooting step re: Elasticsearch

Unhandled error when using any search related functionality. Paired with error code 500 from /api/v1/autocomplete or api/v1/search. 

```
  ElasticsearchV7: Failure in Running Product Search. Elasticsearch response error. Invalid NEST response built from a successful (404) low level call on POST: /<clientUrl>_local_com_product/_search?typed_keys=true
  # Audit trail of this API call:
   - [1] HealthyResponse: Node: http://localhost:9200/ Took: 00:00:00.1690922
  # Request:
  <Request stream not captured or already read to completion by serializer. Set DisableDirectStreaming() on ConnectionSettings to force it to be set on the response.>
  # Response:
  <Response stream not captured or already read to completion by serializer. Set DisableDirectStreaming() on ConnectionSettings to force it to be set on the response.>
```

To Fix:
Run index refresh via Marketing.

-- OR --

In a local environment, Settings/Search/Search Indexer Name: "Commerce Search v3" is unusable. Revert to "Commerce Search v2".
