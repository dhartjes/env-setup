# Git Authentication

## SSH Keygen
```
# Generate SSH Key
ssh-keygen -t ed25519 -C "dhartjes.work@gmail.com"

# At prompt:
#   - enter filename id_git-dhartjes-work
#   - enter passphrase from secure notes

# Retrieve public key
cat id_git-dhartjes-work.pub
> ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILezi7mWCTfgVBJekzn5lsBw9XsgRu0LoJdAkpAnX6tI dhartjes.work@gmail.com

# Copy to clipboard and add to GitHub
```

### Sources
- https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux
- https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

<-- Prev: [Git Configuration](./git-configuration.md)
--> Next: [Git Clone Repos](./git-clone-repos.md)

