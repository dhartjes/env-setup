# doctor.ps1 — validates Windows terminal environment alignment with env-setup guide

param(
    [switch]$Work
)

# Set PowerShell output encoding
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "          ✨ Windows Workstation Doctor ✨          " -ForegroundColor Cyan
Write-Host -NoNewline "  Mode: " -ForegroundColor Cyan
if ($Work) {
    Write-Host "Work / Corporate Machine 🏢" -ForegroundColor Yellow
} else {
    Write-Host "Personal / Home Machine 🏠" -ForegroundColor Green
}
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

$ErrorsCount = 0
$WarningsCount = 0
$RetiredCount = 0

# Helper to check a winget/installed package
function Check-Package {
    param(
        [string]$Name,
        [string]$CommandName,
        [string]$InstallCommand
    )
    
    if (Get-Command $CommandName -ErrorAction SilentlyContinue) {
        Write-Host "  [✅ OK] $Name" -ForegroundColor Green
    } else {
        Write-Host "  [❌ MISSING] $Name" -ForegroundColor Red
        Write-Host "             -> Install via: winget install $InstallCommand" -ForegroundColor Yellow
        $script:ErrorsCount++
    }
}

# ── 1. CORE WINDOWS TOOLSTACK ────────────────────────────────────────────────
Write-Host "--- Checking Windows Foundation & Toolstack ---" -ForegroundColor Blue

# Check PowerShell Version (Should be 7+)
if ($PSVersionTable.PSVersion.Major -ge 7) {
    Write-Host "  [✅ OK] PowerShell Version v$($PSVersionTable.PSVersion.Major) (PS 7+)" -ForegroundColor Green
} else {
    Write-Host "  [❌ MISSING] PowerShell 7+" -ForegroundColor Red
    Write-Host "             -> You are running PowerShell v$($PSVersionTable.PSVersion.Major)" -ForegroundColor Yellow
    Write-Host "             -> Install via winget: 'winget install Microsoft.PowerShell'" -ForegroundColor Yellow
    $ErrorsCount++
}

# Check WinGet Package Manager
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "  [✅ OK] WinGet Package Manager" -ForegroundColor Green
} else {
    Write-Host "  [❌ MISSING] WinGet Package Manager" -ForegroundColor Red
    Write-Host "             -> Recommendation: Verify Windows 11 App Installer is updated in MS Store." -ForegroundColor Yellow
    $ErrorsCount++
}

# Check Windows Terminal
if (Get-Command wt -ErrorAction SilentlyContinue) {
    Write-Host "  [✅ OK] Windows Terminal" -ForegroundColor Green
} else {
    Write-Host "  [⚠️ WARN] Windows Terminal (wt.exe) not found on PATH" -ForegroundColor Yellow
    Write-Host "           -> Install via winget: 'winget install Microsoft.WindowsTerminal'" -ForegroundColor Yellow
    $WarningsCount++
}

# Check VS Code
Check-Package "VS Code (Visual Studio Code)" "code" "Microsoft.VisualStudioCode"

# Check WSL2
if (Get-Command wsl -ErrorAction SilentlyContinue) {
    Write-Host "  [✅ OK] WSL2 (Windows Subsystem for Linux)" -ForegroundColor Green
} else {
    Write-Host "  [❌ MISSING] WSL2" -ForegroundColor Red
    Write-Host "             -> Install via administrator PowerShell: 'wsl --install'" -ForegroundColor Yellow
    $ErrorsCount++
}

# Check Windows mise
if (Get-Command mise -ErrorAction SilentlyContinue) {
    Write-Host "  [✅ OK] mise on Windows" -ForegroundColor Green
} else {
    Write-Host "  [❌ MISSING] mise on Windows" -ForegroundColor Red
    Write-Host "             -> Install via winget: 'winget install jdx.mise'" -ForegroundColor Yellow
    $ErrorsCount++

    # Highlight if node is installed but mise is not
    if (Get-Command node -ErrorAction SilentlyContinue) {
        Write-Host "  [⚠️ WARN] Node.js is installed, but Windows mise is NOT!" -ForegroundColor Yellow
        Write-Host "           -> CRITICAL MIGRATION WARNING: If migrating to mise, you MUST first" -ForegroundColor Yellow
        Write-Host "              uninstall Node.js (via Volta, fnm, or Windows Settings/Apps)" -ForegroundColor Yellow
        Write-Host "              before installing Node.js under mise to prevent PATH conflicts." -ForegroundColor Yellow
        Write-Host "              See: [wsl/migrate-to-mise.md](wsl/migrate-to-mise.md) for details." -ForegroundColor Yellow
        $WarningsCount++
    }
}

Write-Host ""

# ── 2. POWERSHELL PROFILE CONFIGURATION CHECK ($PROFILE) ──────────────────────
Write-Host "--- Inspecting PowerShell `$PROFILE Environment Configuration ---" -ForegroundColor Blue

if (Test-Path $PROFILE) {
    $profileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
    if ($profileContent -match "mise activate pwsh" -or $profileContent -match "mise activate powershell") {
        Write-Host "  [✅ OK] mise activation hook found in your PowerShell `$PROFILE" -ForegroundColor Green
    } else {
        Write-Host "  [❌ MISSING] mise activation hook in your PowerShell `$PROFILE" -ForegroundColor Red
        Write-Host "             -> Recommendation: Run: '`"mise activate pwsh | Invoke-Expression`" >> `$PROFILE'" -ForegroundColor Yellow
        $ErrorsCount++
    }
} else {
    Write-Host "  [❌ MISSING] PowerShell profile file does not exist at `$PROFILE" -ForegroundColor Red
    Write-Host "             -> Recommendation: Create the file and add the mise activation hook by running:" -ForegroundColor Yellow
    Write-Host "                New-Item -Type File -Path `$PROFILE -Force; '`"mise activate pwsh | Invoke-Expression`" >> `$PROFILE'" -ForegroundColor Yellow
    $ErrorsCount++
}

Write-Host ""

# ── 3. RETIRED / CONFLICTING WINDOWS MANAGERS ────────────────────────────────
Write-Host "--- Checking for Retired Windows Package Managers ---" -ForegroundColor Blue

$voltaFound = Get-Command volta -ErrorAction SilentlyContinue
if ($voltaFound) {
    Write-Host "  [🗑️ RETIRED] Volta on Windows is installed" -ForegroundColor Red
    Write-Host "               -> Recommendation: Uninstall Volta via Settings or winget" -ForegroundColor Yellow
    $RetiredCount++
}

$fnmFound = Get-Command fnm -ErrorAction SilentlyContinue
if ($fnmFound) {
    Write-Host "  [🗑️ RETIRED] FNM on Windows is installed" -ForegroundColor Red
    Write-Host "               -> Recommendation: Uninstall FNM" -ForegroundColor Yellow
    $RetiredCount++
}

if (-not $voltaFound -and -not $fnmFound) {
    Write-Host "  [✅ OK] Clean Windows toolstack! No retired node managers found." -ForegroundColor Green
}

Write-Host ""

# ── 4. WORK ENVIRONMENT WINDOWS CHECKS ────────────────────────────────────────
if ($Work) {
    Write-Host "--- Checking Work-Specific Windows Features (.NET & Databases) ---" -ForegroundColor Blue
    
    # 4.1 IIS Feature
    try {
        # We try to use Get-WindowsOptionalFeature. Note: this usually requires admin elevation, so we try-catch gracefully.
        $iisFeature = Get-WindowsOptionalFeature -Online -FeatureName "IIS-WebServerRole" -ErrorAction SilentlyContinue
        if ($iisFeature -and $iisFeature.State -eq "Enabled") {
            Write-Host "  [✅ OK] IIS (Internet Information Services) Windows Feature is enabled" -ForegroundColor Green
        } else {
            Write-Host "  [❌ MISSING] IIS (Internet Information Services) Windows Feature" -ForegroundColor Red
            Write-Host "             -> Enable in turn-on Windows Features or run (as Admin):" -ForegroundColor Yellow
            Write-Host "                'Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole'" -ForegroundColor Yellow
            $ErrorsCount++
        }
    } catch {
        Write-Host "  [⚠️ WARN] IIS check skipped (Requires Administrator session to inspect Windows Features)" -ForegroundColor Yellow
        $WarningsCount++
    }

    # 4.2 .NET Framework 4.8
    try {
        $regPath = "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full"
        if (Test-Path $regPath) {
            $releaseVal = (Get-ItemProperty -Path $regPath -Name Release -ErrorAction SilentlyContinue).Release
            if ($releaseVal -and $releaseVal -ge 528040) {
                Write-Host "  [✅ OK] .NET Framework 4.8 is installed" -ForegroundColor Green
            } else {
                Write-Host "  [❌ MISSING] .NET Framework 4.8" -ForegroundColor Red
                Write-Host "             -> Recommendation: install .NET Framework 4.8 Developer Pack" -ForegroundColor Yellow
                $ErrorsCount++
            }
        } else {
            Write-Host "  [❌ MISSING] .NET Framework 4 Registry Path not found" -ForegroundColor Red
            $ErrorsCount++
        }
    } catch {
        Write-Host "  [⚠️ WARN] .NET Framework 4.8 check skipped (Unable to read registry path)" -ForegroundColor Yellow
        $WarningsCount++
    }

    # 4.3 Rancher Desktop / Docker Daemon
    if (Get-Command rancher-desktop -ErrorAction SilentlyContinue) {
        Write-Host "  [✅ OK] Rancher Desktop" -ForegroundColor Green
    } elseif (Get-Command docker -ErrorAction SilentlyContinue) {
        Write-Host "  [✅ OK] Docker Daemon is available" -ForegroundColor Green
    } else {
        Write-Host "  [❌ MISSING] Rancher Desktop / Docker Daemon" -ForegroundColor Red
        Write-Host "             -> Install via winget: 'winget install Rancher.RancherDesktop'" -ForegroundColor Yellow
        $ErrorsCount++
    }

    # 4.4 SSMS (SQL Server Management Studio)
    $ssmsPaths = @(
        "C:\Program Files (x86)\Microsoft SQL Server Management Studio 18",
        "C:\Program Files (x86)\Microsoft SQL Server Management Studio 19",
        "C:\Program Files (x86)\Microsoft SQL Server Management Studio 20"
    )
    $ssmsFound = $false
    foreach ($path in $ssmsPaths) {
        if (Test-Path $path) { $ssmsFound = $true; break }
    }

    if ($ssmsFound) {
        Write-Host "  [✅ OK] SSMS (SQL Server Management Studio)" -ForegroundColor Green
    } else {
        Write-Host "  [❌ MISSING] SSMS (SQL Server Management Studio)" -ForegroundColor Red
        Write-Host "             -> Install via winget: 'winget install Microsoft.SQLServerManagementStudio'" -ForegroundColor Yellow
        $ErrorsCount++
    }

    # 4.5 DBeaver
    if (Get-Command dbeaver -ErrorAction SilentlyContinue -or (Test-Path "C:\Program Files\DBeaver")) {
        Write-Host "  [✅ OK] DBeaver" -ForegroundColor Green
    } else {
        Write-Host "  [❌ MISSING] DBeaver" -ForegroundColor Red
        Write-Host "             -> Install via winget: 'winget install dbeaver.dbeaver'" -ForegroundColor Yellow
        $ErrorsCount++
    }
} else {
    Write-Host "--- Work-Specific Windows Features (.NET & Databases) ---" -ForegroundColor Blue
    Write-Host "  [⏭️  SKIPPED] Running on personal machine (pass -Work to enable IIS/Database checks)" -ForegroundColor Cyan
}

Write-Host ""

# ── SUMMARY ──────────────────────────────────────────────────────────────────
Write-Host "=================== Summary =======================" -ForegroundColor Cyan
Write-Host -NoNewline "  Errors (Missing Core Tools):     " -ForegroundColor Cyan
Write-Host "$ErrorsCount" -ForegroundColor Red
Write-Host -NoNewline "  Warnings (Outdated/Misconfigs):  " -ForegroundColor Cyan
Write-Host "$WarningsCount" -ForegroundColor Yellow
Write-Host -NoNewline "  Retired Tools Found:             " -ForegroundColor Cyan
Write-Host "$RetiredCount" -ForegroundColor Red
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

if ($ErrorsCount -gt 0 -or $RetiredCount -gt 0) {
    Write-Host "💡 Action Required: Please resolve the errors and remove retired tools listed above to align with the env-setup guide." -ForegroundColor Yellow
    exit 1
} elseif ($WarningsCount -gt 0) {
    Write-Host "💡 Action Recommended: Setup is working, but minor adjustments/upgrades are suggested." -ForegroundColor Yellow
    exit 0
} else {
    Write-Host "🎉 Awesome! Your Windows environment is perfectly aligned with the env-setup guide!" -ForegroundColor Green
    exit 0
}
