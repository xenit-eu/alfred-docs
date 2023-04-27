# Search configuration

The search configuration allows to configure which terms the user can search on.

`Id` can be either `default-search-properties` or `search-properties`. The former will replace the whole list of built-in search terms, the latter will be prepended to the default configuration.

```yaml
\include{yaml/search-configuration.yaml}
```

A search term field supports following configuration properties:

 * `Id`: `string` The id of the column. Every column id is required to be unique across all available columns.
 * `Text`: `string?` The label of the column that will be shown in the user interface. Defaults to the name of the field from the document model.
 * `TextSourceId`: `string?` Reference to translation string of the field label. Currently not used by Alfred Finder.
 * `Parameters`: `object?` A key-value object (`string` to `string`) with parameters for the autocomplete.

The `Parameters` property supports following properties:

 * `type`: `property` The type that the `qname` parameter refers to. Required when the `qname` parameter is present, will default to `property` otherwise. Only the value `property` is supported by Alfred Finder, other values are reserved for future extension.
 * `qname`: `string|undefined` The short or full qname of the property that is linked to this field. Defaults to `Id`, except for special fields, where it is explicitly invalid and must not be present.
 * `resolver`: `string?` The resource resolver to use for autocomplete for this field. See [Resource Resolvers](#resource-resolver).
 * `min-input-length`: `number?` If the field uses a list of allowed values of some sort (Resource resolver, list-of-values constraint, categories, ...). This is the minimum number of characters that has to be typed in the searchbox before filtered results are shown. Defaults to `0`.
 * `max-display-result`: `number?` If the field uses a list of allowed values, this is the maximum number of results that will be shown in the filtered results list. Defaults to an unlimited number of results.

For compatiblity with the Alfred Desktop configuration, fields can be nested inside fieldset unlimited. All objects that have an empty or non-existing `Fields` property are recognised as a field, regardless of its nesting depth.

Alfred Finder shows a flat list of fields, regardless of the fieldsets they are nested in.

## Special field ids

Some field ids are interpreted as special, and will have custom configuration applied.

* `All`: Allow searching across all properties. This property has the property
 * `searchAllWithPropertyAll`: `boolean?` Set to true to ensure that the all property is used. Set to false to ensure that the all property is translated to all properties that are searchable in the finder. Defaults to false. An example configuration is given below.
* `FullText`: Allow searching in the document text
* `Format`: Allow searching for document mimetypes

```yaml
\include{examples/SearchAllWithApixAll.yaml}
```

## Search Filter

The fields available in the search bar filter popup can be configured from the forms-config and can be extended or overwritten.
By default, a number of common fields from the alfresco content model are configured (cm:name, cm:author, cm:creator, cm:created, cm:modifier, cm:modified)

### Defaults
 ```yaml
\include{yaml/search-filters-default.yaml}
 ```

### Example
```yaml
\include{examples/Example-search-filter-config.yaml}
```
