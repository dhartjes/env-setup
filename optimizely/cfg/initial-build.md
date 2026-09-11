# Initial Build

<-- [Back to CFG README](README.md)

Before opening this repo in VS Code for the first time, do one restore + build from a plain PowerShell terminal instead. Two reasons:

1. **It's what actually creates the local config files.** `connectionStrings.default.config` / `appSettings.default.config` get copied to their non-`.default` names (`connectionStrings.config` / `AppSettings.config`) as part of the build. [Local Edits](local-edits.md), which comes next, edits those files — they have to exist first.
2. **Keeps VS Code's first open clean.** [Spire Setup](spire/spire-setup.md) documents a task that auto-starts the Spire dev server the moment you open this folder in VS Code (`runOn: folderOpen`). That assumes the solution already builds and the local config already exists — do this from the terminal first so the very first VS Code open isn't the thing surfacing a build error or a missing-config crash.

## Configure the NuGet source

The Optimizely NuGet feed requires no authentication. Add it to a `nuget.config` file at the repo root (create the file if it does not exist):

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <add key="Configured Commerce" value="https://nuget.optimizely.com/feed/packages.svc" />
  </packageSources>
</configuration>
```

## Restore and build

In a PowerShell terminal at the repo root:

```powershell
dotnet restore .\src\InsiteCommerce.Web\InsiteCommerce.Web.csproj
dotnet build .\src\InsiteCommerce.Web\InsiteCommerce.Web.csproj
```

Once this succeeds, `connectionStrings.config` and `AppSettings.config` will exist (copied from their `.default.config` templates) — continue to [Local Edits](local-edits.md) to fill in the values this project actually needs.

<-- Prev: [SSMS Setup](database/ssms-setup.md)
--> Next: [Local Edits](local-edits.md)
