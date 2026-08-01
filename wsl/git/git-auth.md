# Git Authentication

<-- [Back to README](../../README.md)

Git authentication differs between personal home computers and corporate work machines. Choose the path below that matches your target environment.

- **[Option A: GitHub CLI (gh) via HTTPS](#option-a-github-cli-gh-via-https-recommended-for-home--github-work)** — **RECOMMENDED** for personal home workstations and work GitHub repositories. (Zero-dependency, lightweight).
- **[Option B: Git Credential Manager (GCM)](#option-b-git-credential-manager-gcm-optional---work--azure-devops-only)** — **OPTIONAL (Work Setup Only)** required for corporate environments using Azure DevOps and Microsoft Entra ID (MSAL).

---

## Option A: GitHub CLI (gh) via HTTPS (RECOMMENDED for Home & GitHub Work)

This is the standard authentication method for personal development and general GitHub-hosted work repositories. It replaces SSH keys entirely, requires no external databases or runtime environments (like .NET or local credential-store daemons), and is managed natively by `mise`.

### 1. Install GitHub CLI via `mise`

Since `mise` is already installed, add `gh` to your global tools:

```bash
mise use --global gh@latest
```

### 2. Authenticate with GitHub

Run the login wizard and follow the prompts:

```bash
gh auth login
```

Choose these options during setup:
1. **What account do you want to log into?** `GitHub.com`
2. **What is your preferred protocol for Git operations?** `HTTPS`
3. **How would you like to authenticate GitHub CLI?** `Login with a web browser` (this will automatically launch your default browser on Windows via `wslview` to complete the secure OAuth handshake).

### 3. Register `gh` as your Git Credential Helper

Configure Git to use the GitHub CLI as your credential manager for all HTTPS operations. You will never be prompted for your username or password again:

```bash
gh auth setup-git
```

Test with:
```bash
git ls-remote https://github.com/dhartjes/env-setup.git
```

---

## Option B: Git Credential Manager (GCM) (OPTIONAL - Work & Azure DevOps Only)

> [!IMPORTANT]
> **OPTIONAL (Work Setup Only)**: This complex configuration is only required on your work machine to access corporate Azure DevOps repositories secured by Microsoft Entra ID (MSAL) single-sign-on. It is entirely unnecessary for your personal home workstation.
>
> *Note for Work Setup:* For any work-related repositories hosted on **GitHub**, you are welcome to use the lightweight **Option A (GitHub CLI)** instead to simplify your workspace, though GCM remains the required default for Azure DevOps.

### Requirements

- **Dotnet SDK 8.0**: To test: `dotnet --list-sdks` To install: `sudo apt update && sudo apt upgrade && sudo apt install dotnet-sdk-8.0`
- **WSL2 with systemd enabled**: To verify: `cat /etc/wsl.conf` should contain `systemd=true` under `[boot]`. If not, add it and restart WSL2 with `wsl --shutdown` from PowerShell.

### Steps

1. Install GCM via dotnet tool or direct package download:
   - **Method 1 (Preferred)**:
     ```bash
     dotnet tool install -g git-credential-manager
     ```
   - **Method 2 (Fallback .deb package)**:
     ```bash
     # Download official release
     wget https://github.com/GitCredentialManager/git-credential-manager/releases/download/v2.0.935/gcm-linux_amd64.2.0.935.deb

     # Unpack and fix dependencies
     sudo apt update && sudo apt upgrade
     sudo apt --fix-broken install
     ```

2. Add the .NET tools directory to your path in `~/.bashrc`:

   ```bash
   cat << \EOF >> ~/.bashrc
   # Add .NET Core SDK tools
   export PATH="$PATH:$HOME/.dotnet/tools"

   # Required for GPG passphrase prompting
   export GPG_TTY=$(tty)
   
   # Required for browser-based auth prompts in WSL2
   export BROWSER=wslview
   EOF
   source ~/.bashrc
   ```

3. Install keyring and pass dependency packages:
   ```bash
   sudo apt update && sudo apt upgrade && sudo apt install -y gpg pass pinentry-curses libsecret-1-0 libsecret-tools gnome-keyring wslu
   ```

4. Create and initialize your GPG key:
   ```bash
   # Choose no passphrase when prompted
   gpg --gen-key
   
   # Note the generated fingerprint shown under the "pub" line, e.g., E54EFA45...
   # Initialize pass with your fingerprint:
   pass init <your-gpg-key-fingerprint>
   ```

5. Configure pinentry-curses for GPG prompting:
   ```bash
   echo "pinentry-program /usr/bin/pinentry-curses" >> ~/.gnupg/gpg-agent.conf
   gpg-connect-agent reloadagent /bye
   ```

6. Enable gnome-keyring-daemon via systemd to persist tokens securely:
   ```bash
   systemctl --user enable gnome-keyring-daemon.service
   systemctl --user start gnome-keyring-daemon.service
   ```
   *Note: If prompted to enter a password for the new keyring, leave it blank so it unlocks automatically on non-interactive Git commands.*

7. Bind GCM to Git:
   ```bash
   git-credential-manager configure
   git config --global credential.credentialstore gpg
   ```

### Sources

- [GCM Linux Configuration](https://github.com/git-ecosystem/git-credential-manager)
- [Microsoft Entra ID WSL Single-Sign-On](https://learn.microsoft.com/en-us/azure/devops/repos/git/set-up-credential-managers?view=azure-devops)

<-- Prev: [Git Configuration](git-config.md)
--> Next: [Git Clone Repos](git-clone-repos.md)
