# Optimizely Configured Commerce — Local Dev Setup

<-- [Back to README](../../README.md)

Setup guide for running the Configured Commerce (CC) stack locally on a Windows developer machine.

## Prerequisites

These must be in place before starting CC-specific setup:

- Windows 11 with WSL2 enabled
- Git configured with access to the Wausau CC repositories
- Visual Studio (for .NET projects)

## Setup Sequence

1. [Rancher Desktop](rancher-desktop.md) — Docker daemon required by the CC container stack; use Rancher Desktop instead of Docker Desktop (free license)
2. [.NET Framework 4.8 Setup](cfg-dotnet-framework-setup.md) — Windows-side setup for legacy Framework solutions
3. [Branch Setup for Multiple Repositories](branch-setup-for-multiple-repositories.md) — Wausau's two CC repos and their branch structure
