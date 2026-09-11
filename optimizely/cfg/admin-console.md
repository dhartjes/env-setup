# Admin Console

<-- [Back to CFG README](README.md)

No `npm install`, `grunt`, or TypeScript compile step is needed to make the Admin Console work. The one thing that actually matters for the Admin Console rendering correctly is the `.css` MIME-type fix under Troubleshooting → "Gigantic Opti logo" below.

## Configure the NuGet source

The Optimizely NuGet feed requires no authentication. Add it to a `nuget.config` file at the repo root (create the file if it does not exist):

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <add key="Configured Commerce" value="https://nuget.optimizely.com/feed/packages.svc" />
  </packageSources>
</configuration>
```

## Restore and build

In a PowerShell terminal at the repo root:

```powershell
dotnet restore .\src\InsiteCommerce.Web\InsiteCommerce.Web.csproj
dotnet build .\src\InsiteCommerce.Web\InsiteCommerce.Web.csproj
```

## Log in to the Admin Console

With IIS running and the database populated, navigate to:

```
http://localhost:8080/admin
```

| Field | Value |
|---|---|
| Username | `admin` |
| Password | `admin123` |

> When working with an existing customer's `.bacpac` database rather than a fresh `StartingDatabase.sql` import, the admin credentials will be whatever the customer's database contains — `admin` / `admin123` may not work.

## Access Spire CMS content admin

The Spire content admin is at a separate path from the back-office admin console:

```
http://localhost:8080/contentadmin
```

## Troubleshooting

### Exception Details: System.ComponentModel.Win32Exception: The system cannot find the file specified

1. Review for SQL related errors in the stack trace.
1. Ensure SQL is running in Rancher Desktop.

### Gigantic Opti logo

Site appears to be missing CSS and Javascript or as if it is missing an Angular build (the hero swoosh renders at full intrinsic SVG size instead of a small banner, everything unstyled).

**Most likely cause — `.css` served with the wrong MIME type.** Open DevTools → Network, reload, and check the `Content-Type` response header on any `/SystemResources/**/*.css` request. If it's `application/octet-stream` instead of `text/css`, the browser silently refuses to apply the stylesheet even though the request returns 200 OK and the file content is valid. `Web.config`'s `<staticContent>` block already overrides the MIME type for `.woff`, `.woff2`, `.xlsx`, `.ts`, `.scss`, and `.json` — if `.css` is missing from that list, add it the same way:

```xml
<remove fileExtension=".css" />
<mimeMap fileExtension=".css" mimeType="text/css" />
```

A `web.config` edit auto-recycles the app domain, so it takes effect on the next request — but your **browser** will have already cached the bad `application/octet-stream` responses (this same `<staticContent>` block sets a 30-day `max-age` with no revalidation), so do one hard refresh (Ctrl+Shift+R) or clear cached files for the site afterward.

**Alternate cause — IIS anonymous auth identity.** If the CSS `Content-Type` looks correct but requests for static files under `_SystemResources` are failing outright (401/403, not 200), it's a permissions issue instead: in IIS, click the site, double-click Authentication, right-click Anonymous Authentication → Edit, and change from Specific user: `IUSR` to Application pool identity.

<-- Prev: [SSMS Setup](database/ssms-setup.md)
--> Next: [Mise Tools](mise-tools.md)
