# Git Authentication

## Using Git Credential Manager and Microsoft Entra ID

### Requirements
- Dotnet SDK 8.0. To test: ```dotnet --list-sdks``` To install: ```sudo apt install dotnet-sdk-8.0```
- WSL2 with systemd enabled. To verify: ```cat /etc/wsl.conf``` should contain ```systemd=true``` under ```[boot]```. If not, add it and restart WSL2 with ```wsl --shutdown``` from PowerShell.

### Steps
1. Install GCM with dotnet from terminal: ```dotnet tool install -g git-credential-manager```
1. Add to path in ```~/.bashrc```:
   ```
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
1. Install required dependencies: ```sudo apt install gpg pass pinentry-curses libsecret-1-0 libsecret-tools gnome-keyring wslu```
1. Set up GPG key:
   ```
   gpg --gen-key
   # Note the fingerprint shown below the pub line, e.g:
   # E54EFA45F8D5F8ECA38DB84521DC54A53F0E5F89
   ```
   Ensure you save this credential in a password manager.
1. Initialize ```pass``` with your GPG key fingerprint: ```pass init <your-gpg-key-fingerprint>```
1. Configure pinentry-curses for GPG:
   ```
   echo "pinentry-program /usr/bin/pinentry-curses" >> ~/.gnupg/gpg-agent.conf
   gpg-connect-agent reloadagent /bye
   ```
1. Enable and start gnome-keyring via systemd for MSAL token persistence:
   ```
   systemctl --user enable gnome-keyring-daemon.service
   systemctl --user start gnome-keyring-daemon.service
   ```
   When prompted to set a keyring password, leave it blank so the keyring unlocks automatically in non-interactive git operations.
1. Configure CGM:
   ```
   git-credential-manager configure
   git config --global credential.credentialstore gpg
   ```

### Source
- https://learn.microsoft.com/en-us/dotnet/core/install/linux
- https://learn.microsoft.com/en-us/azure/devops/repos/git/set-up-credential-managers?view=azure-devops
- https://github.com/git-ecosystem/git-credential-manager
## SSH Keygen (Deprecated)

```bash
# Generate SSH Key
ssh-keygen -t ed25519 -C "dhartjes.work@gmail.com"

# At prompt:
#   - enter filename id_git-dhartjes-work
#   - enter passphrase from secure notes

# Retrieve public key
cat id_git-dhartjes-work.pub
> ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILezi7mWCTfgVBJekzn5lsBw9XsgRu0LoJdAkpAnX6tI dhartjes.work@gmail.com

# Copy to clipboard and add to GitHub

# To avoid using the passphrase with each operation, add the private key to your ssh-agent
eval "$(ssh-agent -s)"
> Agent pid xxxx
ssh-add ~/.ssh/id_git-dhartjes-work
```

## Using SSH with Visual Studio Code

If you want to use VSCode's periodic commit to git feature or simply want to avoid entering your ssh passcode each time you lauch terminal -> vscode, this step was able to help me. 

In Linux, create a ~/.ssh/config file to make loading of your ssh key automatic

```text
Host *
IgnoreUnknown UseKeychain
UseKeychain yes
AddKeysToAgent yes
IdentityFile ~/.ssh/id_git-dhartjes-work
```

### Sources

- <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux>
- <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account>
- <https://stackoverflow.com/questions/34634364/to-use-git-push-on-visual-studio-code-but-show-could-not-read-from-remote-re>

<-- Prev: [Git Configuration](./git-configuration.md)
--> Next: [Git Clone Repos](./git-clone-repos.md)
