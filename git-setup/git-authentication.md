# Git Authentication

## SSH Keygen

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
