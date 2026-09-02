# Migrating to mise (Polyglot Tool Manager)

<-- [Back to README](../README.md) | [WSL Migration Steps](../wsl/migrate-to-mise.md) | [Windows Migration Steps](../windows/migrate-to-mise.md)

`mise` is the unified workstation tool manager used in this environment. It replaces several language/runtime version managers, including **Volta**, **fnm**, **NVM** (**nvm-windows** on Windows), **Pyenv** (WSL only), and **Bob**.

To prevent conflicts and ensure a seamless transition, you **MUST** completely uninstall your existing version managers before activating `mise`.

Pick your platform's step-by-step guide:

- [WSL / Linux (Ubuntu) Migration Steps](../wsl/migrate-to-mise.md)
- [Windows Migration Steps](../windows/migrate-to-mise.md)

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

<-- [Back to README](../README.md) | [WSL Migration Steps](../wsl/migrate-to-mise.md) | [Windows Migration Steps](../windows/migrate-to-mise.md)
