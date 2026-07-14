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

### Gigantic Opti logo

Site appears to be missing CSS and Javascript or as if it is missing an angular build.

1. In IIS, click on wausau.local.com, double click on Authentication. Right click on Anonymous Authentication and select Edit. Change from Specific user: IUSR to Application pool identity.
1. 

<-- Prev: [SSMS Setup](database/ssms-setup.md)
--> Next: [Spire Setup](spire-setup.md)
