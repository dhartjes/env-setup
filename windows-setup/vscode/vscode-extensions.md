# VS Code Extensions

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

ms-azuretools.vscode-azureresourcegroups
ms-azuretools.vscode-azurevirtualmachines
ms-azuretools.vscode-containers
ms-azuretools.vscode-docker
ms-dotnettools.csdevkit
ms-dotnettools.csharp
ms-dotnettools.vscode-dotnet-runtime
ms-vscode-remote.remote-containers
ms-vscode-remote.remote-wsl
visualstudiotoolsforunity.vstuc

## Sources

- [WSL | Lets you use VS Code to build Linux Applications that run on WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)
- [Dev Containers | Lets you use a Docker Container as a full-featured development environment](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker | Makes it easy to build, manage, and deploy containerized applications](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
