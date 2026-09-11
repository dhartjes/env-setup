# Environment setup for developers

## Source

- [Environment Setup for Developers](https://docs.developers.optimizely.com/configured-commerce/docs/b2b-commerce-cloud-environment-setup-for-developers)

Describes how to set up your developer workstation to start building Configured Commerce solutions.

## Prerequisites

To set up your Configured Commerce developer environment, the following must be completed:

- You understand Git technology and command line tools.
- You have created a private GitHub repository and have access to edit collaborators.
- Optimizely has completed the provisioning of the Sandbox and Production Configured Commerce instances.
- Cloud developer workstation works on currently supported Microsoft Windows installations only. Linux and macOS are not supported.

## Developer workstation setup process

### Clone insite-commerce-cloud repository

> 📘 Note
>
> This is only allowed for organizations. For personal accounts, Github only allows full access collaborators. To clone the Configured Commerce repo, you need to create a shared service account, and the Configured Commerce hosting team will add you to the group to access git clone `https://github.com/InsiteSoftware/insite-commerce-cloud.git` after you submit a ticket.
>
> If you are new to Configured Commerce and are not working on an active project, submit a support ticket requesting an invitation to the Git repository. Create a shared group Git account, as individual accounts are not allowed. For example, *partnername-Optimizely* not *JonDoe-partner*.

1. Open git bash or command line.
2. `git clone https://github.com/InsiteSoftware/insite-commerce-cloud.git`

### Install the Configured Commerce Build Service GitHub App

You must install the Configured Commerce Build Service GitHub app on your extensions repository. Optimizely uses this app to receive webhooks that notify the Configured Commerce build service of code changes that must be built and deployed for the extensions repository.

> 🚧 Important
>
> Only complete this section if you are connecting your repo to an environment hosted by Optimizely. This step allows build server access to the repository to pull your extensions into your environment. Do not complete this step if you are completing the developer training course.

See [Build service v2](https://docs.developers.optimizely.com/configured-commerce/docs/build-service-v2#install-the-app) for more information.

### Replace default remote origin

1. Change directory to the cloned directory.
2. `git remote rm origin`
3. `git remote add origin [YourRemoteGitPath]`

For example, `https://github.com/yourprofile/isccloud.git`

### Add upstream repository

Add the original upstream repository to receive any new updates deployed by Optimizely to the web project in the repository. This uses git tags to identify releases. Git pull specific releases to test specific versions locally against customizations (theme and extensions).

1. `git remote add upstream https://github.com/InsiteSoftware/insite-commerce-cloud.git`
2. `git push --set-upstream origin master`

### Create a custom Classic Theme or Spire Blueprint

**Classic CMS** - Create a project theme using the PowerShell script provided. Multiple themes can be created in a single repository, however, themes cannot have the same name.

1. Locate the local git repository in Windows Explorer and go to the **/src folder**.
2. Open **PowerShell** and execute the **./createTheme.ps1 Powershell** script. For example, ./createTheme.ps1 - themeName "YourCustomTheme".
3. Open the **Commerce.Web** solution in Visual Studio and check that it has an Extension library, Commerce.Web project, and the custom Theme project.

**Check Environment Versions** – Use the steps in [Upgrade Configured Commerce](https://docs.developers.optimizely.com/configured-commerce/docs/upgrading-b2b-commerce-cloud) to make sure the version generating the theme is in sync with the deployed version. This prevents merging a code version that is ahead of what you have deployed or are deploying.

The branch tags containing version name are prepended with **lts** or **sts**. See [Long-Term Support overview](https://support.optimizely.com/hc/en-us/articles/19456407554317-Long-Term-Support-overview) for information.

### Configure the Optimizely NuGet source

NuGet packages are available on [https://nuget.optimizely.com](https://nuget.optimizely.com/), which does not require authentication. This project uses VS Code, not Visual Studio — see [Admin Console → Configure the NuGet source](../admin-console.md) for the VS-Code-appropriate approach (a `nuget.config` file at the repo root, no Visual Studio UI needed).

### Configure the local environment

This project builds via the `dotnet` CLI, not the Visual Studio UI — see [Admin Console → Restore and build](../admin-console.md).

For SQL: this section (`StartingDatabase.sql`) only applies to a brand-new environment. For an existing customer's site, restore their `.bacpac` instead — see [SSMS Setup](../database/ssms-setup.md). Either way, update `./src/InsiteCommerce.Web/config/connectionStrings.config` so it can connect to your database (`connectionStrings.default.config` is copied to `connectionStrings.config` during a build; if you skipped creating a database, copy the file manually).

This project runs on **IIS Express**, not full IIS — see [IIS Setup](../iis-setup.md) for the actual site/binding/certificate setup used here (the certificate generation step below is still accurate).

> 📘 Note
>
> IIS only works with .NET 4.8. For .NET 8.0+ information, see [.NET 8.0+ local development environment](https://docs.developers.optimizely.com/configured-commerce/docs/net8-local-development-environment).

Setup certificate:
1. Run powershell `{SDK Folder}\\tools\\generatePfx.ps1`. This generates two files, `insiteidentity.pfx` and `InsiteIdentityPassword.txt`.
2. Copy the generated `insiteidentity.pfx` to `{Web Project Folder}/AppData/insiteidentity.pfx`.
3. Copy the password in `InsiteIdentityPassword.txt` into the IdentityServerCertificatePassword node in `{Web Project Folder}/config/AppSettings.config`

For a Spire (React) project specifically — API target configuration, VS Code launch setup, and whether bindings differ — see [Spire Setup](../spire-setup.md) and [IIS Setup](../iis-setup.md); `https` is not required for the Spire front-end.

Once finished, log in to `/admin` with the following credentials:\
**user** – admin\
**password** – admin123

### Finalize git branching

Create two local branches called **sandbox** and **production**, used by the corresponding deployments. Pushing to the remove server automatically creates the remote branch. Optimizely schedules production deployments. Pushing to the remote production branch does not automatically make the theme and server-side customizations go live. Sandbox deployments are automated, and any customizations refresh the insitesandbox.com domain within a few minutes of a git push to the remote sandbox branch.

1. Open git bash or command line and open the install location.
2. git branch sandbox.
3. git branch production
4. Verify the Configured Commerce website loads in the browser on the local dev machine.

> 📘 Note
>
> Git is a distributed version control system. Optimizely only supports pulling the Extensions code from GitHub, but you can use any version control system internally for your workflow. Attach the Github repo to your internal repo as a remote and push code to it.
