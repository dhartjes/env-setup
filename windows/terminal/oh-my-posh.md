# Oh My Posh Setup

<-- [Back to Windows Terminal](terminal-setup.md) | [Back to WSL Setup](../wsl/wsl-setup.md)

[Oh My Posh](https://ohmyposh.dev/) is a custom prompt engine for any shell. It is used to provide a highly aesthetic, informative, and responsive terminal prompt across both Windows and WSL.

---

## 1. Prerequisites: Font Configuration

Oh My Posh relies on Nerd Fonts to render icons and glyphs correctly. Without a proper Nerd Font configured, your terminal will show broken boxes/question marks.

> [!NOTE]
> Font installation is currently a manual process on Windows as there is no reliable WinGet package for Nerd Fonts.

### Recommended Fonts & Settings

| App / Shell | Font | Additional Appearance Settings |
| :--- | :--- | :--- |
| **VS Code** | `FiraCode Nerd Font` | Ligatures enabled, Ligatures in Terminal enabled |
| **Ubuntu (WSL)** | `UbuntuSansMono Nerd Font Mono` | Size 12 |
| **PowerShell** | `CaskaydiaMono Nerd Font Mono` | |

---

## 2. Windows Installation (PowerShell 7)

To install and set up Oh My Posh locally on Windows:

1. Install Oh My Posh via WinGet:
   ```powershell
   winget install JanDeDobbeleer.OhMyPosh -s winget
   ```
2. Open your PowerShell profile in a text editor (e.g., `notepad $PROFILE` or `code $PROFILE`).
3. Add the initialization command using the local cached themes directory path. This avoids having to fetch the configuration from a remote URL on every shell startup:
   ```powershell
   # Initialize Oh My Posh with a local cached theme
   oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\blue-owl.omp.json" | Invoke-Expression
   ```
4. Reload your profile:
   ```powershell
   . $PROFILE
   ```

---

## 3. WSL / Linux Installation (Ubuntu/Bash)

To install and set up Oh My Posh inside WSL:

1. Install prerequisite tools (curl, unzip) for the installation script:
   ```bash
   sudo apt update && sudo apt install -y curl unzip
   ```
2. Install Oh My Posh for Linux:
   ```bash
   curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
   ```
3. Add Oh My Posh to your path and initialize it inside `~/.bashrc` using the local cached theme directory:
   ```bash
   cat << \EOF >> ~/.bashrc

   # Add oh-my-posh to path
   export PATH="$PATH:$HOME/.local/bin"

   # Invoke oh-my-posh with the local cached theme
   eval "$(oh-my-posh init bash --config ~/.cache/oh-my-posh/themes/blue-owl.omp.json)"
   EOF
   source ~/.bashrc
   ```

   > [!TIP]
   > The local cached themes are automatically downloaded by the installer and placed under `~/.cache/oh-my-posh/themes/`. 
   > You can browse alternative local themes in that directory or view them online at [Oh My Posh Themes](https://ohmyposh.dev/docs/themes).
