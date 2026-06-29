# GnuPG Backup and Restore

<-- [Back to README](../README.md)

GnuPG keys are required to decrypt your `pass` password store. Back these up before migrating machines.

## Backup

```bash
# Export your public and private keys
gpg --armor --export > ~/gpg-public-keys.asc
gpg --armor --export-secret-keys > ~/gpg-private-keys.asc

# Export the trust database
gpg --export-ownertrust > ~/gpg-ownertrust.txt
```

Store these files in a secure location (e.g., Bitwarden secure notes, encrypted USB drive). Do **not** commit them to a repository.

## Restore

```bash
# Import the keys
gpg --import ~/gpg-private-keys.asc
gpg --import ~/gpg-public-keys.asc

# Restore trust
gpg --import-ownertrust < ~/gpg-ownertrust.txt
```

After restoring, verify the key is available:

```bash
gpg --list-secret-keys
```

<-- Prev: [WSL](wsl.md)
--> Next: [Transfer pass](pass-transfer.md)