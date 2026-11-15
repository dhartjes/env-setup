# AGENTS.md

Instructions for AI coding agents (Antigravity, Gemini CLI, Cursor, Copilot, etc.) working in this repository.

See [CLAUDE.md](CLAUDE.md) and [.claude/adding-new-docs.md](.claude/adding-new-docs.md) for repository architecture, setup sequences, and doc placement rules.

## Markdown & Formatting Standards

All documentation must adhere to CommonMark / GFM best practices and align with Prettier (`mise run format`):

1. **4-Space List Indentation**: Indent all sub-lists (bullets, numbers) and nested elements (code blocks, blockquotes) by exactly **4 spaces** per nesting level. Never use 2 or 3 spaces.
2. **Language Tags on Fenced Code Blocks**: Always specify a language identifier (e.g. `bash`, `pwsh`, `powershell`, `lua`, `json`, `yaml`, `text`). Never leave code fences bare (` ``` `).
3. **Code Blocks Inside Lists**: Insert a blank line before the code block and indent both the code fences and their contents by 4 spaces.
4. **No Non-Breaking Spaces or Word Glyphs**: Always use standard ASCII spaces. Never insert non-breaking spaces (`\u00a0`), and never use raw Word/OneNote bullet glyphs (`•`, `○`, `§`, `□`).
5. **Keyboard Shortcuts with Backticks**: Never leave a literal backtick unescaped when writing shortcuts like `Ctrl+` ` or `Alt+` `. Use double backticks (`` `Ctrl+` ``), HTML keyboard tags (`<kbd>Ctrl</kbd>+<kbd>`</kbd>`), or an escaped backtick (`Ctrl+\``).
6. **Callouts**: Use standard GitHub alert callouts (`> [!NOTE]`, `> [!TIP]`, `> [!IMPORTANT]`, `> [!WARNING]`) or italicized `_Note:_` instead of raw unstyled `Note` text.
7. **Navigation Footers**: Footer navigation links (`<-- Prev: ...` / `--> Next: ...`) must always be unindented at root column 0, never indented inside list items.
8. **Formatting Verification**: Always format new or modified Markdown files with:
   ```bash
   mise run format -- <directory>
   ```
