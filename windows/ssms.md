# SSMS

<-- [Back to README](../README.md)

I installed ssms with winget.

I am hosting my sql server in rancher desktop using the dockerd (moby) container engine.

I have modified my docker related files in the project to only load certain dependencies. This allows me to use the docker approach with a .net framework 4.8 project.

Importing bacpacs is causing issues so I am attempting to install sqlpackage with ```dotnet tool install -g microsoft.sqlpackage```

Import following instructions from this support ticket: 

```
SqlPackage /a:Import /tsn:"localhost" /tdn:"Insite.Commerce" /tu:"sa" /tp:"Password1" /sf:"C:\Users\Dominic.Hartjes\Downloads\wausausupply_database-backup-bacpac-wausausupply-dkvnb.bacpac" /ttsc:True /p:DisableIndexesForDataPhase=False /p:PreserveIdentityLastValues=True
```

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
