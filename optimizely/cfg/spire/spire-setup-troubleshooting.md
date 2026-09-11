# Troubleshooting Spire Setup

<-- [Back to Spire Setup](spire-setup.md)

**"We're sorry. An unhandled error has occurred and been reported." With console error "Environment__ElasticsearchNextServerUrl**

Review the DevTools Console. If the error message looks like:

```
  "message": "There is not currently a setting for 'Environment__ElasticsearchNextServerUrl' in the AppSettings section of your web.config."

```

Then a config step was missed.
