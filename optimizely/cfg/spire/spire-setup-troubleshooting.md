# Troubleshooting Spire Setup

<-- [Back to Spire Setup](spire-setup.md)

**"We're sorry. An unhandled error has occurred and been reported." With console error "Environment__ElasticsearchNextServerUrl**

Review the DevTools Console. If the error message looks like:

```
  "message": "There is not currently a setting for 'Environment__ElasticsearchNextServerUrl' in the AppSettings section of your web.config."

```

Then `Environment__ElasticsearchNextServerUrl` is missing from `src\InsiteCommerce.Web\config\AppSettings.config` — it doesn't exist in the default template and must be added manually. Check the port matches what `docker-compose.yml`'s `elasticsearchnext` service is actually bound to (`9200` here, not the `Logging__ElasticServerUrl` default's `9201`). See [Local Edits → AppSettings.config](../local-edits.md) for the exact keys and values.

**`TypeError: Failed to parse URL from http://$MAIN_HOST:$ADMIN_API_PORT/identity/connect/token` when opening `http://<clientUrl>.local.com:3000`**

The `$MAIN_HOST` and `$ADMIN_API_PORT` in the message are literal: the Spire server was handed `OIDC_AUTHORITY=http://$MAIN_HOST:$ADMIN_API_PORT` straight from the repo's `.env`, and nothing expanded the `$` references. (Docker Compose expands `.env` itself; Node doesn't.) Spire uses `OIDC_AUTHORITY`, when set, as the base URL for its token request, and only falls back to `ISC_ADMIN_API_URL` (from `config/settings.js`, the IIS Express site) when it's unset.

The cause is the VS Code Python extension's **`python.terminal.useEnvFile`** setting. When it's on, VS Code loads the workspace `.env` into every new terminal and task shell, as plain text, whatever the project's language. Everything started from there inherits it, including Spire, so it gets the literal `OIDC_AUTHORITY`. (Confirmed by turning the setting off: new terminals no longer had `IMAGE_TAG`. VS Code's **Terminal: Show Environment Contributions** command shows which extension injects what.)

Fix: set `python.terminal.useEnvFile` to `false` for this workspace (in `.vscode/settings.json`, or in your user settings if you never use it for Python) and open new terminals; an already-open terminal keeps the old environment. The `.env` is for Docker Compose and the `database-updater`, not for processes started from VS Code. Its `OIDC_AUTHORITY` points at the docker `admin-api`, which this setup doesn't run, so expanding it wouldn't help; the right local behavior is to leave it unset so Spire uses `ISC_ADMIN_API_URL`. If you can't change the setting, run `Remove-Item Env:OIDC_AUTHORITY` before starting Spire.
