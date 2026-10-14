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
Get-Content \\wsl.localhost\Ubuntu\home\dhartjes\projects\env-setup\windows\vscode\extensions.txt | ForEach-Object { code --install-extension $_ }
```

## Current Extensions (last-update: 20260225)

[Current Extensions List](extensions.txt)

## vscode-pandoc

Renders the open Markdown file to PDF, DOCX, or HTML via Pandoc (`Ctrl+K P`, or **Pandoc Render** from the command palette).

Prerequisites: [Pandoc and MiKTeX](../pandoc-install.md) on Windows, and [Pandoc and Tectonic](../../wsl/pandoc-install.md) on WSL.

```powershell
code --install-extension ChrisChinchilla.vscode-pandoc
```

The extension runs on the workspace side, so when a folder is opened through Remote - WSL it calls the `pandoc` (and `pdflatex`) found in WSL, not the Windows install. Repos you edit from WSL need [Pandoc and Tectonic](../../wsl/pandoc-install.md) installed in WSL too, plus a WSL remote setting that points PDF output at Tectonic.

## Sources

- [WSL | Lets you use VS Code to build Linux Applications that run on WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)
- [Dev Containers | Lets you use a Docker Container as a full-featured development environment](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [vscode-pandoc | Renders Markdown to PDF, DOCX, or HTML via Pandoc](https://marketplace.visualstudio.com/items?itemName=ChrisChinchilla.vscode-pandoc)
- [Docker | Makes it easy to build, manage, and deploy containerized applications](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)

<-- Prev: [Pandoc and Tectonic (WSL)](../../wsl/pandoc-install.md)
--> Next: [Rancher Desktop](../rancher-desktop/rancher-desktop.md)
