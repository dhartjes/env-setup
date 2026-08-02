# Google Antigravity Setup

<-- [Back to README](README.md)

> [!NOTE]
> **Personal PC Only** — Google Antigravity (`agy`) is the default AI coding assistant on your home workstation, replacing Claude Code (which is reserved for work).

Google Antigravity provides an AI-first coding experience directly in your terminal, similar to Claude Code.

---

## 🛠️ Installation & First Launch

The `agy` command-line tool is pre-installed in your Antigravity environment. To verify and perform your initial setup:

1. **Launch the CLI**:
   ```bash
   agy
   ```

2. **Authenticate**:
   On your first launch, follow the secure on-screen prompts to log into your Google developer account and authorize the CLI.

3. **Exit the session**:
   Press `Ctrl+D` twice or type `/exit` (or `/quit`) to close the chat TUI.

---

## ⚙️ Configuration

Your Antigravity CLI preferences are stored in:
`~/.gemini/antigravity-cli/settings.json`

You can edit this file to configure system settings, models, thermal/compute ceilings, and default behaviors.

---

## 🦉 Available Slash Commands

Once inside `agy`, you can use standard slash commands to trigger advanced workflows:

- `/help` - View all available commands.
- `/goal` - Launch a long-running background task with recursive validation.
- `/schedule` - Schedule a recurring background check or timer.
- `/plan` - Build a structured implementation plan prior to making changes.
- `/grill-me` - Begin an interactive session where the agent interviews you on design decisions.
- `/learn` - Save a personalized command or pattern into the agent's long-term memory.

<-- [Back to README](README.md)
