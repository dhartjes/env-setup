# Getting/Updating NVIM
Your OS package manager may have very outdated releases of NVIM. The Bob Neovim repo is a Neovim Package Manager meant to make it easy to get neovim and keep it up-to-date.

## Installation
1. Get Bob with ```curl -fsSL https://raw.githubusercontent.com/MordechaiHadad/bob/master/scripts/install.sh | bash```
1. Test with ```bob --version```

## Configuration
1. Enable shell auto-complete:
```
mkdir -p ~/.local/share/bash-completion/completions
bob complete bash >> ~/.local/share/bash-completion/completions/bob
```
1. Bob's add_neovim_binary_to_path option doesn't work if you don't use a .bash_profile file. I am currently only using .bashrc. When it asks if you'd like to automatically add neovim to your path, say no and it will give you the string that is needed to be added to your path in the .bashrc

## Usage
1. ```bob install stable```
1. ```bob use stable```
1. ```bob pin stable``` Pins it to a specific folder
1. ```nvim``` to launch nvim!