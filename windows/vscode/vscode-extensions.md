# VS Code Extensions

<-- [Back to README](../../README.md)

## Save Extensions to file

```bash
code --list-extensions > extensions.txt
```

## Install Extensions saved in file

(In Powershell)

```bash
cd <location-of-extensions.txt>
Get-Content extensions.txt | ForEach-Object { code --install-extension $_ }
```

## Current Extensions (last-update: 20260225)

[Current Extensions List](extensions.txt)

## Sources

- [WSL | Lets you use VS Code to build Linux Applications that run on WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)
- [Dev Containers | Lets you use a Docker Container as a full-featured development environment](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker | Makes it easy to build, manage, and deploy containerized applications](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)

<-- Prev: [VS Code Install](./vscode-install.md)
