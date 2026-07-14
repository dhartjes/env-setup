# Windows Features

<-- Top: [Back to README](../README.md)

Enable all required Windows Features in a single admin session rather than across multiple setup steps.

## Required features

### Option A — Windows Features UI

1. Press `Win+R`, type `appwiz.cpl`, press Enter.
2. Click **Turn Windows features on or off**.
3. Enable the following:
   - **.NET Framework 4.8 Advanced Services**
     - **ASP.NET 4.8**
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
4. Click **OK**. Windows will install the features — a restart may be required.

### Option B — PowerShell (if Option A fails or is inaccessible)

Run in an elevated PowerShell session:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole -All
Enable-WindowsOptionalFeature -Online -FeatureName NetFx4Extended-ASPNET45 -All
Enable-WindowsOptionalFeature -Online -FeatureName WAS-WindowsActivationService -All
```

The `-All` flag automatically enables all dependencies for each feature.

### Verify IIS

Open a browser and navigate to `http://localhost`. The IIS welcome page should appear.

## Sources

- https://winsides.com/how-to-enable-asp-net-4-8-support-iis-on-windows-11/
