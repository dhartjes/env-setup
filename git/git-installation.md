# Git Installation

## For WSL2:Ubuntu
The latest stable version of git may not be available in your default Ubuntu repository. You can add Git's personal package archive to your list of repositories in apt.

```bash
sudo add-apt-repository ppa:git-core/ppa
sudo apt update && sudo apt upgrade -y
sudo apt install git
```

### Source:
- https://linuxvox.com/blog/update-git-ubuntu/#method-2-installing-from-the-git-core-ppa

## For Windows
[Install instructions](https://git-scm.com/install/windows)

<-- Prev: [WSL Config](../windows/wsl/wsl-config.md)
--> Next: [Git Configuration](./git-configuration.md)
