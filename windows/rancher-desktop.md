# Rancher Desktop

<-- [Back to README](../README.md)

Rancher Desktop provides a free Docker daemon for Windows. The official Optimizely CC local dev docs list Docker Desktop as a prerequisite — what they actually need is a working `docker` CLI, `docker compose`, and a socket that Visual Studio and VS Code can talk to. Rancher Desktop with the **dockerd (moby)** runtime provides exactly that.

## Install

```pwsh
winget install SUSE.rancherdesktop
```

Prerequisites: WSL2 installed, virtualization enabled in BIOS.

## Configure the Container Runtime

Rancher Desktop defaults to **containerd** with `nerdctl`. Switch to **dockerd (moby)** — CC's compose files and the `docker` CLI assume it, and VS/VS Code integrations talk directly to the Docker socket.

**On first launch (setup wizard):**
- Select **dockerd (moby)** as the container runtime
- Uncheck **Enable Kubernetes** — CC doesn't need it locally, and disabling it saves significant RAM

**If already installed:**
- Go to **Preferences → Container Engine** and switch from `containerd` to `dockerd (moby)`
- Go to **Preferences → Kubernetes** and uncheck **Enable Kubernetes**
- Accept the restart prompt

## Enable WSL Integration

1. Go to **Preferences → WSL**
2. Check the box next to your WSL distro (e.g., Ubuntu)
3. Click **Apply**

This injects the Docker socket (`/var/run/docker.sock`) into WSL and puts the `docker` CLI on `PATH`. You may need to restart WSL (`wsl --shutdown`) for the socket to appear.

## Verify

From PowerShell:

```powershell
docker version
docker compose version
docker run --rm hello-world
```

From inside WSL:

```bash
docker version
docker ps
```

## Resource Management

See [WSL Config](wsl/wsl-config.md) for `.wslconfig` memory and CPU limits — Rancher Desktop respects these settings.

---

## Troubleshooting

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

---

<-- Prev: [VS Code Extensions](vscode/vscode-extensions.md)
--> Next: [SSMS](ssms-install.md)
