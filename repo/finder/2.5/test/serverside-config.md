# Serverside configuration

## Metadata

### Initial configuration

Initially you have the default finder configuration and also the default test-forms-config.yaml. We first test with this configuration.

1. Search for  "Project Contract" and select the document Project Contract.pdf.
2. The following properties and values should be visible:

    * Name: Project Contract.pdf
    * Type: Content
    * Title: Project Contract for Green Energy
    * Description: Contract for the Green Energy project
    * Author: Alice Beecher,
    * Creator: abeecher, (username instead of first and last name).
    * Created Date: (should be a valid date in YYYY/MM/DD).
    * Modifier: admin
    * Modified Date: (should be a valid date in YYYY/MM/DD).
    * Likes Rating Scheme ratings total: 0
    * Likes Rating Scheme ratings count: 0

3. Click on the Edit button. The following properties should be editable with the following default values:

    * Name: Project Contract.pdf
    * Type: Content
    * Title: Project Contract for Green Energy
    * Description: Contract for the Green Energy project
    * Author: Alice Beecher
    * Creator: abeecher
    * Created Date: 2011/2/15
    * Modifier: admin
    * Modified Date: 2011/6/14
    * Likes Rating Scheme ratings total: 0
    * Likes Rating Scheme ratings count: 0
    * Add/remove properties: Select value

4. Click on type: A popup with a filter should appear. The selections should match the following layout:
    * Content
      * Finder root document
        * Finder sub document 1
          * Finder sub document 1.1
          * Finder sub document 1.2
        * Finder sub document 2
        * Finder sub document 2
    * cmis object
      * cmis item
      * cmis document

5. Click on Add/remove properties. A list of selections appears:
    * Taggable
    * Classifiable
    * All kinds of fields
    * Dynamic constraint data
    * Multiple Dynamic constraint data

6. Select the Dynamic constraint data and the Multiple Dynamic constraint data fields.
    Additional fields are added on the bottom
    Type a letter in the search box of each field. Some values are fetched from a remote autocomplete source and are displayed.
    Select some values. They are shown in the selectfield value.


### Change configuration metadata scenario 1

1. Replace the Data Dictionary > Finder > Forms> test-forms-config.yaml content with the content of ./testconfigs/testmetadata1-config.yaml.

2. Refresh the configuration in the finder. (Menu right top, refresh configuration).

3. Refocus on the document in the result list. The following properties and values in the given order should be visible.

* Type: Smart Folder Template
* ModifiedTitleCreator: System
* Created Date: 2011/2/15
* Modifier: System
* Modified Date: Thu Mar 29 2018 23:01:21 GMT+0200 (CEST)
* Description: Smart Folder Template Sample
* Title: Smart Folder Template Sample
* Author: Alice Beecher
* Name: smartFoldersExample.json
* **FieldsetGroupDefault**
  * Modified Date: 14/June/2011 (Custom date format)
    * The Modified Date label should be colored orange
  * Fields in this fieldset are left aligned
* **FieldsetGroupCollapsibleByDefault**
  * Modified Date: 2011/6/14
  * FieldsetGroupCollapsibleByDefault should be a collapsed group with that title, in a separate card, with a modified date. You should not see ShouldBeInvisible after opening this collapsed group.
  * Fields in this fieldset are centered
* **FieldsetGroupCollapse**
  * Name: Project Contract.pdf
  * FieldsetGroupCollapse should be a collapsable group that is expanded by default.
  * Fields in this fieldset are centered

### Change configuration metadata scenario 2

1. Replace the Data Dictionary > Finder > Forms> test-forms-config.yaml content with the content of ./testconfigs/testfieldsettemplates-config.yaml.

2. Refresh the configuration in the finder. (Menu right top, refresh configuration).

3. Refocus on the document in the result list. The following properties and values in the given order should be visible.

4. (optional) Open devtools run this snippet to outline all fieldsets and show fieldset names

```js
document.querySelectorAll('.metadata-fieldset').forEach(f => f.style.outline = '1px solid red');
document.querySelectorAll('.metadata-fieldset-title').forEach(f => {f.style.display='block'; f.style.color='red' });
```

5. Following fieldsets should be present, all containing Name, title, description, creator, created data, modifier and modified date

 * default-fieldset: Labels are right aligned, values are left aligned against a vertical line.
 * centered: Same as default-fieldset
 * 1-column: Everything is left aligned, each property on a separate line. Values are separated from labels with a fixed amount of whitespace. Values are not aligned among themselves
 * 2-column: Two columns containing the same left-aligned items from 1-column. The columns are filled left-to-right, top-to-bottom. Entries that can not be filled are left empty. When text wraps in one of the columns, entries next to each other are top-aligned and do not affect the alignment of the items on the next row.
 * 3-column: Same as 2-column, except with 3 columns.
 * group-default: Is distinctly separated from the other properties. Contains a title "Default group". It can not be collapsed and its items are shown as in the 1-column layout.
 * group-centered: Is distinctly separated from the other properties. Contains a title "group-centered". It can not be collapsed and its items are shown as in the centered layout.
 * group-collapsible: Is distinctly separated from the other properties. Contains a title "group-centered". It can be collapsed (but is not initially collapsed) and its items are shown as in the 1-column layout.
 * group-collapsible-start-collapsed: Is distinctly separated from the other properties. Contains a title "group-centered". It is initially collapsed and its items are shown as in the 1-column layout.
 * group-start-collapsed: Same as group-default.
 * auto: Contains some other fields that are present on the node.

## Search

### Initial configuration

Click on the searchbar and press arrow down. A list of configured search properties appears.

The following properties should be available to search on:

 * Format (mimetype)
 * Name
 * Author
 * Owner
 * Creator
 * Created Date (date)
 * Modifier
 * Modified Date (date)
 * Categories
 * Full-text (type in "content" to make full-text suggestions appear)
 * All (type in something and press enter to use the ALL chip)

### Change configuration metadata scenario 1

1. Replace the Data Dictionary > Finder > Forms> test-forms-config.yaml content with the content of ./testconfigs/search-properties-default-config.yaml.
2. Click on the searchbar and press arrow down. A list of configured search properties appears.
  The following properties should be available to search on:
    * Textbox
    * Multitextbox
    * Datetime (date)
    * Constraintlist
3. It should not be possible to search for "All", or to get full-text suggestions

### Change configuration metadata scenario 2

1. Replace the Data Dictionary > Finder > Forms> test-forms-config.yaml content with the content of ./testconfigs/search-properties-config.yaml.
2. Click on the searchbar and press arrow down. A list of configured search properties appears.
  The following properties should be available to search on:
    * Format (mimetype)
    * Name
    * Author
    * Owner
    * Creator
    * Created Date (date)
    * Modifier
    * Modified Date (date)
    * Categories
    * Full-text (type in "content" to make full-text suggestions appear)
    * All (type in something and press enter to use the ALL chip)
    * Textbox
    * Multitextbox
    * Datetime (date)
    * Constraintlist
3. It should be possible to search for "All" and to get full-text suggestions
## Result list configuration

### Initial configuration

1. Search for "Project Contract"
2. The following columns should be visible:
    * Name
    * Created date
       * Formatted as YYYY/MM/DD
    * Description
3. Click on the cog above the result list.
4. The following column sets should be available:
   * Default
   * Who/When
   * Auditable
   * Exif Metadata
5. The following columns should be underneath "Other available columns":
   * Version Label
   * Title
   * Author
   * Owner
   * Size
   * Mime Type
   * Creator
   * Modifier
   * Modified Date
   * Working Copy Owner
   * Locale
   * Categories
   * Date and Time
   * Image Width
   * Image Height
   * Horizontal Resolution
   * Vertical Resolution
   * Resolution Unit
   * F Number
   * Exposure Time
   * Flash Activated
   * Focal Length
   * ISO Speed
   * Camera Model
   * Camera Software
   * Orientation
6. Select the Who/When column set. Following items should be selected:
   * Name
   * Author
   * Owner
   * Creator
   * Created Date
       * Formatted as YYYY/MM/DD
   * Modifier
   * Modified Date
       * Formatted as YYYY/MM/DD
7. The "Name" field should not be removable from the columns to display.

### Change configuration metadata scenario 1

1. Replace the Data Dictionary > Finder > Forms> test-forms-config.yaml content with the content of ./testconfigs/columns-default-config.yaml.
2. Search for "Project Contract"
3. Following columns should be visible:
   * Name
   * Title
   * Location
   * Created Date
4. Click the cog above the result list
5. The following column sets should be available:
   * Default
   * Audit
6. The following columns should be available underneath "Other available columns":
   * Format
   * Type
   * Categories
   * Creator
   * Modifier
   * Modified Date
7. Select the audit column set. Following items should be selected:
   * Name
   * Title
   * Creator
   * Created Date
   * Modifier
   * Modified Date
8. The "Name" and "Title" fields should not be removable from the columns to display

### Change configuration metadata scenario 2

1. Replace the Data Dictionary > Finder > Forms> test-forms-config.yaml content with the content of ./testconfigs/columns-config.yaml.
2. Search for "Project Contract"
3. Following columns should be visible:
   * Textbox
   * Name
   * Location
   * Created Date
   * Constraintlist
   * Currency
4. Click the cog above the result list
5. The following column sets should be available:
   * Default
   * Who / When
   * Auditable
   * Exit Metadata
6. The following columns should be available underneath "Other available columns":
   * Datetime
   * Format
   * Type
   * Version Label
   * Title
   * Description
   * Author
   * Owner
   * Size
   * Mime Type
   * Creator
   * Modifier
   * Modified Date
   * Working Copy Owner
   * Locale
   * Categories
   * Date and Time
   * Image Width
   * Image Height
   * Horizontal Resolution
   * Vertical Resolution
   * Resolution Unit
   * F Number
   * Exposure Time
   * Flash Activated
   * Focal Length
   * ISO Speed
   * Camera Model
   * Camera Software
   * Orientation

7. Select the auditable column set. Following items should be selected:
   * Textbox
   * Name
   * Creator
   * Created Date
   * Modifier
   * Modified Date
8. The "Name" and "Textbox" fields should not be removable from the columns to display
