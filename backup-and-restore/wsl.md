# WSL Instance Backup and Restore

## Backup

Run from PowerShell on Windows. First stop the distro to ensure a consistent export:

```powershell
wsl --terminate Ubuntu
```

Then export it to a `.tar` file:

```powershell
wsl --export Ubuntu C:\Backups\ubuntu-backup.tar
```

Replace `Ubuntu` with your distro name if different. Check installed distros with `wsl --list`.

## Restore

```powershell
wsl --import Ubuntu C:\WSL\Ubuntu C:\Backups\ubuntu-backup.tar
```

The second argument is where WSL will store the virtual disk. After import, set it as default if needed:

```powershell
wsl --set-default Ubuntu
```

Your default Linux user may reset to `root` after an import. To fix it, open the distro and run:

```powershell
ubuntu config --default-user <your-username>
```

## Notes

- The export includes your entire Linux filesystem — home directory, installed packages, configuration, and the `pass` password store.
- Back up your GnuPG keys separately (see [GnuPG](gnupg.md)) — the export captures the encrypted files but you still need the keys to decrypt them on a new machine.

<-- Top: [Back to Readme](../README.md)
--> Next: [GnuPG](gnupg.md)
