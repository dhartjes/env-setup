# DBeaver Setup

<-- [Back to README](../README.md)

DBeaver Community Edition is a SQL query tool used here to connect to Infor Data Fabric via JDBC.

## Install via WinGet

```powershell
winget install DBeaver.DBeaver.Community
```

## Prerequisites

- Java JDK 8 (Amazon Corretto recommended, or Oracle JDK 8 "1.8")
- DBeaver Community Edition
- Infor Compass JDBC Driver (`.jar` file)
- Infor Compass JDBC Driver `.ionapi` credentials file (one per tenant)

## Retrieving an .ionapi File

> Updated visuals as of 2026-04-23

1. From your Infor home page, click **App Switcher** and select **OS** from the Applications section.
2. Select **API Gateway**.
3. Select **Authorized Apps** in the left nav, search for `compass`, and click the download icon next to **Infor Compass JDBC Driver**.
4. In the popup, toggle **Create Service Account**, enter your name, select from the autocomplete, scroll down, and click **Download**.
5. Repeat for each tenant environment you will query from DBeaver.

> **Note:** Consider using a dedicated service account for this access rather than a personal account, especially for permanent/deployed solutions.

## Retrieving the infor-compass-jdbc Driver

> The download location has changed as of 2026-04-23.

1. From Infor OS, select **Data Fabric**.
2. Select **Utilities**, then **Downloads** in the left nav.
3. Click **Download**.
4. Review the latest setup instructions at https://docs.infor.com/inforos/latest/en-us/useradminlib_cloud/default.html?helpcontent=datafabrug/fmu1631199547459.html

## Driver Setup in DBeaver

These steps configure the Compass JDBC driver in DBeaver. Reference: Infor Xtreme KB 2103864.

1. Open DBeaver and select **Driver Manager**.
2. Create a new driver with the name `Compass JDBC Driver` (or include the tenant name, e.g. `Compass JDBC Driver - TRN`).
3. Add two library paths:
   - Path to the `.jar` file, e.g.: `C:\InforDataLake\TRN\infor-compass-jdbc-12.0.41.1.jar`
   - Path to the **folder** containing the `.ionapi` file, e.g.: `C:\InforDataLake\TRN`
4. Set the class name to: `com.infor.idl.jdbc.Driver`
5. Set the URL to: `jdbc:infordatalake://TENANTNAME`
   - Example: `jdbc:infordatalake://ABCTENANT_TST`
   - Wausau TRN: `jdbc:infordatalake://WAUSAUTRN`
6. Save the driver.
7. Select **Database → New Database Connection**, choose the Compass JDBC driver, and connect.

> **Note:** The `.ionapi` file **must** be named exactly `Infor Compass JDBC Driver.ionapi` or DBeaver will error on connect.

## Connecting to Multiple Tenants (Multiple Workspaces)

DBeaver supports multiple workspaces, which allows connecting to multiple tenants without driver conflicts.

### Create Workspace Folders

1. Press `Win + R` and paste `%APPDATA%\DBeaverData\` to open the DBeaver data folder.
2. You will see a folder like `workspace6` — this is the default workspace. Avoid configuring JDBC drivers there, as DBeaver opens it on launch.
3. Create a new folder inside `DBeaverData\` for each tenant (e.g., `workspace-TRN`, `workspace-PRD`).

### Create Driver/Credential Folders

1. Create a folder structure for drivers and `.ionapi` files, e.g. `C:\InforDataLake\`.
2. Inside, create a subfolder per tenant (e.g., `C:\InforDataLake\TRN\`).
3. In each tenant folder, place:
   - A copy of `infor-compass-jdbc-*.jar`
   - The tenant's `Infor Compass JDBC Driver.ionapi` file

### Switch to a Tenant Workspace

1. In DBeaver, go to **File → Switch Workspace → Other**.
2. Check the **Copy Settings** boxes if you want to carry over preferences (recommended).
3. Click **Browse**, navigate to the workspace folder for the tenant, and click **Launch**.
4. DBeaver will relaunch in the selected workspace.
5. Configure the driver for that tenant using the steps in [Driver Setup](#driver-setup-in-dbeaver).

## Optional: MS Office Integration (Open in Excel)

Adds a quick "open in Excel" button to query results.

> **Important:** DBeaver must **not** be installed in a write-protected folder (e.g. `Program Files`). If it is, either move the installation or run DBeaver as Administrator.

1. **Menu Bar → Help → Install New Software**
2. Paste into the **Work with** field and press Enter:
   ```
   https://dbeaver.io/update/office/latest/
   ```
3. Check the items to install, click **Next → Finish**, and restart DBeaver.

<-- Prev: [SSMS](ssms.md)
