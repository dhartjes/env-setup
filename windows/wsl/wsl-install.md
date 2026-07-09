# Install WSL | Microsoft Learn

<-- [Back to README](../../README.md)

Developers can access the power of both Windows and Linux at the same time on a Windows machine. The Windows Subsystem for Linux (WSL) lets developers install a Linux distribution (such as Ubuntu, OpenSUSE, Kali, Debian, Arch Linux, etc) and use Linux applications, utilities, and Bash command-line tools directly on Windows, unmodified, without the overhead of a traditional virtual machine or dualboot setup.

## Prerequisites

You must be running Windows 10 version 2004 and higher (Build 19041 and higher) or Windows 11 to use the commands below.

## Install WSL command

You can now install everything you need to run WSL with a single command. Open PowerShell in **administrator** mode by right-clicking and selecting "Run as administrator", enter the wsl --install command, then restart your machine.

```powershell
wsl --install
```

This command will enable the features necessary to run WSL and install the Ubuntu distribution of Linux.

The first time you launch a newly installed Linux distribution, a console window will open and you'll be asked to wait for files to de-compress and be stored on your machine. All future launches should take less than a second.

Note

The above command only works if WSL is not installed at all. If you run `wsl --install` and see the WSL help text, please try running `wsl --list --online` to see a list of available distros and run `wsl --install -d <DistroName>` to install a distro. If the install process hangs at 0.0%, run `wsl --install --web-download -d <DistroName>` to first download the distribution prior to installing. 

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

## Set up your Linux user info

Once you have installed WSL, you will need to create a user account and password for your newly installed Linux distribution.

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

<-- Prev: [Terminal Setup](../terminal/terminal-setup.md)
--> Next: [WSL Setup](wsl-setup.md)