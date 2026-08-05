# Guide for Adding New Setup Documentation

This file tells a future Claude agent exactly how to add a new tool or section to this repo. Read it before touching any files.

---

## Environment constraints

- **No admin access on Windows.** Never suggest `Machine`-scope environment variable changes, `Enable-WindowsOptionalFeature`, or anything else requiring an elevated shell. Always use `User` scope for `SetEnvironmentVariable` calls. When a step genuinely requires admin, call it out explicitly so the user knows to ask IT.
- WinGet installs apps to `$env:LOCALAPPDATA\Programs\<AppName>` by default (not `C:\Program Files`). Confirm the actual install path before writing PATH instructions.

---

## File placement rules

- Single-file topics go directly in the parent directory (e.g. `wsl/meld-install.md`).
- Create a subdirectory **only** when a topic needs two or more related files (e.g. `wsl/meld/meld-install.md` + `wsl/meld/meld-config.md`).
- Windows-side files go under `windows/<tool>/`, WSL/Linux-side files go under `wsl/<tool>/`.

---

## Document template

Every setup doc follows this structure. Copy it and fill in the blanks.

```markdown
# <Tool Name> <Action> (<Platform>)

<-- [Back to README](../../README.md)

One sentence: what this tool is and why you're installing/configuring it here.

## <Section heading>

(Steps, commands, config snippets…)

## Source   ← omit if no meaningful external reference

- [Link text](url)

<-- Prev: [<Previous page title>](<relative-path-to-prev.md>)
--> Next: [<Next page title>](<relative-path-to-next.md>)
```

### Rules for the template

- **Titles**: `# Tool Action (Platform)` — e.g. `# Meld Installation (WSL/Ubuntu)` or `# Meld Configuration (Windows)`.
- **Back to README**: always the second line, always `<-- [Back to README](../../README.md)` (adjust `../../` depth to match actual nesting).
- **Relative links**: never use a `./` prefix — `file.md` not `./file.md`, `../dir/file.md` not `./../dir/file.md`.
- **Prev/Next**: only at the very bottom, after all content. If a file is the last in its section, its Next points to the first file of the next section.
- **apt commands**: always `sudo apt update && sudo apt upgrade -y` before any `sudo apt install`.
- **No admin on Windows**: use `User` scope for environment variables (see above).
- **Comments**: write none unless the reason is non-obvious. No multi-line comment blocks.
- **Placeholders**: avoid `<your-value>` wherever possible; use the real values from the user's known config.

---

## Connecting a new doc into the navigation chain

When you add a file to the main setup sequence:

1. **Update the README** (`README.md`) — add the new entry in the correct position inside the numbered list under `## Setup sequence`.
2. **Update the Prev file's Next link** — the file that previously pointed to what comes after your new file now points to your new file instead.
3. **Update the Next file's Prev link** — the file that comes after your new file now points back to your new file.
4. **Chain multi-file sections internally** — each file in a section points to the next file in that section.

Example chain for a two-file WSL+Windows tool section inserted before Neovim:

```
python-vscode.md  -->  wsl/meld/meld-install.md  -->  wsl/meld/meld-config.md
  -->  windows/meld/meld-install.md  -->  windows/meld/meld-config.md  -->  nvim/nvim-install.md
```

---

## Doctor script synchronization (REQUIRED)

Whenever you add, retire, or change a tool, you **must** update both `doctor.sh` (Bash/WSL) and `doctor.ps1` (PowerShell/Windows) to stay in sync.

### doctor.sh patterns

**Add a core WSL tool** — append a `check_required_tool` call in the core tools block (around line 116):

```bash
check_required_tool "Meld" "meld" "sudo apt update && sudo apt install meld"
```

**Add a work-only WSL tool** — place inside the `if [ "$WORK_MODE" = true ]` block.

**Retire a WSL tool** — append a `check_retired_tool` call in the retired tools block (around line 229):

```bash
check_retired_tool "OldTool" "oldtool" "Remove OldTool: run 'apt remove oldtool'"
```

### doctor.ps1 patterns

**Add a Windows GUI/winget tool** — use `Check-Package`:

```powershell
Check-Package "Meld" "meld" "Meld.Meld"
```

**Add a work-only Windows tool** — place inside the `if ($Work)` block.

**Retire a Windows tool** — add a `Get-Command` check in the retired managers block (around line 127) following the existing pattern.

### Which script to update

| Change | doctor.sh | doctor.ps1 |
|---|---|---|
| New WSL-only tool | ✅ | — |
| New Windows-only tool | — | ✅ |
| New tool installed on both | ✅ | ✅ |
| Tool retired on WSL | ✅ | — |
| Tool retired on Windows | — | ✅ |
| Tool retired on both | ✅ | ✅ |

---

## Checklist before finishing

- [ ] New doc file(s) created with correct title, back link, prev/next links
- [ ] README updated with new entry in the right position
- [ ] Prev file's Next link updated
- [ ] Next file's Prev link updated
- [ ] `doctor.sh` updated (if WSL tool added/retired)
- [ ] `doctor.ps1` updated (if Windows tool added/retired)
- [ ] No `./` prefixes in relative links
- [ ] No admin-required commands on Windows (user scope only)
