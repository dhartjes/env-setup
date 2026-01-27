# Git Installation
`sudo apt update && sudo apt upgrade -y
sudo apt install curl git -y`

# Git Configuration
`
git config --global init.defaultBranch main
git config --global user.email "dhartjes.work@gmail.com"
git config --global user.name "Dominic Hartjes"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_git-dhartjes-work
`

# Git Authentication
## SSH Keygen
`
# Generate SSH Key
ssh-keygen -t ed25519 -C "dhartjes.work@gmail.com"
#   - enter filename id_git-dhartjes-work
#   - enter passphrase from secure notes

# Retrieve public key
cat id_git-dhartjes-work.pub
> ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILezi7mWCTfgVBJekzn5lsBw9XsgRu0LoJdAkpAnX6tI dhartjes.work@gmail.com
# Copy to clipboard and add to GitHub
`
### Sources
- https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux
- https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
- 

## Misfiled
`
curl -fsSL https://claude.ai/install.sh | bash
curl https://get.volta.sh | bash
sudo apt install neovim

`
