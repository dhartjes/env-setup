# Database Backup

- [Mission Control/Actions/Database Backup](https://support.optimizely.com/hc/en-us/articles/29756299053965-Database-Backup)

This action creates a backup for the target Optimizely Configured Commerce instance’s database.
User is provided a download link in Mission Control and in their chosen email.
These links expire in 7 days.

## Steps

1. Log in to Mission Control.
1. Go to Customers and select a customer.
1. Select a target Configured Commerce instance.
1. Click Actions on the instance page and select Database Backup.
1. (Optional) Schedule the action by toggling Scheduled Execution to On and selecting a time and date.
1. Review the details to confirm the selected instance (and scheduled time, if selected).
    - You can ignore any greyed-out or immutable fields because they are for development or debugging.
1. Enter the desired parameters for the action:
    - Enter a valid email address for the Requester Email. The backup link is sent to this email address.
    - Select True or False for Skip Logs. If set to true, the process excludes logs from the backup provided.
    - Select True or False for Debug Backup.
        - Choose False for a database backup to review data.
          - This is a much faster process, but the database may have transactional inconsistency issues.
          - Not intended for use with importing into a different environment.
        - Choose True to import the database backup into other environments for debug/import purposes.
          - This process takes significantly longer but provides a database with transactional consistency.
1. Click Continue. If scheduled, the action runs at the specified time. Otherwise, the action runs immediately.
1. Wait until the status is marked as Complete on the Action Request page.
    - The process sends the backup download link to the email address defined in the action.
    - The link is valid for 7 days.

If the action fails, submit a ticket with Optimizely Support with a link to the failed action request page.

*Note:* Due to the resource-heavy nature of this action and the variable nature of the transferred data, the process could take a significant amount of time.

## Import a bacpac

You can import a backup with SqlPackage or SSMS in Mission Control. Database backups are provided as .bacpac files.

### SqlPackage

Use SqlPackage to import to your local SQL server with the following steps:

1. Install the SqlPackage from Microsoft's website. Ensure that you install the .NET 6 version and not the .NET Framework version due to issues with processing large database tables.
1. Run the following command from the location of SqlPackage or add it to PATH:

```pwsh
SqlPackage /a:Import /tsn:"localhost" /tdn:"[DATABASE_NAME]" /tu:"sa" /tp:"Password1" /sf:"[PATH_TO_BACPAC]" /ttsc:True /p:DisableIndexesForDataPhase=False /p:PreserveIdentityLastValues=True
```

- tsn – The ip [optionalPort] of your currently running SQL server instance. 1433 is the default.
- tu – Database user
- tp – Database password

### SSMS

You can also use SSMS to import a backup. Go to Sql Server Management Studio. Right-click on the Databases folder and select Import Data-Tier Application. A modal displays to guide you through the import process.

Import Data-tier Application.png

*Note*: Importing with SSMS has known issues surrounding large table sizes and backups of more than 4GB. For workarounds, see the section below.

## Known issues

### BACPAC files over 4GB may fail to import

This is a known issue with SqlPackage.

BACPAC files over 4GB generated from SqlPackage may fail to import from the Azure portal or Azure PowerShell with a File contains corrupted data error message. This issue seems to be related to the difference between .NET Framework and the new .NET. Use the SqlPackage command-line utility to import the bacpac file.

### Databases with large table sizes may fail to import

Occasionally, imports with SSMS immediately fail with a corrupted BACPAC error. This can happen when the database you are importing has at least one extremely large table. Use the SqlPackage command line option.

### Importing to a local installation of sql-server may fail

You may have issues restoring a database from a containerized environment to a local installation of sql-server. If this happens, run the following script against master before importing the bacpac:

```sql
sp_configure 'contained database authentication', 1;
GO
RECONFIGURE;
GO
```

### Create master key encryption script failure

If you get the following error, see [this StackOverflow article](https://stackoverflow.com/questions/40575610/ssms-2016-error-importing-azure-sql-v12-bacpac-master-keys-without-password-not/46809203#46809203).

```text
*** Error importing database:Could not import package.
Error SQL72014: Core Microsoft SqlClient Data Provider: Msg 33094, Level 16, State 9, Line 1 An error occurred during Service Master Key decryption
Error SQL72045: Script execution error. The executed script:
CREATE MASTER KEY ENCRYPTION BY PASSWORD= '******';
```
