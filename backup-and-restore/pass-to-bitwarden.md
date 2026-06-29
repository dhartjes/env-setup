# Export pass to Bitwarden

`pass` has no built-in export command. This guide uses a shell script to decrypt every entry and write a CSV that Bitwarden can import.

## Prerequisites

- Your GnuPG key must be present and trusted (see [gnupg.md](gnupg.md))
- `pass` must be initialized and your password store must be accessible
- You must be logged in to [bitwarden.com](https://bitwarden.com) or the desktop app

## Step 1 — Export pass entries to CSV

Run this script from your terminal. It iterates through every `.gpg` file in your password store and writes a Bitwarden-compatible CSV.

```bash
#!/usr/bin/env bash
# Exports pass entries to a Bitwarden-importable CSV.
# Assumes entries follow the common convention:
#   Line 1: password
#   Remaining lines: key: value pairs (username, url, etc.)

OUTPUT="$HOME/bitwarden-import.csv"

echo "folder,favorite,type,name,notes,fields,reprompt,login_uri,login_username,login_password,login_totp" > "$OUTPUT"

cd ~/.password-store

find . -name "*.gpg" | sort | while read -r file; do
  entry="${file#./}"
  entry="${entry%.gpg}"

  content=$(pass show "$entry" 2>/dev/null) || continue

  password=$(echo "$content" | head -1)
  username=$(echo "$content" | grep -i "^username:" | head -1 | sed 's/^[Uu]sername: *//')
  url=$(echo "$content" | grep -i "^url:" | head -1 | sed 's/^[Uu]rl: *//')

  # Escape double quotes in fields
  name=$(echo "$entry" | sed 's/"/""/g')
  password=$(echo "$password" | sed 's/"/""/g')
  username=$(echo "$username" | sed 's/"/""/g')
  url=$(echo "$url" | sed 's/"/""/g')

  echo ",,login,\"$name\",,,0,\"$url\",\"$username\",\"$password\","
done >> "$OUTPUT"

echo "Exported to $OUTPUT"
```

Save the script (e.g., `~/export-pass.sh`), make it executable, and run it:

```bash
chmod +x ~/export-pass.sh
~/export-pass.sh
```

## Step 2 — Review the CSV

Open `~/bitwarden-import.csv` and spot-check a few entries. The script handles the most common `pass` entry format (password on line 1, `username:` and `url:` fields below). If your entries use different field names, adjust the `grep` patterns in the script.

Delete the CSV file after importing — it contains all your passwords in plaintext.

## Step 3 — Import into Bitwarden

1. Log in to your Bitwarden vault at [bitwarden.com](https://bitwarden.com) or via the desktop app
2. Go to **Tools → Import Data**
3. Select **Bitwarden (csv)** as the format
4. Upload `~/bitwarden-import.csv`
5. Click **Import Data** and confirm

## Step 4 — Verify and clean up

Check a handful of entries in Bitwarden to confirm passwords, usernames, and URLs imported correctly. Then delete the plaintext CSV:

```bash
rm ~/bitwarden-import.csv
```

<-- Top: [Back to Readme](../README.md)
