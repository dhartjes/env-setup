# Transfer pass to a New Machine

Since you're keeping the same GPG key, transferring `pass` is straightforward: restore your GPG key on the new machine (see [gnupg.md](gnupg.md)), then copy the password store.

## Prerequisites

- Your GPG key is already imported and trusted on the new machine (see [gnupg.md](gnupg.md))

## Option A — Clone from a remote git repository

If your password store is backed by a git remote:

```bash
git clone <your-remote-url> ~/.password-store
```

## Option B — Copy the store directly

If there is no remote, copy the `~/.password-store` directory from the old machine:

```bash
# On the old machine
rsync -av ~/.password-store/ user@newmachine:~/.password-store/
```

Or archive it and transfer manually:

```bash
# On the old machine
tar -czf pass-store.tar.gz -C ~ .password-store

# On the new machine
tar -xzf pass-store.tar.gz -C ~
```

## Verify

```bash
pass ls
pass show <any-entry>
```

<-- Top: [Back to Readme](../README.md)
