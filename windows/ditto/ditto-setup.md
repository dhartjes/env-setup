# Ditto
Copy and paste tool with multiple buffers and the ability to save commonly used pastes with a global keybinding. I've configured a second copy/paste buffer for with [ctrl]+[-] to copy and [ctrl]+[=] to paste.

## Steps
1. Install in PS: ```winget install Ditto.Ditto```

## Configuration
1. Default keyboard shortcut is Ctrl+`. Modify it to Alt+` to make space for VS Code's open terminal shortcut.
1. Import settings with ```reg import HKEY_CURRENT_USER\Software\Ditto <DittoConf.reg-file-path>``` which is saved in this repo.

## To Export settings
In PS, ```reg export HKEY_CURRENT_USER\Software\Ditto DittoConf.reg```