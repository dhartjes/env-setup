# Migrating to mise (Windows)

<-- [Back to README](../README.md) | [Migration Overview](../migrations/migrate-to-mise.md) | [WSL/Linux Migration Guide](../wsl/migrate-to-mise.md) | [Install mise (WSL)](../wsl/mise-install.md)

`mise` is the unified workstation tool manager used in this environment. On Windows it replaces **Volta**, **nvm-windows**, **fnm**, and **Bob** (Neovim version manager).

Follow the steps below in PowerShell 7 to completely clean out old version managers before installing `mise`. For why this matters and the pitfalls of skipping it, see the [Migration Overview](../migrations/migrate-to-mise.md).

---

## 🛠️ Windows Migration Steps

Run these steps in PowerShell 7. None require an elevated/administrator session — all changes use `User`-scope PATH and environment variables.

### Step 1: Backup Any Custom Global Packages
Note any global npm packages you rely on (`npm list -g --depth=0`). Re-install them with `mise` afterward.

### Step 2: Remove Volta
```powershell
winget uninstall Volta.Volta
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\Volta" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$HOME\.volta" -ErrorAction SilentlyContinue
```
Then open `$PROFILE` (`code $PROFILE`) and delete any `volta setup` line.

### Step 3: Remove nvm-windows
```powershell
winget uninstall CoreyButler.NVMforWindows
```
If it was installed via the standalone installer instead of winget, run its uninstaller from **Settings > Apps > Installed Apps**, then clean up the leftover data directory:
```powershell
Remove-Item -Recurse -Force "$env:APPDATA\nvm" -ErrorAction SilentlyContinue
```
Open `$PROFILE` and remove any `NVM_HOME` / `NVM_SYMLINK` references. If `C:\Program Files\nodejs` is a leftover nvm-windows symlink (not a real Node.js install), remove it via **System Properties > Environment Variables** or:
```powershell
[Environment]::SetEnvironmentVariable("PATH", (($env:PATH -split ';') -notmatch 'nodejs$' -join ';'), "User")
```

### Step 4: Remove fnm
```powershell
winget uninstall Schniz.fnm
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\fnm" -ErrorAction SilentlyContinue
```
Remove any `fnm env` line from `$PROFILE`.

### Step 5: Remove a Directly-Installed Node.js
If Node.js was installed standalone (not via a version manager):
```powershell
winget uninstall OpenJS.NodeJS
winget uninstall OpenJS.NodeJS.LTS
```

### Step 6: Remove Bob (Neovim Version Manager)
```powershell
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\bob" -ErrorAction SilentlyContinue
```
If Bob itself was installed via `cargo` or `npm`, also remove the binary:
```powershell
cargo uninstall bob-nvim -ErrorAction SilentlyContinue
npm uninstall -g @mordechaim/bob-nvim
```
Then remove `%LOCALAPPDATA%\bob\nvim-bin` from your User `PATH` (System Properties > Environment Variables, or the command in Step 3).

### Step 7: Clean Your PowerShell Profile
```powershell
code $PROFILE
```
Remove any leftover `volta setup`, `fnm env`, `nvm`, or Bob-related lines.

### Step 8: Restart Your Terminal & Verify
Close and reopen Windows Terminal, then confirm the old tools are gone:
```powershell
Get-Command volta -ErrorAction SilentlyContinue
Get-Command nvm -ErrorAction SilentlyContinue
Get-Command fnm -ErrorAction SilentlyContinue
Get-Command bob -ErrorAction SilentlyContinue
```
Each should return nothing.

---

## 🏁 Installing mise on Windows

```powershell
winget install jdx.mise
'(&mise activate pwsh) | Out-String | Invoke-Expression' >> $PROFILE
```
Restart your terminal, then set up your global tools:
```powershell
mise use --global node@lts
node --version
```

For Neovim managed via `mise` on Windows, see [wsl/nvim/nvim-install.md](../wsl/nvim/nvim-install.md) — this environment runs Neovim inside WSL, so no separate Windows-side Neovim install is needed unless you use Neovim natively on Windows too, in which case:
```powershell
mise use --global neovim@stable
nvim --version
```

Once done, run the Doctor Check to confirm your environment is clean — see the [Migration Overview](../migrations/migrate-to-mise.md#-running-doctor-check).

<-- [Back to README](../README.md) | [Migration Overview](../migrations/migrate-to-mise.md) | [WSL/Linux Migration Guide](../wsl/migrate-to-mise.md)
