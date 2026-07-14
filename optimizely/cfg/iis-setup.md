# IIS Setup

<-- [Back to CFG README](README.md)

## Enable IIS on Windows 11

### Option A — Windows Features UI

1. Open **Start** → search **"Turn Windows features on or off"**.
2. Enable the following:
   - **Internet Information Services**
     - Web Management Tools → **IIS Management Console**
     - World Wide Web Services → Application Development Features:
       - **ASP.NET 4.8**
       - **.NET Extensibility 4.8**
       - **ISAPI Extensions**
       - **ISAPI Filters**
     - World Wide Web Services → Common HTTP Features:
       - **Default Document**
       - **HTTP Errors**
       - **Static Content**
   - **Windows Process Activation Service**
   - **.NET Framework 4.8 Advanced Services** → **ASP.NET 4.8**
3. Click **OK**. Windows will install the features — a restart may be required.

### Option B — PowerShell (if Option A fails or is inaccessible)

Run in an elevated PowerShell session:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole -All
```

The `-All` flag automatically enables all dependencies for each feature.

### Verify

Open a browser and navigate to `http://localhost`. The IIS welcome page should appear.

## Add the CC site to IIS

1. Open **IIS Manager** (search "IIS" in Start).
2. In the left pane, expand the server node → right-click **Sites** → **Add Website**.
3. Configure:
   - **Site name:** `wausausupply` (or any identifier)
   - **Physical path:** `C:\Users\Dominic.Hartjes\projects\wausausupply\src\InsiteCommerce.Web`
   - **Binding type:** `http`
   - **Port:** `8080`

   For multiple active projects, use named hostnames on port 80 instead. Add entries to `C:\Windows\System32\drivers\etc\hosts` (requires an elevated editor):
   ```
   127.0.0.1  wausausupply.local.com
   ```
   Then set the IIS binding hostname to `wausausupply.local.com` on port 80.

4. Click **OK**.

## Generate the identity server certificate

Run from the SDK tools folder in PowerShell:

```powershell
& "C:\Users\Dominic.Hartjes\projects\wausausupply\tools\generatePfx.ps1"
```

This produces two files in the same directory: `insiteidentity.pfx` and `InsiteIdentityPassword.txt`.

1. Copy `insiteidentity.pfx` to:
   ```
   src\InsiteCommerce.Web\AppData\insiteidentity.pfx
   ```

2. Open `InsiteIdentityPassword.txt` and copy the password.

3. Open `src\InsiteCommerce.Web\config\AppSettings.config` and add the following key (the key does not exist by default and must be added manually):
   ```xml
   <add key="Environment__CertificatePassword" value="<password from InsiteIdentityPassword.txt>" />
   ```

<-- Prev: [Clone and Branch Setup](branch-setup-for-multiple-repositories.md)
--> Next: [SSMS Setup](database/ssms-setup.md)
