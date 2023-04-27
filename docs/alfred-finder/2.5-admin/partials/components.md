# Components Configuration

Alfred Finder supports an easy way to enable different functional components using the config.yaml file.

1. Upload functionality
2. Share Links

Using flags inside of Finder we can set up the functionality per customer needs by adjusting the *.yaml file in `Repository/Data Dictionary/Finder`

## Upload
This enables or disables all the upload functionality in Finder.

## Share links
This enables a link to go to the document in Share. This helps the customer to easily acces Share in case they have a need to start e.g. a workflow.

```yaml
\include{yaml/component-configuration.yaml}
```