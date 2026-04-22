---
title: Install WSL | Microsoft Learn
canonicalUrl: https://learn.microsoft.com/en-us/windows/wsl/install
breadcrumb_path: /windows/wsl/breadcrumb/toc.json
uhfHeaderId: MSDocsHeader-Windows-DevTools
recommendations: true
feedback_product_url: https://github.com/microsoft/WSL/issues
feedback_system: OpenSource
ms.service: dev-environment
ms.subservice: windows-subsystem-for-linux
author: GrantMeStrength
ms.author: jken
ms.reviewer: crloewen
adobe-target: true
description: Install Windows Subsystem for Linux with the command, wsl --install. Use a Bash terminal on your Windows machine run by your preferred Linux distribution - Ubuntu, Debian, SUSE, Kali, Fedora, Pengwin, Alpine, and more are available.
ms.date: 2025-06-09T00:00:00.0000000Z
ms.topic: install-set-up-deploy
ms.custom: seo-windows-dev
locale: en-us
document_id: 0cc9a77f-e6a1-a719-c337-7ff7506a1ac8
document_version_independent_id: 7ed8fb81-5b8f-4d56-7b89-bf600ce6080a
updated_at: 2025-12-09T21:15:00.0000000Z
original_content_git_url: https://github.com/MicrosoftDocs/WSL/blob/live/WSL/install.md
gitcommit: https://github.com/MicrosoftDocs/WSL/blob/c8f48940daca06325a1b87da2afe3d843ff87b0b/WSL/install.md
git_commit_id: c8f48940daca06325a1b87da2afe3d843ff87b0b
site_name: Docs
depot_name: WS.wsl
page_type: conceptual
toc_rel: toc.json
pdf_url_template: https://learn.microsoft.com/pdfstore/en-us/WS.wsl/{branchName}{pdfName}
feedback_help_link_type: ''
feedback_help_link_url: ''
word_count: 1541
asset_id: install
moniker_range_name: 
monikers: []
item_type: Content
source_path: WSL/install.md
cmProducts:
- https://authoring-docs-microsoft.poolparty.biz/devrel/bcbcbad5-4208-4783-8035-8481272c98b8
spProducts:
- https://authoring-docs-microsoft.poolparty.biz/devrel/43b2e5aa-8a6d-4de2-a252-692232e5edc8
platformId: be29a304-5e0d-f710-845d-404c0feacfec
---

# Install WSL | Microsoft Learn

Developers can access the power of both Windows and Linux at the same time on a Windows machine. The Windows Subsystem for Linux (WSL) lets developers install a Linux distribution (such as Ubuntu, OpenSUSE, Kali, Debian, Arch Linux, etc) and use Linux applications, utilities, and Bash command-line tools directly on Windows, unmodified, without the overhead of a traditional virtual machine or dualboot setup.

## Prerequisites

You must be running Windows 10 version 2004 and higher (Build 19041 and higher) or Windows 11 to use the commands below. If you are on earlier versions please see [the manual install page](install-manual).

## Install WSL command

You can now install everything you need to run WSL with a single command. Open PowerShell in **administrator** mode by right-clicking and selecting "Run as administrator", enter the wsl --install command, then restart your machine.

```powershell
wsl --install
```

This command will enable the features necessary to run WSL and install the Ubuntu distribution of Linux. ([This default distribution can be changed](basic-commands#install)).

If you're running an older build, or just prefer not to use the install command and would like step-by-step directions, see **[WSL manual installation steps for older versions](install-manual)**.

The first time you launch a newly installed Linux distribution, a console window will open and you'll be asked to wait for files to de-compress and be stored on your machine. All future launches should take less than a second.

Note

The above command only works if WSL is not installed at all. If you run `wsl --install` and see the WSL help text, please try running `wsl --list --online` to see a list of available distros and run `wsl --install -d <DistroName>` to install a distro. If the install process hangs at 0.0%, run `wsl --install --web-download -d <DistroName>` to first download the distribution prior to installing. To uninstall WSL, see [Uninstall legacy version of WSL](troubleshooting#uninstall-legacy-version-of-wsl) or [unregister or uninstall a Linux distribution](basic-commands#unregister-or-uninstall-a-linux-distribution).

## Change the default Linux distribution installed

By default, the installed Linux distribution will be Ubuntu. This can be changed using the `-d` flag.

- To change the distribution installed, enter:

    ```powershell
    wsl.exe --install [Distro]
    ```

    Replace `[Distro]` with the name of the distribution you would like to install.
- To see a list of available Linux distributions available for download through the online store, enter:

    ```powershell
    wsl.exe --list --online
    ```

If you run into an issue during the install process, check the [installation section of the troubleshooting guide](troubleshooting#installation-issues).

To install a Linux distribution that is not listed as available, you can [import any Linux distribution](use-custom-distro) using a TAR file. Or in some cases you can install using an `.appx` file. You can also create your own [custom Linux distribution](build-custom-distro) to use with WSL.

## Set up your Linux user info

Once you have installed WSL, you will need to create a user account and password for your newly installed Linux distribution. See the [Best practices for setting up a WSL development environment](setup/environment#set-up-your-linux-username-and-password) guide to learn more.

## Set up and best practices

We recommend following our [Best practices for setting up a WSL development environment](setup/environment) guide for a step-by-step walk-through of how to set up a user name and password for your installed Linux distribution(s), using basic WSL commands, installing and customizing Windows Terminal, set up for Git version control, code editing and debugging using the VS Code remote server, good practices for file storage, setting up a database, mounting an external drive, setting up GPU acceleration, and more.

## Check which version of WSL you are running

You can list your installed Linux distributions and check the version of WSL each is set to by entering the command:

```powershell
wsl.exe --list --verbose
```

To set the default version to WSL 1 or WSL 2 when a new Linux distribution is installed, use the command:

```powershell
wsl.exe --set-default-version <1|2>
```

To set the default Linux distribution used with the `wsl` command, enter:

```powershell
wsl.exe --set-default <Distro>
```

Replacing `<Distro>` with the name of the Linux distribution you would like to use. For example, from PowerShell, enter: `wsl -s Debian` to set the default distribution to Debian. Now running `wsl npm init` from Powershell will run the `npm init` command in Debian.

To run a specific wsl distribution from within PowerShell without changing your default distribution, use the command:

```powershell
wsl.exe --distribution <DistroName>
```

Replacing `<DistroName>` with the name of the distribution you want to use.

Learn more in the guide to [Basic commands for WSL](basic-commands).

## Upgrade version from WSL 1 to WSL 2

New Linux installations, installed using the `wsl --install` command, will be set to WSL 2 by default.

To see whether your Linux distribution is set to WSL 1 or WSL 2, use the command: `wsl -l -v`. Upgrading from WSL 1 to WSL 2 or downgrading from WSL 2 to WSL 1 can be done using the following command:

```powershell
wsl.exe --set-version <Distro> <1|2>
```

Replacing `<Distro>` with the name of the Linux distribution that you want to update. For example, `wsl --set-version Ubuntu 2` will set your Ubuntu distribution to use WSL 2.

If you manually installed WSL prior to the `wsl --install` command being available, you may also need to [enable the virtual machine optional component](install-manual#step-3---enable-virtual-machine-feature) used by WSL 2 and [install the kernel package](install-manual#step-4---download-the-linux-kernel-update-package) if you haven't already done so.

To learn more, see the [Command reference for WSL](basic-commands) for a list of WSL commands, [Comparing WSL 1 and WSL 2](compare-versions) for guidance on which to use for your work scenario, or [Best practices for setting up a WSL development environment](setup/environment) for general guidance on setting up a good development workflow with WSL.

## Ways to run multiple Linux distributions with WSL

WSL supports running as many different Linux distributions as you would like to install. This can include choosing distributions from the [Microsoft Store](ms-windows-store://collection?CollectionId=LinuxDistros), [importing a custom distribution](use-custom-distro), or [building your own custom distribution](build-custom-distro).

There are several ways to run your Linux distributions once installed:

- [From Windows Terminal](/en-us/windows/terminal/install)***(Recommended)*** Using Windows Terminal supports as many command lines as you would like to install and enables you to open them in multiple tabs or window panes and quickly switch between multiple Linux distributions or other command lines (PowerShell, Command Prompt, Azure CLI, etc). You can fully customize your terminal with unique color schemes, font styles, sizes, background images, and custom keyboard shortcuts. [Learn more.](/en-us/windows/terminal)
- You can directly open your Linux distribution by visiting the Windows Start menu and typing the name of your installed distributions. For example: "Ubuntu". This will open Ubuntu in its own console window.
- From PowerShell, you can enter the name of your installed distribution. For example: `ubuntu`
- From PowerShell, you can open your default Linux distribution inside your current command line, by entering: `wsl.exe`.
- From PowerShell, you can use your default Linux distribution inside your current command line, without entering a new one, by entering:`wsl [command]`. Replacing `[command]` with a WSL command, such as: `wsl -l -v` to list installed distributions or `wsl pwd` to see where the current directory path is mounted in wsl. From PowerShell, the command `Get-Date` will provide the date from the Windows file system and `wsl date` will provide the date from the Linux file system.

The method you select should depend on what you're doing. If you've opened a WSL command line within a PowerShell window and want to exit, enter the command: `exit`.

## Want to try the latest WSL preview features?

Try the most recent features or updates to WSL by joining the [Windows Insiders Program](https://www.microsoft.com/windowsinsider/getting-started). Once you have joined Windows Insiders, you can choose the channel you would like to receive preview builds from inside the Windows settings menu to automatically receive any WSL updates or preview features associated with that build. You can choose from:

- Canary Channel:
    - Ideal for highly technical users.
    - Preview the latest platform changes early in the development cycle.
    - These builds can be unstable and are released with limited to no documentation.
- Dev Channel:
    - Ideal for enthusiasts.
    - Access the latest Windows 11 preview builds as we incubate new ideas and develop long lead features.
    - There will be some rough edges and low stability.
- Beta Channel:
    - Ideal for early adopters.
    - Preview and provide feedback on pre-release features for Windows 11 in a stable environment.
- Release Preview Channel:
    - Ideal if you want to preview fixes and certain key features, plus get optional access to the next version of Windows before it’s generally available to the world.
    - This channel is also recommended for commercial users.

If you prefer not switching your Windows installation to a preview channel, you can still test the latest preview of WSL by issuing the command:

```powershell
wsl.exe --update --pre-release
```

For more information check the [WSL Releases page on GitHub](https://github.com/microsoft/WSL/releases).
