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

<-- Prev: [CFG Setup](README.md)
--> Next: [Branch Setup](branch-setup-for-multiple-repositories.md)

