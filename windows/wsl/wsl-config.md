# WSL Configuration

Be sure to check [Best Practices for Setup](https://learn.microsoft.com/en-us/windows/wsl/setup/environment) for updates. On 4/20/2026, these were the pertinent steps.

## Steps
1. Update the packages with ```sudo apt update && sudo apt upgrade```
1. Installation script requirements for Oh-My-Posh:
   ```
   sudo apt install curl
   sudo apt install unzip
   ```
1. Installation requirements for VS Code Remote Development extension:
   ```
   sudo apt-get update
   sudo apt-get install wget ca-certificates
   ```  
1. Install oh-my-posh following these instructions: https://ohmyposh.dev/docs/installation/linux
1. Install (or update) git for linux with ```sudo apt-get install git```
1. Use nano to update your ~/.bashrc file to load your desired prompt configuration.
   ```
   # Last line of ~/.bashrc file
   eval "$(oh-my-posh init bash --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/blue-owl.omp.json)"
   ```

## Tips
Update the packages regularly with ```sudo apt update && sudo apt upgrade```

<-- Prev: [WSL Setup](./wsl-setup.md)
--> Next: [Git Install](../../git/git-installation.md)
