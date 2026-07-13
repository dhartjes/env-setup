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

<!-- Claude TODO: This installation uses VS Code not Visual Studio. Can you update these instructions to include how to set up a nuget package feed in VS Code? -->
### Configure Optimizely NuGet source in Visual Studio

NuGet packages are available on [https://nuget.optimizely.com](https://nuget.optimizely.com/), which does not require authentication.

1. Go to **Visual Studio** > **Tools** > **Options** > **NuGet Package Manager** > **Package Sources**.
2. Click **Add**:
   1. **Name** – Configured Commerce
   2. **Source** – [https://nuget.optimizely.com/feed/packages.svc](https://nuget.optimizely.com/)
3. Restore packages.

### Configure the local environment

<!-- Claude TODO: This installation uses VS Code not Visual Studio. What are my options for building in VS Code? -->
Open **Visual Studio** and rebuild the solution.

<!-- Claude TODO: In every instance except the first, creating a database is not necessary. Please add info about pulling a database from Mission Control and uploading it using SqlPackage. This info is available in env-setup/optimizely/cfg/user-docs//mission-control/actions/database-backup.md -->
For SQL, follow these steps:

1. Create a database within SQL server
2. Run `./database/Insite.Commerce.StartingDatabase.sql` against the database.
3. Optionally run `./database/Insite.Commerce.SampleData.sql` against the database.
4. Update `./src/InsiteCommerce.Web/config/connectionStrings.config` so it can connect to your new database.\
   `connectionStrings.default.config` is copied to `connectionStrings.config` during a build. If you skipped step 1, you can copy the file manually.

<!-- Claude TODO: I haven't indicated in my setup project that I need to enable IIS via Windows Features. Can you add this to the Windows setup section? -->
For IIS (.NET 4.8), follow these steps:

> 📘 Note
>
> IIS only works with .NET 4.8. For .NET 8.0+ information, see [.NET 8.0+ local development environment](https://docs.developers.optimizely.com/configured-commerce/docs/net8-local-development-environment).

1. Add a new site to IIS, pointing to `./src/InsiteCommerce.Web`.
2. Set up bindings:
   1. For simple setups, using a non-standard port like 8080 is fine. The site can then be accessed at `http://localhost:8080`.
   2. If dealing with multiple projects, it can help to have them setup with hostnames on port 80:\
      `projectA.local.com`\
      `projectB.local.com`\
      This requires entries in `c:\Windows\System32\drivers\etc\hosts`:\
      `127.0.0.1` `projectA.local.com`\
      `127.0.0.1` `projectB.local.com`
      > 📘 Note
      >
      > `https` is not required.
3. Setup certificate:
   1. Run powershell `{SDK Folder}\\tools\\generatePfx.ps1`. This generates two files, `insiteidentity.pfx` and `InsiteIdentityPassword.txt`.
   2. Copy the generated `insiteidentity.pfx` to `{Web Project Folder}/AppData/insiteidentity.pfx`.
   3. Copy the password in `InsiteIdentityPassword.txt` into the IdentityServerCertificatePassword node in `{Web Project Folder}/config/AppSettings.config`

<!-- Claude NOTE: Somewhere around here there should be some different instructions when setting up a Spire Project instead of a Classic project. Here are some questions I have on setup that are always difficult to find answers to:
1. Should my IIS bindings be different? 
2. Should I use SSL for requests to the Spire front-end?
3. What should my launch configuration look like in VS Code? 
4. Where do I configure the connection to the API and what value should I use?

Some of these questions may be answered in ./environment-setup-for-developers.md or in this file. Either way, the actual website documentation does not make setup easy by having some of this information hidden in articles outside of the Environment Setup for Devs article.
-->

Once finished with either set of steps, log in to `/admin` with the following credentials:\
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
