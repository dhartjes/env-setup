# Migrating to mise (WSL / Linux)

<-- [Back to README](../README.md) | [Migration Overview](../migrations/migrate-to-mise.md) | [Go to Install mise Guide](mise-install.md)

`mise` is the unified workstation tool manager used in this environment. It replaces **Volta**, **fnm**, **NVM**, **Pyenv**, and **Bob**.

Follow the steps below in your WSL terminal to completely clean out old version managers before installing `mise`. For why this matters and the pitfalls of skipping it, see the [Migration Overview](../migrations/migrate-to-mise.md).

---

## 🛠️ WSL / Linux (Ubuntu) Migration Steps

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

Once done, run the Doctor Check to confirm your environment is clean — see the [Migration Overview](../migrations/migrate-to-mise.md#-running-doctor-check).

<-- [Back to README](../README.md) | [Migration Overview](../migrations/migrate-to-mise.md) | [Go to Install mise Guide](mise-install.md)
