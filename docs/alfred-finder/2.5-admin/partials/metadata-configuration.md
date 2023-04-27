# Metadata configuration

## Introduction

Alfred Finder configures its document views with forms. The style of configuration is based on the Share forms configuration used by Alfresco and is compatible with the Alfred Desktop metadata configuration.

Alfred Finder comes with a default configuration that works for the Alfresco content model out of the box, but you might want to configure how you custom metadata model is displayed and used.

## Where are forms used?

### View & edit metadata

The metadata panel is a dynamic panel that evaluates the document type and aspects of the selected document and generates a customized form.
The panel can be placed in three different modes, that can be configured individually: View mode - To view metadata; Edit mode - To edit metadata; and Create mode - To provide metadata when creating a new document.

![The metadata panel in view mode](images/metadata-panel.png)

### Search properties

The list of properties that can be searched for in the searchbar can be configured using the forms configuration, which lists all the properties you would like to search on.

### Columns in the search result list

In the search result view, the user can select columns to show or hide in the results table.

It is also possible to configure column sets, which are fixed sets of columns  that can be used to quickly switch between columns used for two different contexts.

![Result list configuration](images/result-list-configuration.png)


## Configuration files

Forms are configured in YAML files that adhere to the forms configuration schema.

An empty form configuration template looks like this:

```yaml
\include{yaml/configuration-template.yaml}
```

### Top level

The top level configuration has 4 properties:

 * `Id`: `string` The id of the configuration. Multiple forms with the same id will override each other, the last one that is loaded wins. How the id is used for matching depends on the evaluator.
 * `Evaluator`: `string` Evaluator that is used to check if the configuration applies.
 * `Version`: `number` The configuration schema version of the configuration. The current supported version is `1`.
 * `Forms`: `Form[]` Array of forms that are specified by this configuration.

Alfred Finder supports configuration schema version 1, configurations with other versions are ignored.

The `Evaluator` determines how an `Id` is matched:

 * `string-compare`: The id is matched against a string
 * `node-type`: The id is matched against the type of a node (short or long qname)
 * `aspect`: The id is matched against the aspects of a node (short or long qnames)

If multiple configurations are matched for the same node, they will be merged when constructing the metadata panel. See [Configuration Merging](#configuration-merging) for more details.

### Top level > Forms

The form configuration has 2 properties:

 * `Id`: `string?` The id of the form. This id defaults to `undefined` when omitted.
    This id is currently unused, but may be used for future extension points.
    Values other than `undefined` are unsupported.
 * `Fields`: `Field[]` Array of fieldsets in this form

### Top level > Forms > Fields

A fieldset groups a number of fields together.
When merging multiple configurations together, fieldsets with the same `Id` are merged together. See [Configuration Merging](#configuration-merging) for more details.

The fieldset configuration has 10 properties:

 * `Id`: `string` The id of the field set. Defaults to `null` when omitted.
 * `Text`: `string?` The title of the fieldset. May be displayed in Alfred Finder, depending on the used form template: If the template does not show a title, the title will stay invisible.
 * `TextSourceId`: `string?` Reference to translation string of the fieldset title. Currently not used by Alfred Finder.
 * `Description`: `string?` Description of the fieldset. Currently not displayed in Alfred Finder.
 * `DescriptionSourceId`: `string?` Reference to translation string of the fieldset description. Currently not used by Alfred Finder.
 * `Help`: `string?` Extended help text about the fieldset. Currently not displayed in Alfred Finder.
 * `HelpSourceId`: `string?` Reference to translation string of the fieldset help. Currently not used by Alfred Finder.
 * `Template`: `string?` Id of the template to use to display the fieldset. It can be used to alter how the fieldset is displayed. Defaults to `gui.controlfactory.fieldset.centered`
 * `Parameters`: `object?` A key-value object (`string` to `string`) with parameters for the fieldset template. Supported parameters depend on the template.
 * `Fields`: `Field[]?` Array of fields in this fieldset

The `Template` property supports the following values:

* `gui.controlfactory.fieldset.centered`: A centered layout with field label on the left and field value on the right. The layout right aligns field labels and left aligns field values around a vertical axis.
* `gui.controlfactory.fieldset.1-column`: Single column layout where field label and field value are left aligned next to each other.
* `gui.controlfactory.fieldset.2-column`: Two column layout variant
* `gui.controlfactory.fieldset.3-column`: Three column layout variant
* `gui.controlfactory.fieldset.group`: Draws a card to group fields together. The value provided in `Text` is used as title for the card.
    - Parameter `centered`: `boolean` If true, use the centered fieldset layout inside the group. If false, use the 1-column layout. Default `false`.
    - Parameter `collapsible`: `boolean` Makes the grouped fieldset collapsible. Default `false`
    - Parameter `start-collapsed`: `boolean` If the fieldset is collapsible, show the fieldset initially as collapsed. Default `false`

### Top level > Forms > Fields > Fields

A field represents a single property of a document.

The field configuration has 11 properties:

 * `Id`: `string` The id of the field. Required.
 * `Text`: `string?` The label of the field. Defaults to the name of the field in the document model.
 * `TextSourceId`: `string?` Reference to translation string of the field label. Currently not used by Alfred Finder.
 * `Description`: `string?` Description of the field. Currently not displayed in Alfred Finder.
 * `DescriptionSourceId`: `string?` Reference to translation string of the fieldescription. Currently not used by Alfred Finder.
 * `Help`: `string?` Extended help text about the field. Currently not displayed in Alfred Finder.
 * `HelpSourceId`: `string?` Reference to translation string of the field help. Currently not used by Alfred Finder.
 * `ReadOnly`: `boolean?` Forces the field to always be rendered as it is in the `View` rendermode. Defaults to `true` for properties marked as *protected* in the document model. Defaults to `false` for other properties.
 * `RenderMode`: `RenderMode[]?` The rendermodes of the metadata panel for which the field is visible.
 * `Template`: `string?` Id of the template to use to display the field. It can be used to alter how the field is displayed. The default value depends on the dictionary type of the property.
 * `Parameters`: `object?` A key-value object (`string` to `string`) with parameters for the field template. Supported parameters depend on the template.

#### RenderMode property

The `RenderMode` property supports the following values:

 * `Hidden`: Forces the field to be hidden in all render modes
 * `Create`: Show the field when creating metadata for new document
 * `Edit`: Show the field when editing metadata
 * `View`: Show the field when viewing metadata


#### Template property


The `Template` property supports the following templates:


 * `gui.controlfactory.property.label`: Always read only and shows the value of the property as text. (default for `d:noderef`, `d:qname`, `d:content`)
 * `gui.controlfactory.property.textbox`: One line text field for short text values. (default for `d:text`, `d:mltext` (default value only), `d:int`, `d:long`, `d:float`, `d:double`)
 * `gui.controlfactory.property.textarea`: Multi-line text field for text values. Does not support editing multi-value fields.
 * `gui.controlfactory.property.listconstraint`: Dropdown field to select one/multiple values of a list constraint. (default for fields with a LIST constraint)
 * `gui.controlfactory.property.datetimepicker`: Date picker for date values. Does not support editing multi-value fields. (default for `d:date` and `d:datetime`)
    * Parameter `date-format`: `string` [MomentJS](http://momentjs.com/docs/#/displaying/format/) format string to set how the date should be displayed. Defaults to `Y/M/D`.
    * Parameter `override-default-value`: `"today"|Date|null` A string "today" to set the default value to the current date; an [RFC2822](https://tools.ietf.org/html/rfc2822#section-3.3) or (a variant of) [ISO 8601](https://www.w3.org/TR/NOTE-datetime) date that will be used as the default value; or `null` to not set any default value. Defaults to `null`.
 * `gui.controlfactory.property.checkbox`: Checkbox for boolean values. Does not support multi-value fields. (default for `d:boolean`)
 * `gui.controlfactory.property.currency`: Specialised text field for currency. Stores monetary value as a number of cents and displays it as a decimal number. Does not support multi-value fields.
 * `gui.controlfactory.property.size`: Read only field that shows the human readable size of a `d:content` property.
 * `gui.controlfactory.property.mimetype`: Read only field that shows the mimetype of a `d:content` property
 * `gui.controlfactory.property.categorypicker`: Category picker (default for `d:category`)
 * `gui.controlfactory.property.authority`: Not supported yet
 * `gui.controlfactory.property.dropdown`: Custom autocomplete dropdown based on a source file.
    <!-- NOTE: Resolvers are used for more things internally, but external use is only supported for this template. -->
    * `resolver`: `string` The resource resolver to use for this field. See [Resource Resolvers](#resource-resolver).



#### Parameters property


The `Parameters` property supports following properties across all templates:

 * `type`: `property` The type that the `qname` parameter refers to. Required when the `qname` parameter is present, will default to `property` otherwise. Only the value `property` is supported by Alfred Finder, other values are reserved for future extension.
 * `qname`: `string|undefined` The short or full qname of the property that is linked to this field. Defaults to `Id`, except for special fields, where it is explicitly invalid and must not be present.
 * `label-color`: `CSSColor?` The text color of the label. Can be used to emphasize a certain field. Must be a valid CSS color expression. If not present, it defaults to the text color used on the webpage.
 * `mandatory`: `boolean?` Adds an indicator that a field is mandatory. Defaults to the mandatory state of the property in the document model.
 * `protected-override`: `boolean?` If `true`, disable `ReadOnly` that was automatically enabled because a property is protected. Use of this property is not recommended, set `ReadOnly: false` on the field instead.
 * `default-value`: `any` The default value to show when a property is not present on a node. This default value will also be prefilled in the form when creating new content. Its type must be compatible with the type of the property.
 * `min-input-length`: `number?` If the field uses a list of allowed values of some sort (Resource resolver, list-of-values constraint, categories, ...). This is the minimum number of characters that has to be typed in the searchbox before filtered results are shown. Defaults to `0`.
 * `max-display-result`: `number?` If the field uses a list of allowed values, this is the maximum number of results that will be shown in the filtered results list. Defaults to an unlimited number of results.

#### Special field ids

Some field ids are interpreted as special, and will be rendered by a custom template.
Most configuration options for normal fields are also valid for special fields.
Illegal configuration options will be ignored.

* `type`: Shows a dropdown menu to change the document type.
    * Parameters starting `doctype.` are used to build a tree of document types that are shown in the dropdown menu.
* `template-name`: Not supported in Alfred Finder, rendered as an empty field.
* `aspect-picker`: Shows a dropdown menu to change the aspects.
    * Parameters starting with `aspect.` are used to build a tree of aspects that are shown in the dropdown menu.
* `xmd.validate.message`: Not supported in Alfed Finder

## Examples

### Resource resolver

It is possible to add an autocomplete metadata field where the results are based on the contents of a source file.
In edit mode you can start typing in the text box and based on the values in a source file it will suggest
all possible values.
Multi-value properties and single-value properties are both supported.

This feature is similar to a list constraint (defined in the model) on a property but the list has the
advantage of being fully editable. You do not have to make changes to the document model. you only
need to change the list in the source file.
To enable this feature you will need 2 custom made webscripts. The first webscript is responsible for
searching a value in the source file. The second webscript is responsible for looking up a key in the
source file and resolving it to the corresponding value.

Both webscripts should return a json result that looks like the following the following output:

```json
\include{examples/resource-resolver/webscript-output.json}
```

The following configuration is required to register the resource resolver:

```yaml
\include{examples/resource-resolver/resolver-config.yaml}
```

Under `Fields` you can see 2 objects. The first object is the `lookup` object. This object is used to show
the property value in view mode. The `endpoint` is the url to the webscript that is responsible for the
lookup.
The second object is the `query` object. This object is used to search for all possible values for the
property in edit mode. The `endpoint` is the url to the webscript that is repsonsible for querying.

Now you also need to configure the dropdown control for the metadata panel. You can do this in the
following way:

```yaml
\include{examples/resource-resolver/forms-config.yaml}
```

You have to use the `gui.controlfactory.property.dropdown` template.

The `resolver` parameter points to the id of the fieldset containing the lookup and query objects from the previous configuration snippet. The resolver name is constructed by concatenating the fixed value `repo.resources.` and resource resolver fieldset id.

## Configuration merging

When multiple configurations specify the same `Id`, they have to be merged into one configuration before a form can be built.

### Top level configuration merging

The top level configurations with the same id are not merged.
Configurations that are loaded later overwrite earlier configurations with the same id.
When debug is enabled for `finder-services:configuration:merge`, a message is printed when a configuration is overwritten.

Configurations are loaded in this order:

1. Embedded default configuration
2. `*-forms-config.yaml` files from `Data Dictionary/Fred/Forms`
3. `*-forms-config.yaml` files from `Data Dictionary/Finder/Forms`

The order in which files are loaded within each step is undefined and should not be relied on.

### Forms configuration merging

When multiple configurations are matched for a node, the forms contained within these configurations are merged by id.

The configuration with a `node-type` evaluator and an `Id` matching the type of the node is looked up and used as base configuration. If this configuration does not exist, the configuration with  a `string-compare` evaluator and `Id` of `default-node` is used as a base.

Additional configurations are loaded with the `aspect` evaluator and an `Id` matching any of the aspects of the node. The order of configurations within this set is undefined and should not be relied on.

Starting from the base configuration, fieldsets defined in the aspects are merged to one configuration.
If the `default-node` configuration was used as base configuration, all fields that are present on the node, but are not present anywhere in the configuration are appended to the fieldset with id `auto`.

Fieldsets that are referenced in the base configuration retain their position as specified in the base configuration. Fieldsets that were not referred to are appended to the form in the order they are encountered.

Fieldsets are merged by id: fieldsets present in later configurations overwrite fieldset settings from earlier configurations. Fields from later configurations are appended to the fields specified in earlier configurations.

Fields with the same `Id` within the same fieldset are not merged, but are shown as separate fields.
