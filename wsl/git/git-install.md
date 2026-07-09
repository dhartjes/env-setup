# Git Installation (Ubuntu/WSL2)

<-- [Back to README](../../README.md)

The latest stable version of git may not be available in your default Ubuntu repository. You can add Git's personal package archive to your list of repositories in apt.

```bash
sudo add-apt-repository ppa:git-core/ppa
sudo apt update && sudo apt upgrade -y
sudo apt install git
```

### Source:
- https://linuxvox.com/blog/update-git-ubuntu/#method-2-installing-from-the-git-core-ppa

<-- Prev: [WSL Config](../../windows/wsl/wsl-config.md)
--> Next: [Git Installation (Windows)](../../windows/git-windows-install.md)
