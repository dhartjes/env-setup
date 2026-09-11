# Admin Console

<-- [Back to CFG README](../README.md)

No `npm install`, `grunt`, or TypeScript compile step is needed to make the Admin Console work. The one thing that actually matters for the Admin Console rendering correctly is the `.css` MIME-type fix — see [Troubleshooting](admin-console-troubleshooting.md).

By this point you've already restored, built, and edited the local config (see [Initial Build](../initial-build.md) and [Local Edits](../local-edits.md)) — this page just verifies it actually works.

## Log in to the Admin Console

With IIS running and the database populated, navigate to:

```
http://<clientname>.local.com:8080/admin
```

| Field | Value |
|---|---|
| Username | `admin` |
| Password | `admin123` |

> When working with an existing customer's `.bacpac` database rather than a fresh `StartingDatabase.sql` import, the admin credentials will be whatever the customer's database contains — `admin` / `admin123` may not work.

## Access Spire CMS content admin

The Spire content admin is at a separate path from the back-office admin console:

```
http://<clientname>.local.com:8080/contentadmin
```

## Troubleshooting

See [Troubleshooting: Admin Console](admin-console-troubleshooting.md).

<-- Prev: [Local Edits](../local-edits.md)
--> Next: [Mise Tools](../mise/mise-tools.md)
