# IIS Express Setup

<-- [Back to CFG README](README.md)

This project runs on **IIS Express**, launched from VS Code (`launch.json`) or from the repo-root `mise run start-iis-express` / `start-iis-express-fast` tasks — not from full IIS / IIS Manager. IIS Express is self-contained and does not require the IIS Windows feature or admin rights to run day-to-day, only for the one-time host setup below.

## Prerequisites

- IIS Express installed. There's no winget package for it — download "IIS Express 10" from Microsoft: https://www.microsoft.com/en-us/download/details.aspx?id=48264. Do **not** also install the ASP.NET Core Hosting Bundle unless you specifically need it — see the config note below.
- [.NET Framework 4.8 Setup](dotnet-framework-setup.md) completed.

## `.vscode/launch.json` and `.vscode/iisexpress/` are per-machine, not source controlled

Both are excluded in `.gitignore` (`.vscode/launch.json` and `.vscode/iisexpress/`), so they don't travel with the repo and must be rebuilt on every new clone/machine. `.vscode/tasks.json` and `.vscode/settings.json` *are* tracked and normally need no changes.

### `launch.json`

Create `.vscode/launch.json`:

```jsonc
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch IIS Express (InsiteCommerce.Web)",
            "type": "clr",
            "request": "launch",
            "requireExactSource": false,
            "program": "C:\\Program Files\\IIS Express\\iisexpress.exe",
            "args": [
                "/config:${workspaceFolder}\\.vscode\\iisexpress\\applicationhost.config",
                "/site:InsiteCommerceWeb",
                "/trace:error"
            ],
            "cwd": "${workspaceFolder}",
            "stopAtEntry": false,
            "preLaunchTask": "Prepare Debug Session"
        },
        {
            "name": "Attach to IIS (w3wp)",
            "type": "clr",
            "request": "attach",
            "processId": "${command:pickProcess}"
        }
    ]
}
```

F5 runs the first configuration with the debugger attached, via its `preLaunchTask` (`Prepare Debug Session` — build + ensure containers). Ctrl+F5 does **not** use this launch config at all: it's globally remapped (see [VS Code Keybinding convention](../../windows/vscode/vscode-install.md#keybinding-convention-ctrlf5-runs-a-task-not-the-debugger)) to run the `.vscode/tasks.json` task literally labeled `Run Without Debugging (Fast)` — VS Code's own noDebug handling on the `clr` debug type isn't reliable, so relying on it was hit-or-miss. That task depends on `Run IIS Express (Fast, No Debug)` (wraps `mise run start-iis-express-fast`, which flips `<compilation debug>` off in `web.config`, launches `iisexpress.exe` directly with no debugger involved, and reverts `web.config` on exit) and `Ensure Dev Containers`, run in parallel.

### `applicationhost.config`

Create `.vscode/iisexpress/applicationhost.config`. Two things commonly break it:

1. **Use the modern IIS Express default template**, whose CLR app pools point their `CLRConfigFile` at `%IIS_BIN%\config\templates\PersonalWebServer\aspnet.config` (a file that ships with the IIS Express install itself). Don't base it on an older config whose pools point at `%IIS_USER_HOME%\config\aspnet.config` — that path only exists once IIS Express's legacy per-user first-run wizard has run, which it won't have on a fresh profile, and every CLR app pool fails to start as a result.
2. **Strip the ASP.NET Core module registration if the Hosting Bundle isn't installed.** The modern default template registers `AspNetCoreModule` / `AspNetCoreModuleV2` in `<globalModules>` (and matching `lockItem="true"` entries in `<modules>`). If `C:\Program Files\IIS Express\aspnetcore.dll` doesn't exist (Hosting Bundle not installed — it doesn't ship with plain IIS Express), those entries make IIS Express fail to start *any* site with `Error loading global modules. hr = 8007007e` ("module not found"). Delete both pairs of entries — this is a classic .NET Framework app and doesn't need ASP.NET Core hosting at all.

The site itself needs:

```xml
<site name="InsiteCommerceWeb" id="1" serverAutoStart="true">
    <application path="/" applicationPool="Clr4IntegratedAppPool">
        <virtualDirectory path="/" physicalPath="<repo-root>\src\InsiteCommerce.Web" />
    </application>
    <bindings>
        <binding protocol="http" bindingInformation=":8080:wausau.local.com" />
    </bindings>
</site>
```

`physicalPath` must be an absolute path to your local clone of `src\InsiteCommerce.Web` — update it if you ever move or re-clone the repo.

## One-time elevated host setup (per machine, not per clone)

Binding to `wausau.local.com:8080` instead of plain `localhost` needs two elevated steps, done once per machine/user profile — independent of where the repo lives on disk:

1. Add a hosts file entry (edit as Administrator, e.g. Notepad run as admin on `C:\Windows\System32\drivers\etc\hosts`):

   ```
   127.0.0.1  wausau.local.com
   ```

   For multiple active projects, use additional hostnames the same way instead of colliding on one.

2. Reserve the URL for your Windows account (run from an elevated PowerShell — this is what lets ordinary, non-elevated IIS Express launches bind the hostname afterward):

   ```powershell
   netsh http add urlacl url=http://wausau.local.com:8080/ user=<DOMAIN>\<username>
   ```

   Without this, IIS Express fails immediately with `Failed to register URL ... Access is denied (0x80070005)` even when the config file itself is correct.

## Generate the identity server certificate

Run from the repo root in PowerShell:

```powershell
& "<repo-root>\tools\generatePfx.ps1"
```

This produces two files in the same directory: `insiteidentity.pfx` and `InsiteIdentityPassword.txt`.

1. Copy `insiteidentity.pfx` to:

   ```
   src\InsiteCommerce.Web\AppData\insiteidentity.pfx
   ```

2. Open `InsiteIdentityPassword.txt` and copy the password.

3. Open `src\InsiteCommerce.Web\config\appSettings.config` and add the following key (the key does not exist by default and must be added manually):

   ```xml
   <add key="Environment__CertificatePassword" value="<password from InsiteIdentityPassword.txt>" />
   ```

See [Local Edits → AppSettings.config](local-edits.md) for the other keys this file needs locally.

## Verify static content MIME types

Configured Commerce's `Web.config` ships `<staticContent>` overrides for a handful of extensions IIS doesn't map by default — `.woff`, `.woff2`, `.xlsx`, `.ts`, `.scss`, `.json` — but not always `.css`. If that entry is missing, IIS serves every `.css` file as `application/octet-stream` instead of `text/css`. The request still comes back 200 OK with valid CSS content, but browsers silently refuse to apply a stylesheet with the wrong content type — so the site (Admin Console or storefront) loads completely unstyled, with no error in the console to point at. See [Admin Console troubleshooting](admin-console/admin-console-troubleshooting.md#gigantic-opti-logo) for the full diagnosis.

Check `src\InsiteCommerce.Web\Web.config` for a `.css` entry inside `<system.webServer><staticContent>` before moving on, and add one if it's missing:

```xml
<remove fileExtension=".css" />
<mimeMap fileExtension=".css" mimeType="text/css" />
```

If you land here *after* already hitting the unstyled-site symptom in a browser, a hard refresh (Ctrl+Shift+R) is required afterward — the same `<staticContent>` block sets a 30-day `max-age` with no revalidation, so the browser has already cached the bad response.

<-- Prev: [Clone and Branch Setup](branch-setup-for-multiple-repositories.md)
--> Next: [SSMS Setup](database/ssms-setup.md)
