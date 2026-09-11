# Troubleshooting Rancher Desktop

<-- [Back to Rancher Desktop](rancher-desktop.md)

**Cannot connect to the Docker daemon**
Exit and restart Rancher Desktop from the Windows system tray.

**`docker-compose` command not found**
Rancher Desktop ships Compose v2 as a plugin (`docker compose`). Add a shim if needed:

```bash
echo 'alias docker-compose="docker compose"' >> ~/.bashrc
source ~/.bashrc
```

**Credential store errors after switching from Docker Desktop**
Docker Desktop leaves a `"credsStore": "desktop"` entry in `~/.docker/config.json` (both Windows and WSL). Remove or replace it:

- Windows: Edit `%USERPROFILE%\.docker\config.json` — remove `credsStore` or set it to `"wincred"`
- WSL: Edit `~/.docker/config.json` — remove `credsStore` entirely

Re-authenticate with `docker login` for any private registries afterward.

**Containers can't reach host services**
Use `host.docker.internal` — supported on Windows without `--add-host`. Note: `host-gateway` is Docker Desktop-specific and not supported here.

**Volume data missing after switching from Docker Desktop**
Docker Desktop volumes live in the `docker-desktop-data` WSL distro; Rancher Desktop uses `rancher-desktop-data`. For MSSQL this is fine — CC uses a bind mount to `.sql/` so the DB persists in your repo.

**Logs:** `%LOCALAPPDATA%\rancher-desktop\logs\`

**Factory reset:** Rancher Desktop → Troubleshooting → Factory Reset.

**VS Code Dev Containers**
Uncheck **Dev > Containers: Mount Wayland Socket** in VS Code settings — Rancher Desktop's WSL socket path contains characters Docker rejects as a volume name.
