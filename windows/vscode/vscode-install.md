# VSCode Setup

<-- [Back to README](../../README.md)

## Overview

There are some gotchas in the VSCode setup when you intend to work within WSL2. I saw conflicting advice on how to resolve the issue, but the best answer seems to be to ensure that VSCode is manually added to your Path variable in the ~/.bashrc file.

## Configuration

I've saved my settings in my GitHub account. Sign in to Visual Studio Code from the settings page using Github to retrieve your settings.

## Extensions

See [VSCode Extensions](vscode-extensions.md) for more info

## Keybinding convention: Ctrl+F5 runs a task, not the debugger

Added 2026-09-10 (wausausupply). `keybindings.json` is a global, per-profile file, so this applies across every project once set — and travels to a new machine automatically via Settings Sync (see Configuration above), unlike anything in a repo's own `.vscode/`.

Ctrl+F5's built-in "Run Without Debugging" behavior re-runs whatever launch config is selected with a `noDebug` flag, which isn't reliable across debugger types (e.g. the C# extension's `clr` debug type for .NET Framework attach doesn't cleanly support it) and never gives you a way to run a *different* pre-launch step (e.g. flipping a debug-symbols flag off) than the F5 path does.

Global remap in `keybindings.json`, so Ctrl+F5 instead runs a task by a fixed name:

```jsonc
{
    "key": "ctrl+f5",
    "command": "-workbench.action.debug.run"
},
{
    "key": "ctrl+f5",
    "command": "workbench.action.tasks.runTask",
    "args": "Run Without Debugging (Fast)"
}
```

**Convention:** every project that wants Ctrl+F5 to work should define a task literally labeled `Run Without Debugging (Fast)` in its own `.vscode/tasks.json`. F5 still does whatever the project's `launch.json` default configuration does (attach the appropriate debugger); Ctrl+F5 always runs that fixed-name task instead, whatever it happens to do in that project (e.g. wausausupply's runs IIS Express directly with `<compilation debug>` flipped off, skipping the debugger and the build's debug overhead entirely — see [IIS Setup](../../optimizely/cfg/iis-setup.md)). If a project has no task with that name, Ctrl+F5 just shows a "task not found" notice — harmless.

## Source

- [StackOverflow](https://stackoverflow.com/questions/71103966/wsl-vscode-command-returning-error-not-found/73439567#73439567)

<-- Prev: [Claude Code](../../wsl/claude-install.md)
--> Next: [VS Code Extensions](vscode-extensions.md)
