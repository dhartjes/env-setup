# Install mise (Windows)

<-- [Back to README](../../README.md) | [Mise Tools](mise-tools.md) | [Migrating from Volta/nvm-windows/fnm/Bob](../../migrations/migrate-to-mise.md#-windows-migration-steps)

`mise` is the unified workstation tool manager used in this environment. On Windows it replaces **Volta**, **nvm-windows**, **fnm**, and **Bob** (Neovim version manager).

> [!IMPORTANT]
> **Migrating from Volta, nvm-windows, fnm, or Bob?** Sourcing older version managers alongside `mise` causes PATH conflicts and command hijacking (see the [Migration Overview](../../migrations/migrate-to-mise.md) for why). Uninstall those first — see [Windows Migration Steps](../../migrations/migrate-to-mise.md#-windows-migration-steps).

## Install mise

None of this requires an elevated/administrator session — it uses `User`-scope PATH and environment variables.

```powershell
winget install jdx.mise
'(&mise activate pwsh) | Out-String | Invoke-Expression' >> $PROFILE
```

Restart your terminal. Verify:

```powershell
mise --version
```

## Install tools

Once mise itself is installed and activated, see [Mise Tools (Windows)](mise-tools.md) to install Node, Neovim, etc.

--> Next: [Mise Tools](mise-tools.md)
