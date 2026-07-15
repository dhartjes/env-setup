# Admin Console

<-- [Back to CFG README](README.md)

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

## Build the frontend CSS

The Admin Console uses Dart Sass (no Ruby required). From `src\InsiteCommerce.Web`:

```powershell
npm install
npx grunt build
```

`npm install` also downloads Node 22.12.0 via mise if it isn't already cached. `npx grunt build` compiles all `.scss` files in `Themes/` and `Styles/` to `.css`. No global grunt-cli install is needed — `npx` runs the locally installed version.

For watch mode during active CSS development:

```powershell
npx grunt
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

Site appears to be missing CSS and Javascript or as if it is missing an angular build.

1. In IIS, click on wausau.local.com, double click on Authentication. Right click on Anonymous Authentication and select Edit. Change from Specific user: IUSR to Application pool identity.
1. 

<-- Prev: [Frontend Tools Setup](frontend-tools-setup.md)
--> Next: [Spire Setup](spire-setup.md)
