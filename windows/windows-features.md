# Windows Features

<-- Top: [Back to README](../README.md)

Enable all required Windows Features in a single admin session rather than across multiple setup steps.

## Required features

### Option A — Windows Features UI

1. Press `Win+R`, type `appwiz.cpl`, press Enter.
2. Click **Turn Windows features on or off**.
3. Enable the following:
   - .net framework 3.5 and sub
   - **.NET Framework 4.8 Advanced Services**
     - **ASP.NET 4.8**
     - WCF Services
       - HttpActivation
   - Containers
   - HyperV and sub
   - Internet Information Services
     - Web Management Tools and Sub
   - World Wide Web Services
     - Appdev features
       - **ASP.NET 4.8**
       - **.NET Extensibility 4.8**
       - **ISAPI Extensions**
       - **ISAPI Filters**
       - Server-side includes
   - Common Http features
     - Default Document
     - Http Errors
     - Http Redirection
     - Static Content
   - Health and Diag
     - Http logging
   - Security
     - Basic Authentication
     - Centralized SSL Cert Support
     - Request Filtering
     - Windows Authentication
   - **Windows Process Activation Service**
   - Windows Projected File System

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
