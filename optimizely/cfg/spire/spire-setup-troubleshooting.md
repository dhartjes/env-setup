# Troubleshooting Spire Setup

<-- [Back to Spire Setup](spire-setup.md)

**"We're sorry. An unhandled error has occurred and been reported." With console error "Environment__ElasticsearchNextServerUrl**

Review the DevTools Console. If the error message looks like:

```
  "message": "There is not currently a setting for 'Environment__ElasticsearchNextServerUrl' in the AppSettings section of your web.config."

```

Then `Environment__ElasticsearchNextServerUrl` is missing from `src\InsiteCommerce.Web\config\AppSettings.config` — it doesn't exist in the default template and must be added manually. Check the port matches what `docker-compose.yml`'s `elasticsearchnext` service is actually bound to (`9200` here, not the `Logging__ElasticServerUrl` default's `9201`). See [Local Edits → AppSettings.config](../local-edits.md) for the exact keys and values.
