# Configured Commerce Mise Tools

<-- [Back to CFG README](../README.md)

Assumes `mise` itself is already installed — see [Install mise (Windows)](../../../windows/mise/mise-install.md) if not. This page covers only what's specific to Configured Commerce; general-purpose tools (Python, Neovim, GitHub CLI, etc.) are documented generically in [Mise Tools (Windows)](../../../windows/mise/mise-tools.md), not here.

> [!IMPORTANT]
> **wausausupply's `mise.toml` (repo root) is a custom addition, not an out-of-the-box Configured Commerce file.** Optimizely's own template ships no `mise.toml` at all. See [Local Edits](../local-edits.md) for the full reference — what it contains, why, and how to rebuild it if it's ever lost or damaged.

## Node.js

Node is required for building and running **Spire** (the React storefront) — it is **not** needed for the Admin Console; see [Admin Console](../admin-console/admin-console.md).

`mise.toml` pins `node = "22.12.0"` under `[tools]` at the repo root. mise installs and activates that exact version automatically the first time you `cd` into the repo (or open it in VS Code / a terminal that runs mise's shell hook) — no manual `mise use --global node@...` needed for this project.

## `mise.toml` tasks reference

See [Local Edits](../local-edits.md) for the full task table (what each one does, which `tools/*.ps1` script it calls) and the rationale behind the apply-run-revert-on-exit pattern used by `fix-relay-fetch-start` and `start-iis-express-fast`.

## Troubleshooting

See [Troubleshooting: Mise Tools](mise-tools-troubleshooting.md).

<-- Prev: [Admin Console](../admin-console/admin-console.md)
--> Next: [Spire Setup](../spire/spire-setup.md)
