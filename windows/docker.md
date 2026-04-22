# Switching from Docker Desktop to Rancher Desktop for Configured Commerce Local Dev

A practical migration guide based on the [Optimizely CC .NET 8 local dev docs](https://docs.developers.optimizely.com/configured-commerce/docs/net8-local-development-environment) and [Rancher Desktop docs](https://docs.rancherdesktop.io).

---

## Background

The official CC local dev docs require **Docker Desktop** as a prerequisite. What they actually need is a working `docker` CLI and `docker compose`, plus a socket that VS or VS Code can talk to. Rancher Desktop with the **dockerd (moby)** runtime provides exactly that — and it's free for all org sizes, unlike Docker Desktop.

---

## What the CC Stack Actually Uses

From the official docs, the CC `docker-compose.yml` spins up:

| Container | Purpose |
|---|---|
| `mssql` | SQL Server — maps `.sql/` folder for DB persistence |
| `elasticsearch` (v5) | Search — shared across projects |
| `elasticsearchnext` (v7) | Search — shared across projects |
| `database-updater` | Runs change scripts on first start |
| `classic-proxy` | nginx ingress for Classic site |
| `spire-proxy` | nginx ingress for Spire site |
| `ironpdfengine` | PDF generation |
| `localstack` | S3-compatible local storage (AWS drop-in) |
| `mailhog` | Local SMTP on port 2525, UI on 8025 |

None of these require Docker Desktop specifically — they just need a working Docker daemon.

The `.NET` projects (`Admin.Api`, `Storefront.Api`, `Integration.Api`) run natively via VS or `dotnet run`. Only the infra services run in containers.

---

## Before You Start

> You can have Docker Desktop and Rancher Desktop installed simultaneously, but **they cannot run at the same time**. The Docker socket (`\\.\pipe\docker_engine` on Windows) is a shared resource.

1. **Stop Docker Desktop** — quit from the system tray, don't just minimize it.
2. If you want a clean break: uninstall Docker Desktop. This avoids credential helper conflicts (see below).

---

## Step 1 — Install Rancher Desktop

Download from [rancherdesktop.io](https://rancherdesktop.io) or the [GitHub releases page](https://github.com/rancher-sandbox/rancher-desktop/releases).

**Windows prerequisites:**

- Windows 10/11 with WSL2 already installed (`wsl --install` if not)
- Virtualization enabled in BIOS

During or after installation, you'll hit the first-run setup screen.

---

## Step 2 — Configure the Container Runtime (Critical)

Rancher Desktop defaults to **containerd** with `nerdctl`. CC's compose files and the `docker` CLI assume **dockerd (moby)**. Change this immediately.

**On first launch (setup wizard):**

- Select **dockerd (moby)** as the container runtime
- You can uncheck **Enable Kubernetes** — CC doesn't need Kubernetes locally, and disabling it saves significant RAM

**If already installed:**

- Go to **Preferences → Container Engine**
- Switch from `containerd` to `dockerd (moby)`
- Accept the restart prompt

> **Why this matters:** With containerd selected, your CLI is `nerdctl`, not `docker`. Compose compatibility is reduced and many VS/VS Code integrations that talk directly to the Docker socket will break.

---

## Step 3 — Enable WSL Integration for Your Distro

If you develop from a WSL2 distro (Ubuntu, etc.):

1. Go to **Preferences → WSL**
2. Check the box next to your WSL distro (e.g., Ubuntu)
3. Click **Apply**

This injects the Docker socket (`/var/run/docker.sock`) into your WSL distro and puts the `docker` CLI on `PATH`. After this, `docker ps` should work from inside WSL.

> You may need to restart WSL (`wsl --shutdown` then reopen your terminal) for the socket to appear.

---

## Step 4 — Fix the Credential Store (Most Common Migration Pain Point)

This is the most likely thing to break when coming from Docker Desktop.

Docker Desktop installed a credential helper called `docker-credential-desktop.exe`. After uninstalling Docker Desktop (or switching), your `~/.docker/config.json` may still reference it:

```json
{
  "credsStore": "desktop"
}
```

When Rancher Desktop tries to pull images, this fails with something like:

```
error getting credentials - err: docker-credential-desktop.exe resolves to executable in current directory
```

**Fix (Windows-side):** Edit `%USERPROFILE%\.docker\config.json` and remove the `credsStore` line, or replace it with `"credsStore": "wincred"`.

**Fix (WSL-side):** Edit `~/.docker/config.json` in your WSL distro and remove the `credsStore` line entirely:

```json
{}
```

If you use a private container registry (e.g., Optimizely's registry for CC base images), re-authenticate with `docker login` after clearing the credential store.

For the credential store to work long-term in WSL, install `pass` and `libsecret`:

```bash
sudo apt install pass libsecret-1-0
```

---

## Step 5 — Verify Docker is Working

From a Windows terminal or PowerShell:

```powershell
docker version
docker compose version
docker run --rm hello-world
```

From inside WSL (if you develop there):

```bash
docker version
docker ps
```

Both should work if WSL integration is enabled.

---

## Step 6 — Run the CC Stack

Nothing changes here. Use the same commands from the CC docs:

```bash
# From the root of your CC repo
docker compose up -d

# Or with profiles (newer CC versions)
docker compose --profile apps up -d
```

The `docker-compose.yml` and `.env` are unchanged. All port mappings, volume mounts, and environment variables work identically.

**CC-specific reminder from the docs:** On first run, `database-updater` will fail because MSSQL doesn't have the `Insite.Commerce` database yet. Restore your DB to the running MSSQL container, then rerun `docker compose up -d`.

---

## Step 7 — Visual Studio / VS Code Integration

With dockerd (moby) selected, Rancher Desktop exposes the same named pipe as Docker Desktop:

```
\\.\pipe\docker_engine
```

This means:

- **VS Docker Compose project support** (`.dcproj`) — works as before
- **VS Code Docker extension** — works as before
- **VS Code Dev Containers** — works, but see the note below

> **VS Code Dev Containers gotcha:** Uncheck **Dev > Containers: Mount Wayland Socket** in VS Code settings. There's a known issue where Rancher Desktop's WSL socket path contains characters that Docker rejects as a volume name.

---

## Step 8 — Optional: Disable Kubernetes to Save RAM

The CC local stack doesn't need Kubernetes. Disabling it frees up the memory K3s would otherwise reserve.

- Go to **Preferences → Kubernetes**
- Uncheck **Enable Kubernetes**
- Apply and let it restart

---

## Resource Management

Rancher Desktop respects WSL2's `.wslconfig`. If the CC stack is eating too much memory, cap it.

In `%USERPROFILE%\.wslconfig`:

```ini
[wsl2]
memory=8GB
processors=4
swap=2GB
```

Restart WSL after changing this: `wsl --shutdown`

---

## Running Multiple CC Projects Simultaneously

Same as with Docker Desktop — this is a CC config concern, not a Rancher Desktop one. Per the CC docs, change these `.env` values per project to avoid port conflicts:

```env
CLASSIC_PORT=30100        # change to 30101, 30102, etc.
SPIRE_PORT=30000          # change to 30001, 30002, etc.
```

MSSQL, Elasticsearch, and Mailhog can be shared — run a single instance of each and point multiple projects at it. Use `-p` or `DockerComposeProjectName` to namespace compose projects so container names don't collide.

---

## Troubleshooting

**`docker-compose` command not found**
Rancher Desktop ships Docker Compose v2 as a plugin (`docker compose`), not the standalone `docker-compose` binary. If scripts use the hyphenated form, either install the standalone binary or add a shim:

```bash
# In WSL
echo 'alias docker-compose="docker compose"' >> ~/.bashrc
source ~/.bashrc
```

**Containers start but can't reach host services**
Use `host.docker.internal` — Rancher Desktop supports this on Windows without the `--add-host` flag.

**`host-gateway` special value not working**
The `host-gateway` value is Docker Desktop-specific and not supported in Rancher Desktop. Use `host.docker.internal` or `host.rancher-desktop.internal` instead.

**Volume data missing after switch**
Volumes from Docker Desktop's moby instance are stored in a different WSL distro (`docker-desktop-data`). Rancher Desktop uses `rancher-desktop-data`. Your old Docker Desktop volumes aren't automatically available. For MSSQL this is fine since CC uses a bind mount to `.sql/` anyway — the DB persists in your repo, not in a named volume.

**Logs location:** `%LOCALAPPDATA%\rancher-desktop\logs\`

**Factory reset (last resort):** In Rancher Desktop: Troubleshooting → Factory Reset. This clears all containers, images, and config — useful if the environment gets into a bad state.

---

## Summary of Changes Required

| Area | Change Needed |
|---|---|
| Container runtime | Switch to dockerd (moby) — not the default |
| Kubernetes | Disable (optional but recommended) |
| WSL integration | Enable for your distro |
| Credential store | Remove `credsStore: desktop` from `~/.docker/config.json` |
| Registry auth | Re-run `docker login` for private registries |
| VS Code Wayland socket | Uncheck mount setting |
| CC compose / `.env` | No changes required |
| `.NET` projects | No changes required |
| `docker compose` commands | No changes required |
