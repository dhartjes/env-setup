# SSMS

<-- [Back to README](../README.md)

## Installation
```pwsh
wignet install Microsoft.SQLServerManagementStudio
```

There's a circular dependency here with .net8, the client repository being installed locally, and rancher-desktop. To put a database on your rancher-desktop instance, you need to have the client repository local so you can run `docker compose up -d`. Then, a SQL Server instance will exist that you can backup the database to.

I am hosting my sql server in rancher desktop using the dockerd (moby) container engine

I have modified my docker related files in the project to only load certain dependencies. This allows me to use the docker approach with a .net framework 4.8 project.

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

Importing bacpacs is causing issues so I am attempting to install sqlpackage with ```dotnet tool install -g microsoft.sqlpackage```

> **Note:** The `dotnet` CLI is not included with .NET Framework 4.8. Install .NET 8 or 10 SDK first — see [.NET Framework 4.8 Setup](../optimizely/cfg/cfg-dotnet-framework-setup.md).

Import following instructions from this support ticket: 

```
SqlPackage /a:Import /tsn:"localhost" /tdn:"Insite.Commerce" /tu:"sa" /tp:"<password-from-InsiteCommerce.Web>" /sf:"C:\Users\<YourUserName>\Downloads\<database-export>.bacpac" /ttsc:True /p:DisableIndexesForDataPhase=False /p:PreserveIdentityLastValues=True
```

A database backup can be retrieved from Mission Control.

### Troubleshooting:

1. Error with dropping tables:

    In SSMS, new query window, no database attached:
    ```
    sp_configure 'contained database authentication', 1;
    GO
    RECONFIGURE;
    GO
    ```

1. Issue: Create Master Key Encryption by Password error

    Looks like:
    ```
    Importing to database 'Insite.Commerce' on server 'localhost'.
    Creating deployment plan
    Initializing deployment
    Verifying deployment plan
    Analyzing deployment plan
    Importing package schema and data into database
    Updating database
    *** Error importing database:Could not import package.
    Error SQL72014: Core Microsoft SqlClient Data Provider: Msg 33094, Level 16, State 9, Line 1 An error occurred during Service Master Key decryption
    Error SQL72045: Script execution error.  The executed script:
    CREATE MASTER KEY ENCRYPTION BY PASSWORD= '******';
    ```

    Fix with:
    ```
    DROP MASTER KEY

    ALTER SERVICE MASTER KEY FORCE REGENERATE
    ```

    Or potentially opening the sa user and attempting to add the dbcreator role and server-admin role might have fixed it but I got error messages during the update. I rolled these two changes out and then submitted the change. It looked like it had originally, but appeared to register some kind of change.

### Source:
- https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-download?view=sql-server-ver16#windows-net-6

<-- Prev: [Rancher Desktop](rancher-desktop.md)
--> Next: [DBeaver](dbeaver-install.md)
