# SSMS Install

<-- [Back to README](../README.md)

```pwsh
winget install Microsoft.SQLServerManagementStudio
```

Connecting to SQL Server and importing the CC database requires the CC repo to be cloned locally (to run `docker compose up -d`) and .NET 8 installed (for sqlpackage). See [SSMS Setup](../optimizely/cfg/ssms-setup.md) in the Configured Commerce section.

<-- Prev: [Rancher Desktop](rancher-desktop.md)
--> Next: [DBeaver](dbeaver-install.md)
