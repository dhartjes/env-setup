# SSMS Setup

<-- [Back to CFG Setup](README.md)

## Prerequisites

- SSMS installed — see [SSMS Install](../../windows/ssms-install.md)
- .NET 8 SDK installed — see [.NET Framework 4.8 Setup](cfg-dotnet-framework-setup.md)
- CC repo cloned locally — see [Branch Setup](branch-setup-for-multiple-repositories.md)
- Rancher Desktop running with `docker compose up -d` executed from the CC repo root

## Connecting to the Rancher Desktop SQL Server

| Field | Value |
|---|---|
| Server name | `localhost` |
| Authentication | SQL Server Authentication |
| Login | `sa` |
| Password | See `connectionStrings.default.config` in the CC repo |

The SA password is in:
```
C:\Users\Dominic.Hartjes\projects\wausausupply\src\InsiteCommerce.Web\config\connectionStrings.default.config
```

## Importing a Database Backup

A database backup (`.bacpac`) can be retrieved from Mission Control.

Install sqlpackage:

```pwsh
dotnet tool install -g microsoft.sqlpackage
```

Then import:

```pwsh
SqlPackage /a:Import /tsn:"localhost" /tdn:"Insite.Commerce" /tu:"sa" /tp:"<password-from-connectionStrings.default.config>" /sf:"C:\Users\<YourUserName>\Downloads\<database-export>.bacpac" /ttsc:True /p:DisableIndexesForDataPhase=False /p:PreserveIdentityLastValues=True
```

## Troubleshooting

**Error dropping tables**

Run in SSMS with no database selected:

```sql
sp_configure 'contained database authentication', 1;
GO
RECONFIGURE;
GO
```

**Create Master Key Encryption by Password error**

```
Error SQL72014: ... An error occurred during Service Master Key decryption
```

Fix with:

```sql
DROP MASTER KEY
ALTER SERVICE MASTER KEY FORCE REGENERATE
```

## Source

- https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-download?view=sql-server-ver16#windows-net-6

<-- Prev: [Branch Setup](branch-setup-for-multiple-repositories.md)
