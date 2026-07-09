# WSL Configuration

<-- [Back to README](../../README.md)

Be sure to check [Best Practices for Setup](https://learn.microsoft.com/en-us/windows/wsl/setup/environment) for updates. On 4/20/2026, these were the pertinent steps.

## Steps

1. Update the packages with `sudo apt update && sudo apt upgrade`
1. Installation requirements for VS Code Remote Development extension:

   ```bash
   sudo apt-get update && sudo apt-get upgrade
   sudo apt-get install wget ca-certificates
   ```  

1. Install (or update) git for linux with:

   ```bash
   sudo apt-get update && sudo apt-get upgrade
   sudo apt-get install git
   ```

1. Install and configure **Oh My Posh** for WSL by following the central [Oh My Posh Setup Guide](../terminal/oh-my-posh.md). It details font dependencies, package requirements, and configuring a high-performance, locally-cached `.omp.json` theme.


## Tips

Update the packages regularly with `sudo apt update && sudo apt upgrade`

<-- Prev: [WSL Installation](wsl-install.md)
--> Next: [WSL Config](wsl-config.md)
