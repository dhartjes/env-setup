# Troubleshooting Admin Console

<-- [Back to Admin Console](admin-console.md)

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
