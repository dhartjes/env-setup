# Configured Commerce Setup on DotNet Framework 4.8

Setup of DotNet Framework 4.8 solutions must be done on Windows machine.

## Prerequisites

- Windows Features enabled — see [Windows Features](../../windows/windows-features.md) (covers .NET Framework 4.8 and Windows Process Activation Service alongside IIS in a single admin session)

## Steps

1. Dotnet Framework 4.8 download: [here](https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net48-developer-pack-offline-installer)

## Note on the `dotnet` CLI

.NET Framework 4.8 does **not** include the `dotnet` command-line tool — that comes with .NET (Core) SDKs only. To get the `dotnet` CLI available on Windows, install at least one modern SDK:

```powershell
winget install Microsoft.DotNet.SDK.8
winget install Microsoft.DotNet.SDK.10
```

.NET 8 is the current LTS release and provides the `dotnet` command. .NET 10 is installed for future-proofing.

## Building a single project outside Visual Studio

Running `dotnet build` directly against one `.csproj` (as any mise task, script, or CLI invocation does) does **not** set the MSBuild `$(SolutionDir)` property — that's only populated when the build goes through the `.sln` file, i.e. Visual Studio itself, or `dotnet build InsiteCommerce.sln`. Any custom `PreBuildEvent` or MSBuild `<Target>` that references `$(SolutionDir)` will silently no-op (or fail with a bogus path like `*Undefined*\...`) when built this way.

If you add a custom pre/post-build step to any CC project and want it to behave identically whether triggered from Visual Studio, mise, or a bare `dotnet build <project>.csproj`, use `$(MSBuildProjectDirectory)` instead — it's always defined regardless of how the build was invoked:

```xml
<!-- breaks when building the .csproj directly -->
<Exec Command="powershell.exe -command &quot;&amp; { $(SolutionDir)..\dist\buildExtensions.ps1 }&quot;" />

<!-- works from Visual Studio, mise, or a bare dotnet build -->
<Exec Command="powershell.exe -command &quot;&amp; { $(MSBuildProjectDirectory)\..\..\dist\buildExtensions.ps1 }&quot;" />
```

<-- Prev: [CFG Setup](README.md)
--> Next: [Branch Setup](branch-setup-for-multiple-repositories.md)

