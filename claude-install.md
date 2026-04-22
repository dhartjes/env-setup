# Setting Up Claude Code in VS Code with WSL

## Prerequisites

- A Claude Pro or Max subscription (or Anthropic API credits)
- VS Code installed on Windows (covered in [Install VS Code](../windows-setup/vscode-setup/))
- VS Code's WSL extension (covered in [VS Code Extensions](../windows-setup/vscode-setup/vscode-extensions.md))
- WSL2 set up with a Linux distro (e.g. Ubuntu) (covered in [WSL Setup](../windows-setup/wsl/wsl-setup.md))
- Node.js 18+ installed inside WSL (not Windows) (covered in [Install Volta](../npm-setup/install-volta.md))
- wslview so WSL2 can perform authentication using your windows browser. (covered in [Git Authentication](../git-setup/git-authentication.md))

## Steps
1. Install Claude Code CLI inside WSL: ```npm install -g @anthropic-ai/claude-code```. Never use sudo npm install -g — it creates permission issues that Anthropic explicitly warns against.
1. Authenticate. Run ```claude``` in your WSL terminal. If wslview is set up, a browser will open to request authentication.
1. Connect VS Code to WSL by either: 
    - Navigating to your project folder in WSL terminal and typing ```code .``` or,
    - Opening the command pallete in VS Code with Ctrl+Shift+P and typing "WSL: Open Folder in WSL"
1. Launch the integrated terminal with Ctrl+` and type ```claude```
1. Verify whether Claude Code for VS Code was automatically installed once claude was launched in the terminal.

## Configuration
1. In the Side bar next to "Chat", click the ... and select Claude Code. This uses your secondary sidebar rather than a code window for your chat session.
1. Open keyboard shortcuts with Ctrl+K, Ctrl+S and search for "Ctrl+Esc". This shows all the shortcuts related to claude code. However, Ctrl+Esc is used in Windows to open the start menu. Change these shortcuts in VS Code by replacing Ctrl with Win in each desired shortcut.