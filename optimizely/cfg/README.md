# Optimizely Configured Commerce — Local Dev Setup

<-- [Back to README](../../README.md)

Setup guide for running the Configured Commerce (CC) stack locally on a Windows developer machine.

## Prerequisites

These must be in place before starting CC-specific setup:

- Windows 11
- Git configured with access to the Wausau CC repositories
- Visual Studio Code

## Setup Paths

### Existing customer site (most common)

Use this path when cloning and running a customer's existing CC repo for the first time.

1. [.NET Framework 4.8 Setup](dotnet-framework-setup.md) — installs Framework 4.8 and the `dotnet` CLI
2. [Clone and Branch Setup](branch-setup-for-multiple-repositories.md) — clone the customer repo and understand the sandbox/production/ADE branch structure
3. [IIS Setup](iis-setup.md) — enable IIS on Windows 11 and configure the site binding and identity certificate
4. [SSMS Setup](database/ssms-setup.md) — connect to SQL Server and import a `.bacpac` from Mission Control
5. [Admin Console](admin-console.md) — restore NuGet packages, build the solution, and confirm the admin login
6. [Spire Setup](spire-setup.md) — install Node via Volta, run `npm install`, configure the API URL, and start the frontend

### New project from scratch

Use this path only when Optimizely has provisioned a new environment and you are starting from the base `insite-commerce-cloud` repo. Steps 1–5 above are the same; the difference is in step 4 (use `StartingDatabase.sql` instead of a `.bacpac`).

See [Optimizely: Environment Setup for Developers](https://docs.developers.optimizely.com/configured-commerce/docs/b2b-commerce-cloud-environment-setup-for-developers) for the new-project walkthrough.

### .NET 8+ setup (future)

The .NET 8+ stack replaces IIS with a Docker/nginx proxy and changes how APIs and Spire are run. See [.NET 8 Setup](net8/README.md) for a stub of that path.
