# Migrating to mise (Polyglot Tool Manager)

<-- [Back to README](../README.md) | [Install mise (WSL)](../wsl/mise/mise-install.md) | [Install mise (Windows)](../windows/mise/mise-install.md)

`mise` is the unified workstation tool manager used in this environment. It replaces several language/runtime version managers, including **Volta**, **fnm**, **NVM** (**nvm-windows** on Windows), **Pyenv** (WSL only), and **Bob**.

To prevent conflicts and ensure a seamless transition, you **MUST** completely uninstall your existing version managers before activating `mise`.

Pick your platform's step-by-step guide below:

- [WSL Migration Steps](#-wsl-migration-steps)
- [Windows Migration Steps](#-windows-migration-steps)

---

## ⚠️ The Golden Rule: Clean Slate First

Installing languages/runtimes (especially **Node.js**) through `mise` while older managers are still active is the single most common cause of setup issues.

> [!CAUTION]
> **Do not skip the uninstall step!** Even if `mise` installs successfully, pre-existing version managers earlier on your `PATH` (or `$PROFILE` / `~/.bashrc` shell hooks) will intercept your commands, causing subtle, hard-to-debug version mismatches and broken global tools.

---

## 🚫 Critical Pitfalls of Coexistence

If you do not uninstall older tools before setting up `mise`, you will likely encounter these issues:

### 1. PATH Hijacking and Command Interception
Version managers add their own executable directory to the front of your `PATH`.
- **WSL**: Volta and NVM inject configuration blocks into `~/.bashrc` that prepend to `$PATH`.
- **Windows**: Volta, nvm-windows, and fnm prepend their directory to your **User** `PATH` environment variable (no admin rights required to change this).
- Even with `mise` active, if the old tool's path is listed first, `node -v` will keep resolving to it, completely ignoring your `mise` configuration.

### 2. The Volta Shim Trap
Volta does not place real executables on your path — it places **shims** (dummy symlinks/redirects) for `node`, `npm`, `npx`, `yarn`, and `pnpm` in `~/.volta/bin` (WSL) or `%LOCALAPPDATA%\Volta\bin` (Windows). Left in place, these shims intercept any call to Node.js and route it to Volta's engines, breaking `mise`'s ability to switch Node.js versions on the fly.

### 3. NVM / nvm-windows Interception
- **WSL**: NVM is not a standalone executable — it's loaded as a series of bash functions when your terminal starts. These override standard executable lookup rules regardless of `PATH` order; if NVM is sourced in `~/.bashrc`, running `node` will always invoke NVM.
- **Windows**: `nvm-windows` (coreybutler/nvm-windows) works differently — it rewrites a symlink at `%NVM_SYMLINK%` (default `C:\Program Files\nodejs`) to point at whichever version is currently selected via `nvm use`. If that directory is still on `PATH`, it wins over `mise` regardless of shell activation order.

### 4. Bob's Neovim Shim
Bob stores its downloaded Neovim versions and shim in `~/.local/share/bob` + `~/.local/bin/bob` (WSL) or `%LOCALAPPDATA%\bob\nvim-bin` (Windows). Left on `PATH`, `nvim` keeps launching Bob's selected version instead of `mise`'s.

### 5. Global Package Contamination
If you run `npm install -g <package>` while Volta, NVM/nvm-windows, or system Node is active, the package installs into that tool's proprietary global storage. If you then try to run the tool (like `tree-sitter` or `claude`), it will fail to launch or run under the wrong Node engine.

### 6. Shell Startup Lag (WSL)
Loading NVM's startup script (`nvm.sh`), Volta's hooks (`volta setup`), Bob, and Pyenv hooks simultaneously adds **0.5–2.0 seconds** of lag to *every single terminal session* you open. `mise` is written in Rust and activates instantly (< 10ms).

---

## 🛠️ WSL Migration Steps

Follow these steps in your WSL (Ubuntu) terminal to completely clean out old version managers before installing `mise`.

### Step 1: Backup Any Custom Global Packages
Make a mental or physical list of global packages you currently rely on (e.g., `npm list -g --depth=0`). You will re-install these instantly using `mise` globals later.

### Step 2: Remove Volta (Node.js)
1. Delete the Volta directory:
   ```bash
   rm -rf ~/.volta
   ```
2. Open `~/.bashrc` (or your profile script) in your editor (e.g., `nvim ~/.bashrc`):
   ```bash
   nano ~/.bashrc
   ```
3. Locate and delete the Volta configuration block:
   ```bash
   # Remove these lines:
   export VOLTA_HOME="$HOME/.volta"
   export PATH="$VOLTA_HOME/bin:$PATH"
   ```

### Step 3: Remove NVM (Node Version Manager)
1. Delete the NVM directory:
   ```bash
   rm -rf ~/.nvm
   ```
2. Open `~/.bashrc` and delete the NVM initialization block:
   ```bash
   # Remove these lines:
   export NVM_DIR="$HOME/.nvm"
   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
   [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
   ```

### Step 4: Remove APT/System Node.js
If you have a standard system-wide Node.js installed via Ubuntu's package manager:
```bash
sudo apt-get purge nodejs npm -y
sudo apt-get autoremove -y
```

### Step 5: Remove Homebrew / Linuxbrew Node.js
If you installed Node.js or npm via Homebrew (Linuxbrew):
1. Uninstall the formulas:
   ```bash
   brew uninstall node
   # Also remove any pinned/versioned node formulas if installed:
   brew uninstall node@22 node@20 node@18 node@16 --force
   ```
2. Clean up any lingering unused dependencies or lockfiles:
   ```bash
   brew cleanup
   ```
3. **Optional (Highly Recommended):** Since `tree-sitter-cli` (the only tool in this guide originally using Homebrew) is now managed by `mise`, you can uninstall Homebrew entirely to reclaim 10-15 minutes of terminal startup overhead and gigabytes of disk space:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
   ```

### Step 6: Remove Pyenv (Python)
1. Delete the Pyenv directory:
   ```bash
   rm -rf ~/.pyenv
   ```
2. Open `~/.bashrc` and delete the Pyenv configuration block:
   ```bash
   # Remove these lines:
   export PYENV_ROOT="$HOME/.pyenv"
   [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
   eval "$(pyenv init -)"
   ```

### Step 7: Remove Bob (Neovim Version Manager)
1. Delete Bob's storage and binary:
   ```bash
   rm -rf ~/.local/share/bob
   rm -f ~/.local/bin/bob
   ```
2. If you added Bob's shim/binary path to `~/.bashrc`, remove those lines as well.

### Step 8: Reload Your Shell & Verify
Close and reopen your terminal, or force a fresh shell:
```bash
exec bash --login
```

Verify that the old tools are completely gone. The following commands should return "command not found" or "not installed":
```bash
command -v node
command -v npm
command -v nvm
command -v pyenv
command -v bob
command -v volta
```

### 🏁 Installing mise (WSL)

Now that your environment is clean, install and activate `mise`, then install tools with it — see [Install mise (WSL)](../wsl/mise/mise-install.md) and [Mise Tools (WSL)](../wsl/mise/mise-tools.md).

---

## 🛠️ Windows Migration Steps

Run these steps in PowerShell 7 to completely clean out old version managers before installing `mise`. None require an elevated/administrator session — all changes use `User`-scope PATH and environment variables.

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

### 🏁 Installing mise (Windows)

Once the machine is clean, install and activate `mise`, then install tools with it — see [Install mise (Windows)](../windows/mise/mise-install.md) and [Mise Tools (Windows)](../windows/mise/mise-tools.md).

---

## 🩺 Running Doctor Check

After completing migration on either platform, run the Doctor script to verify no remnants of old version managers are lingering and that all tools are successfully aligned:

```bash
# In WSL
./doctor.sh
```

```powershell
# In Windows PowerShell
.\doctor.ps1
```

---

## ✅ Status: complete

Confirmed 2026-09-10 — every tool this migration set out to move onto `mise` has been: this section is kept as a historical record rather than an open plan (it previously lived as a separate "Future Phase" tracking doc that was deleted once every item on it was verified done).

| Tool | Previously documented in | Replaced by |
| --- | --- | --- |
| Volta (Node.js, WSL) | `wsl/volta-install.md` (deleted, orphaned once replaced) | `wsl/mise/mise-install.md` + `wsl/mise/mise-tools.md` — `mise use --global node@lts` |
| Volta/fnm (Node.js, Windows) | `optimizely/cfg/frontend-tools-setup.md` (now `optimizely/cfg/mise-tools.md` / `windows/mise/`) | `winget install jdx.mise` + `mise use --global node@lts` |
| pyenv (Python) | `wsl/python/python-setup.md` | `mise use --global python@3.13` |
| Bob (Neovim) | `wsl/nvim/nvim-install.md` | `mise use --global neovim@stable` |
| Homebrew (tree-sitter-cli) | `wsl/tree-sitter-install.md` | `mise use --global npm:tree-sitter-cli` |

### Why mise over the tools it replaced

- **Python**: mise downloads pre-built binaries, so the pyenv-era build dependencies (`libssl-dev`, `zlib1g-dev`, etc.) needed to compile Python from source are no longer required. `apt install python3` is still appropriate for scripts that should track the OS; use mise Python for project-specific or version-pinned work.
- **Neovim**: mise replaces Bob directly. Bob's `.bashrc` PATH concerns go away since mise handles PATH via its activation hook.
- **tree-sitter-cli / Homebrew**: Homebrew was only ever installed for `tree-sitter-cli`; moving that one package to `mise use --global npm:tree-sitter-cli` let Homebrew be removed entirely, avoiding its 10-15 minute install and multi-gigabyte footprint on WSL.

<-- [Back to README](../README.md) | [Install mise (WSL)](../wsl/mise/mise-install.md) | [Install mise (Windows)](../windows/mise/mise-install.md)
