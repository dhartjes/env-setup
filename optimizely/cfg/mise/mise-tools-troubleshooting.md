# Troubleshooting Mise Tools (Configured Commerce)

<-- [Back to Mise Tools](mise-tools.md)

### Option B — Direct install (no version manager)

If mise is blocked by policy, install Node 22 directly:

```powershell
winget install OpenJS.NodeJS.LTS
```

Verify:

```powershell
node --version
npm --version
```
