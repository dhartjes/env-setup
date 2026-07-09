# WSL2 Configuration

<-- [Back to README](../../README.md)

## WSLConfig File Location

In Windows Subsystem for Linux (WSL), there are two main configuration files:

- .wslconfig for global WSL2 settings
- wsl.conf for per-distribution settings

The .wslconfig file is not stored inside /mnt/c within your Linux environment.
Instead, it resides in your Windows user profile directory and applies settings globally to all WSL 2 distributions.

### Finding .wslconfig

The file path in Windows is: C:\Users\<your-username>\.wslconfig. Check if it exists in PowerShell with:

```pwsh
Test-Path $USERPROFILE\.wslconfig
true
```

From inside WSL, you can access it via:

```bash
cd /mnt/c/Users/<YourUserName>
ls -a | grep .wslconfig
```

If it doesn't exist, you can create it manually in that location.

### Finding wsl.conf

This file is inside each Linux distribution and controls per-distro settings.

```bash
cd etc
ls -a | grep wsl.conf
```

## Example .wslconfig

[wsl2]
memory=4GB
processors=2
swap=8GB
localhostForwarding=true

[experimental]
sparseVhd=true

This limits VM memory, sets CPU count, swap size, and enables sparse VHDs.

## Applying Changes

After editing either file:

```pwsh
wsl --shutdown
```

This ensures the WSL VM restarts and applies your changes (the “8-second rule” applies).

## Tip

- Use .wslconfig for global VM resource/network settings.
- Use wsl.conf for mounts, networking, interop, and default user per distro.

## Settings on sizable dev machine

### On a 64GB RAM Windows system

Give WSL2 a generous but not excessive memory allocation while leaving enough for Windows to avoid performance issues.

[wsl2]
memory=24GB
processors=8
swap=auto
vmIdleTimeout=600
networkingMode=mirrored

### Explanation of settings

- memory=24GB
  - On 64GB systems, allocate ~24GB to WSL2 for large projects, AI/ML, or heavy Docker workloads
  - Reserve ~40GB for Windows
  - This is more than the default 50% (32GB) but still leaves room for multitasking
- processors=8
  - Use 4-8 virtual CPU cores for most use cases
  - Use 12-16 virtual CPU cores for maximum Linux performance
  - Reserve at least 4 cores for Windows to avoid lag when switching between WSL and Windows.
- swap=auto
  - Small fixed swap space to handle occasional memory spikes
  - avoid disabling if you run memory‑intensive workloads.
  - auto is the default. 25% of RAM up to a max of 4 GB
- vmIdleTimeout=600
  - Reclaim unused memory after 10 minutes of inactivity to free it for Windows.
  - -1 = never reclaim (default, best Linux performance)
- networkingMode=mirrored
  - Recommended on Windows 11 for automatic localhost connectivity and full IPv6 support

### How to apply

Save the file in your user folder (ensure it’s .wslconfig).

Run `wsl --shutdown` in PowerShell or Command Prompt.

Restart WSL2 (e.g., wsl or your distro name).

Verify with from bash inside WSL to confirm the memory limit. `free -h`

### Tips

- If you run only light development work, you could reduce memory to 16–20GB to leave more for Windows.
- For Docker or VMs inside WSL2, consider increasing memory further (up to 32–40GB) if needed.
- Always reserve at least 2–4 cores for Windows to maintain responsiveness
- This setup balances performance for heavy workloads with stability for multitasking on a high‑RAM system.

## Source

- [Master .wslconfig: Fine-Tune Memory, CPU, and Disk for WSL2](https://www.besthub.dev/articles/master-wslconfig-fine-tune-memory-cpu-and-disk-for-wsl2-d26415ab5c13)
- [How to configure memory limits in WSL2 - Willem's Fizzy Logic](https://fizzylogic.nl/2023/01/05/how-to-configure-memory-limits-in-wsl2)


<-- Prev: [WSL Setup](wsl-setup.md)
--> Next: [Git Install](../../wsl/git/git-install.md)