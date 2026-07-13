# Optimizely Configured Commerce — .NET 8+ Local Dev Setup

<-- [Back to CFG Setup](../README.md)

> **Stub** — This path is not yet written. It mirrors the existing-site setup sequence but uses the .NET 8+ Docker/nginx stack instead of IIS. When this is written, it will supersede the IIS-based path for any repo on version 5.2.2604.725-lts or newer.

## How this differs from the .NET 4.8 path

| Concern | .NET 4.8 path | .NET 8+ path |
|---|---|---|
| Web server | IIS (Windows) | nginx reverse proxy (Docker) |
| Site entry point | `http://localhost:8080` | `http://localhost:30000` |
| Admin Console | `http://localhost:8080/admin` | `http://localhost:30000/admin` |
| Spire port | `3000` (standalone) | `30020` (proxied via 30000) |
| Database | SQL Server via Rancher Desktop or local install | SQL Server container (`docker compose up -d`) |
| APIs | Single IIS site | Three separate API projects (Admin: 30070, Storefront: 30040, Integration: 30080) |
| Docker required | No | Yes — Docker Desktop in Linux containers mode |

## Planned setup sequence

When written, this section will cover:

1. **.NET SDK Setup** — install .NET 10 SDK (5.2.2605+) or .NET 8 SDK (5.2.2512–5.2.2604); `dotnet` CLI required
2. **Docker Desktop Setup** — install Docker Desktop, switch to Linux containers mode, log in to `optimizelyb2bpublic.azurecr.io`
3. **Clone and Branch Setup** — same as the .NET 4.8 path
4. **Environment configuration** — configure the repo-root `.env` file (`IMAGE_TAG`, `DB_CONNECTION_STRING`, `MAIN_HOST`)
5. **Seed the database** — `docker compose up -d`, run `StartingDatabase.sql` (new project) or import `.bacpac` (existing customer)
6. **Start backend APIs** — Mode A (host, `dotnet run`) for active development or Mode B (Docker, `docker compose --profile apps up`) for stability
7. **Admin Console** — NuGet config, build extensions, confirm login at `http://localhost:30000/admin`
8. **Spire Setup** — same Volta/npm approach; use `http://localhost:30000` not `http://localhost:3000`

## Reference

- [Optimizely: .NET 8.0+ Local Development Environment](https://docs.developers.optimizely.com/configured-commerce/docs/net8-local-development-environment)
