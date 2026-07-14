# SSMS Setup

<-- [Back to CFG Setup](README.md)

## Prerequisites

- SSMS installed — see [SSMS Install](../../../windows/ssms-install.md)
- .NET 8 SDK installed — see [.NET Framework 4.8 Setup](../dotnet-framework-setup.md)
- CC repo cloned locally — see [Branch Setup](../branch-setup-for-multiple-repositories.md)
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
SqlPackage /a:Import /tsn:"localhost" /tdn:"wausau.local.com" /tu:"sa" /tp:"<password-from-connectionStrings.default.config>" /sf:"C:\Users\<YourUserName>\Downloads\<database-export>.bacpac" /ttsc:True /p:DisableIndexesForDataPhase=False /p:PreserveIdentityLastValues=True
```

## Update the Website table DomainName field

After restoring the database from a live environment, it most likely needs an update to the main website in the Website table to align the DomainName field with the url being used in the local environment.

```sql
UPDATE WebSite
   SET DomainName = 'wausau.local.com,' + DomainName
 WHERE Name = 'main'
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

More recent fix (2025ish):

Run the [RemoveMasterKey](RemoveMasterKey.ps1) script provided by Microsoft on the bacpac encoutnering the error.

```pwsh
.\RemoveMasterKey.ps1 -bacpacPath "C:\Users\<YourUserName>\Downloads\<database-export>.bacpac"
```

Fix with:

```sql
DROP MASTER KEY
ALTER SERVICE MASTER KEY FORCE REGENERATE
```

This provided the following errors but still seemed to have the desired effect:

```text
Msg 15151, Level 16, State 1, Line 1
Cannot find the symmetric key 'master key', because it does not exist or you do not have permission.
The current master key cannot be decrypted. The error was ignored because the FORCE option was specified.
```

## Source

- https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-download?view=sql-server-ver16#windows-net-6

<-- Prev: [IIS Setup](../iis-setup.md)
--> Next: [Admin Console](../admin-console.md)
