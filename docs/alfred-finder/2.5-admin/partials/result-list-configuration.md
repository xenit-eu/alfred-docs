# Search result list configuration

Users can select which columns they want to view in the Alfred Finder search result list.

There are 2 sets of configuration that define how users can select different columns:

 * The Column list allow the user to add and remove individual columns from the result list configuration.
 * Column sets allow the user to use a predefined set of columns for the result list.
    Column sets can be provided by configuration or can be created by the user from the columns selected from the column list.

## Column list configuration

The column list configuration allows to configure which fields the user can select to show in the result list.

`Id` can be either `default-column-list` or `column-list`. The former will replace the whole list of built-in column properties, the latter will be prepended to the default configuration.

```yaml
\include{yaml/column-list-configuration.yaml}
```

![Result of the example configuration](images/result-list-example-config.png)

A column list field supports following properties:

 * `Id`: `string` The id of the column. Every column id is required to be unique across all available columns.
 * `Text`: `string?` The label of the column that will be shown in the user interface. Defaults to the name of the field from the document model.
 * `TextSourceId`: `string?` Reference to translation string of the field label. Currently not used by Alfred Finder.
 * `Parameters`: `object?` A key-value object (`string` to `string`) with parameters for the column renderer. Supported parameters depend on the renderer.

The `Parameters` property supports following properties across all templates:

 * `renderer`: `string?` The column renderer that will be used for the field. Defaults to `view.renderer.node.property`
 * `filter`: `string?` The filter that will be shown for the column. Not used by Alfred Finder
 * `fixed`: `boolean?` Marks the column as fixed. Fixed columns will always be present in the columns list and can not be removed. Defaults to `false`.
 * `type`: `property` The type that the `qname` parameter refers to. Required when the `qname` parameter is present, will default to `property` otherwise. Only the value `property` is supported by Alfred Finder, other values are reserved for future extension.
 * `qname`: `string?` The short or full qname of the property that is linked to this field. Defaults to `Id`, except for special fields, where it is explicitly invalid and must not be present.
 * `sortable` : `boolean?` Marks the column as sortable. Defaults to true, in case this is missing.
 * `text-align`: `left|center|right` The alignment of the items in the column. Defaults to left.
 * `groupable`: `boolean?` Marks the column as eligible for grouping in results. Defaults to `true`.

The `Parameters.renderer` property supports the following values:

 * `view.renderer.node.property`: Renders the value of a normal property specified by the `qname` parameter.
 * `view.renderer.node.name`: Renders the value of the `cm:name` property. May be extended in the future to render an icon for the mimetype of the document.
 * `view.renderer.node.property.name`: Alias of `view.renderer.node.name`
 * `view.renderer.node.property.category`: Resolves categories to their human readable names.
 * `view.renderer.node.property.currency`: Specialised renderer for currency where the monetary value is stored in cents but has to be displayed as a decimal number.
 * `view.renderer.node.property.string-length`: Displays the string length of a normal property.
 * `view.renderer.node.type`: Displays the document type of the node.
 * `view.renderer.node.size`: Shows the human readable size of a `d:content` property.
 * `view.renderer.node.mimetype`: Shows the mimetype of a `d:content` property.
 * `view.renderer.node.location`: Shows the primary path to the node.
 * `view.renderer.node.extension`: Shows the filename extension (last part after `.`) from any property.

A column list fieldset supports following properties:
 * `Id`: `string` The id of the fieldset. Every fieldset id is required to be unique across all fieldsets. Fieldsets with the same Id will overwrite default fieldsets.
 * `Text`: `string?` The label of the fieldset that will be shown in the user interface if `Appearance: submenu`. Defaults to the id of the fieldset.
 * `TextSourceId`: `string?` Reference to translation string of the fieldset label. Currently not used by Alfred Finder.
 * `Appearance`: `submenu|section|undefined` The way the fieldset is displayed. A submenu will display as a separate block with its label as title. A section will separate the block with a horizontal line.
 * `Fields`: `(Field|FieldSet)[]` Array of fields or fieldsets contained in this fieldset.

For compatiblity with the Alfred Desktop configuration, fieldsets have no limit on depth. All objects that do not have a `Fields` property are recognised as a field, regardless of its nesting depth.

### Special field ids

Some field ids are interpreted as special, and will have custom configuration applied.
Most configuration options for normal fields are also valid for special fields. Illegal configuration options will be ignored.

* `info`: Uses the `view.renderer.node.type` renderer
* `name`: Uses the `view.renderer.node.name` renderer with the `cm:name` property
* `location`: Uses the `view.renderer.node.location` renderer
* `format`: Uses the `view.renderer.node.extension` renderer with the `cm:name` property
* `Highlights`: Uses the `view.renderer.searchHit.highlights` renderer with the `cm:content` qname and `property` type, and must be marked `sortable: false`

## Column set configuration

Column set configuration allows to group useful properties together in a way that the user can instantly switch between groups of properties.

The column set with an `Id` of `DEFAULT` determines the columns that will be shown by default in the result list.

`Id` can be either `default-column-sets` or `column-sets`. The former will replace the whole list of built-in column sets, the latter will be prepended to the default configuration.

```yaml
\include{yaml/column-sets-configuration.yaml}
```

A column set fieldset supports following properties:

 * `Id`: `string` The id of the column set. Every column set id is required to be unique across all available columnsets.
 * `Text`: `string` The label of the column set that will be shown in the user interface.
 * `TextSourceId`: `string?` Reference to translation string of the field label. Currently not used by Alfred Finder.

A column set field only supports the `Id` property, which has to refer to an `Id` of a field that is used in the [Column list configuration](#column-list-configuration)

For compatiblity with the Alfred Desktop configuration, fields can be nested inside fieldsets unlimited. All objects that have an empty or non-existing `Fields` property are recognised as a field, regardless of its nesting depth.

For the column set configuration, individual fields represent the columns in a set and are not rendered. Only fieldsets that directly contain only fields are shown as column sets in a flat list of fieldsets, regardless of their nesting depth.
