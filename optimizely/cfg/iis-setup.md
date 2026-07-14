# IIS Setup

<-- [Back to CFG README](README.md)

## Prerequisites

- Windows Features enabled — see [Windows Features](../../windows/windows-features.md) (IIS and all required .NET features are enabled there in a single admin session)

## Add the CC site to IIS

1. Open **IIS Manager** (search "IIS" in Start).
2. In the left pane, expand the server node → right-click **Sites** → **Add Website**.
3. Configure:
   - **Site name:** `wausau.local.com` (or any identifier)
   - **Physical path:** `C:\Users\Dominic.Hartjes\projects\wausausupply\src\InsiteCommerce.Web`
   - **Binding type:** `http`
   - **Port:** `8080`
   - **Permissions:** 
      - Edit Permissions, Security Tab, Edit, Add, "iis apppool\wausau.local.com", Check Names, OK.
      - Permissions for wausau.local.com: Modify, Full control, click Apply.

   For multiple active projects, use named hostnames on port 80 instead. Add entries to `C:\Windows\System32\drivers\etc\hosts` (requires an elevated editor):
   ```
   127.0.0.1  wausau.local.com
   ```
   Then set the IIS binding hostname to `wausau.local.com` on port 80.

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
