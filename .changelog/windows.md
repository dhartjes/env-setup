# Changelog: windows/

Running history of documentation changes under `windows/`, aggregated into this one file rather than mirrored per-source-file.

## 2026-09-10 — `vscode/vscode-install.md`: added the Ctrl+F5 keybinding convention

Diagnosed why wausausupply's F5 and Ctrl+F5 both attached the debugger: VS Code's built-in Ctrl+F5 ("Run Without Debugging") just re-runs the *same* selected launch config with a `noDebug` flag, which isn't reliable across debugger types (the C# extension's `clr` debug type for .NET Framework attach doesn't cleanly support it), and it never gives a way to run a genuinely different pre-launch step than the F5 path does.

Established a personal, portable convention instead: a global remap in `keybindings.json` (a per-profile file, travels to a new machine automatically via Settings Sync) so Ctrl+F5 always runs a task literally labeled `Run Without Debugging (Fast)` in whatever project is open, rather than relying on the built-in noDebug behavior. F5 still does whatever the project's `launch.json` default configuration does. Documented here since this is a cross-project habit, not specific to one repo — any project wanting Ctrl+F5 to do something just needs a task with that exact label.

## 2026-09-10 — `migrate-to-mise.md` deleted, split into `windows/mise/`

Per this repo's own two-related-files-get-a-subdirectory convention (`.claude/adding-new-docs.md`), `windows/migrate-to-mise.md` was deleted and split:

- `windows/mise/mise-install.md` — just installing mise itself.
- `windows/mise/mise-tools.md` — general tool installs via mise (Node, optional Neovim).
- The old-version-manager removal steps moved to `migrations/migrate-to-mise.md` (see that file's own in-page history) rather than living under `windows/`.

`doctor.ps1`'s reference to the deleted file was fixed to point at `migrations/migrate-to-mise.md`.

## 2026-09-11 — `vscode/vscode-install.md`: WIP-commentary cleanup

As part of a repo-wide pass removing session-narration-style commentary from main docs (see `.changelog/optimizely.md`'s "WIP-commentary cleanup pass" entry for the full pass description), dropped the "Added 2026-09-10 (wausausupply)" lead-in from the Ctrl+F5 keybinding section above — content unchanged, just de-dated.

## 2026-09-11 — Troubleshooting sections split into `<component>-troubleshooting.md`

`rancher-desktop.md` and `peripherals/mouse-setup.md` each had an embedded "## Troubleshooting" section, extracted per the same pass described in `.changelog/optimizely.md`'s matching entry:

- `windows/rancher-desktop.md` → `windows/rancher-desktop/rancher-desktop.md` + `rancher-desktop-troubleshooting.md` (new subfolder — it was a flat file with no existing home for a second related file).
- `windows/peripherals/mouse-setup.md` → gained a `mouse-setup-troubleshooting.md` sibling in place — no new folder needed, `peripherals/` already held `keyboard-setup.md` too.

Root `README.md`, `windows/vscode/vscode-extensions.md`'s Next link, and `windows/ssms-install.md`'s Prev link were all updated for the Rancher Desktop path change.
