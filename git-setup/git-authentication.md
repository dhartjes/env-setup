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

If you want to use VSCode's periodic commit to git feature or simply want to avoid entering your ssh passcode each time you lauch terminal -> vscode, the steps at <https://stackoverflow.com/questions/34634364/to-use-git-push-on-visual-studio-code-but-show-could-not-read-from-remote-re> were able to help me.

1. In Linux, create a ~/.ssh/config file to make loading of your ssh key automatic

    ```text

        Host *
        IgnoreUnknown UseKeychain
        UseKeychain yes
        AddKeysToAgent yes
        IdentityFile ~/.ssh/id_git-dhartjes-work
    ```

1. Ensure the TODO: finish
Not sure I'm doing this right at the moment, but if I run my git-auth alias before opening the project in vs code with `code .` I am able to commit to github.

### Sources

- <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux>
- <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account>

<-- Prev: [Git Configuration](./git-configuration.md)
--> Next: [Git Clone Repos](./git-clone-repos.md)
