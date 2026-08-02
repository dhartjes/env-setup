# Migrating to mise (Polyglot Tool Manager)

<-- [Back to README](../README.md) | [Go to Install mise Guide](mise-install.md)

`mise` is the unified workstation manager used in this environment. It replaces several language-specific version managers, including **Volta**, **fnm**, **NVM**, **Pyenv**, and **Bob**.

To prevent conflicts and ensure a seamless transition, you **MUST** completely uninstall your existing version managers before activating `mise`.

---

## ⚠️ The Golden Rule: Clean Slate First

Installing languages/runtimes (especially **Node.js**) through `mise` while older managers are still active is the single most common cause of setup issues.

> [!CAUTION]
> **Do not skip the uninstall step!** Even if `mise` installs successfully, pre-existing version managers on your PATH will intercept your commands, causing subtle, hard-to-debug version mismatches and broken global tools.

---

## 🚫 Critical Pitfalls of Coexistence

If you do not uninstall older tools before setting up `mise`, you will likely encounter these issues:

### 1. PATH Hijacking and Command Interception
Version managers like Volta and NVM inject shell configuration blocks into your `~/.bashrc` (WSL) or `$PROFILE` (PowerShell). They add their own executable directory to the top of your `$PATH`. 
* Even if `mise` is active, if Volta's path is listed first, running `node -v` will execute Volta's version, completely ignoring your `mise` configuration.

### 2. The Volta Shim Trap
Volta does not place real executables on your path. It places **shims** (dummy symlinks/redirects) for `node`, `npm`, `npx`, `yarn`, and `pnpm`.
* If Volta is not uninstalled, these shims remain in `~/.volta/bin` (or `AppData\Local\Volta\bin` on Windows).
* These shims are designed to intercept any call to Node.js and route it to Volta's engines. This will break `mise`'s ability to switch Node.js versions on the fly.

### 3. NVM's Shell Function Overrides
NVM is not a standalone executable; it is loaded as a series of bash functions when your terminal starts.
* These functions override standard executable lookup rules. If NVM is sourced in your `~/.bashrc`, running `node` will always invoke NVM, even if `mise` is placed first on your physical PATH.

### 4. Global Package Contamination
If you run `npm install -g <package>` while Volta, NVM, or system Node are active:
* The package will be installed in Volta's or NVM's proprietary global storage.
* If you then try to run the tool (like `tree-sitter` or `claude`), it will fail to launch or run under the wrong Node engine.

### 5. Extreme Shell Startup Lag
Loading NVM's startup scripts (`nvm.sh`), Volta's hooks (`volta setup`), Bob, and Pyenv hooks simultaneously adds **0.5 to 2.0 seconds** of lag to *every single terminal session* you open. `mise` is written in Rust and activates instantly (< 10ms).

---

## 🛠️ WSL / Linux (Ubuntu) Migration Steps

Follow these steps in your WSL terminal to completely clean out old managers.

### Step 1: Backup Any Custom Global Packages
Make a mental or physical list of global packages you currently rely on. (e.g., `npm list -g --depth=0`). You will re-install these instantly using `mise` globals later.

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

---

## 🏁 Installing with mise

Now that your environment is clean, you can install everything cleanly with `mise`.

1. Install `mise` and add it to your `~/.bashrc` if you haven't already (see [wsl/mise-install.md](mise-install.md)):
   ```bash
   curl https://mise.run | sh
   echo 'eval "$(/home/dhartjes/.local/bin/mise activate bash)"' >> ~/.bashrc
   source ~/.bashrc
   ```

2. Install your required languages and tools globally:
   ```bash
   # Install Node.js (replacing Volta/NVM)
   mise use --global node@lts
   
   # Install Python (replacing Pyenv)
   mise use --global python@3.13
   
   # Install Neovim (replacing Bob)
   mise use --global neovim@stable
   
   # Install Tree-Sitter CLI
   mise use --global npm:tree-sitter-cli
   ```

3. Confirm that everything is active, fast, and managed cleanly by `mise`:
   ```bash
   node -v
   python --version
   nvim --version
   tree-sitter --version
   ```

---

## 🪟 Windows Migration Steps

If you are migrating your native Windows environment:

### Step 1: Uninstall Old Managers
Uninstall Volta or fnm via Windows **Settings > Apps > Installed Apps** or PowerShell:
```powershell
# If installed via winget
winget uninstall Volta.Volta
winget uninstall Schniz.fnm
winget uninstall OpenJS.NodeJS
```

### Step 2: Clean Filesystem Directories
Remove remaining configuration and storage folders:
```powershell
Remove-Item -Recurse -Force "$HOME\.volta" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$HOME\.fnm" -ErrorAction SilentlyContinue
```

### Step 3: Clean PowerShell profile ($PROFILE)
Open your profile:
```powershell
code $PROFILE
```
Remove any lines containing `volta setup` or `fnm env`.

### Step 4: Setup mise on Windows
Install `mise` via winget and add the activation hook:
```powershell
winget install jdx.mise
"mise activate pwsh | Invoke-Expression" >> $PROFILE
```
Restart your PowerShell terminal and run:
```powershell
mise use --global node@lts
```

---

## 🩺 Running Doctor Check

After you complete the migration, run the Doctor script to verify that no remnants of old version managers are lingering and that all tools are successfully aligned:

```bash
# In WSL
./doctor.sh
```

```powershell
# In Windows PowerShell
.\doctor.ps1
```

<-- [Back to README](../README.md) | [Go to Install mise Guide](mise-install.md)
