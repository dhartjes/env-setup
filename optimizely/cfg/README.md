# Optimizely Configured Commerce — Local Dev Setup

<-- [Back to README](../../README.md)

Setup guide for running the Configured Commerce (CC) stack locally on a Windows developer machine.

## Prerequisites

These must be in place before starting CC-specific setup:

- Windows 11 with WSL2 enabled
- Git configured with access to the Wausau CC repositories
- Visual Studio (for .NET projects)

## Prerequisites

- [Rancher Desktop](../../windows/rancher-desktop.md) — Docker daemon required by the CC container stack. Covered in the main setup sequence.

## Setup Sequence

1. [.NET Framework 4.8 Setup](cfg-dotnet-framework-setup.md) — Windows-side setup for legacy Framework solutions; also installs .NET 8/10 to get the `dotnet` CLI
2. [Branch Setup for Multiple Repositories](branch-setup-for-multiple-repositories.md) — clone Wausau's CC repos and understand the branch structure
3. [SSMS Setup](ssms-setup.md) — connect to the Rancher Desktop SQL Server and import the CC database
