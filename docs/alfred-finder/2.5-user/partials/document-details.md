# Working with the detail panels of Alfred Finder

You can select a document, as described in the previous chapter.
The detail panels of Alfred Finder show the following information of the selected result:

* The metadata are shown in the **Metadata** panel.
* The preview is shown in the **Preview** panel.
* The comments are shown in the **Comments** panel.
* The version history is shown in the **Versions** panel.

## Metadata panel

In an ECM platform, files are enriched with metadata, which makes it much easier to search, categorize and retrieve the files you need.
Metadata can be any kind of information that specifies the content or status of a file.

In Alfresco, metadata is organised in the following way:

 * Every file has a document type, which has a particular combination of specific metadata fields
 * Some metadata fields can appear in multiple document types
 * Metadata can be mandatory or optional, and can have a single value or support multiple values
 * Constraints can be added to metadata fields, restricting the values that can be entered
 * Metadata fields can be restricted to a set of predefined values

### Viewing the metadata of a document

The metadata of documents are shown in the **Metadata** panel.

When you select a document in the **Search results** panel, the **Metadata** panel will contain the metadata of the selected document.

The metadata fields that you can see depend on the document type of the selected document.
For example, an invoice will contain other metadata fields then a meeting report.

### Edit the metadata of a document

To edit metadata, click the **Edit** button in the **Metadata** panel.

The document metadata will become editable.

You can perform edits such as changing the document type, adding or removing optional metadata fields and editing metadata fields. Based upon the rules defined by your organisation, some fields might be mandatory to fill in and others can be optional.

Different kinds of metadata fields have can have different ways to input values:

 * A text metadata field will give a simple textbox to enter data in.
 * A date field will show a date picker when clicked
 * A metadata field with a set of predefined values will show a dropdown list where a value can be selected

At the bottom of the metadata fields, a list with optional groups of metadata fields is presented.
You can decide to add or remove metadata fields relevant to the document.

Mandatory metadata fields are indicated with a `*` behind their name, and are required to be filled in before the metadata can be saved.

## Comments panel

The comments panel allows to view and add comments on the selected document.

You can see a list of comments created by yourself and others in this panel.

You can add a new comment by clicking the new comment button, typing your comment in the textbox and clicking the **Add comment** button to save it.

Depending on your permissions, you may be able to edit or delete your own and other's comments.

If available, you can edit a comment by expanding the \faicon{ellipsis-v} menu inside the comment and clicking **Edit**.
The comment will then become editable. You can save your edits by clicking **Update comment**, or discard your edits by clicking **Cancel**.

Deleting a comment is possible by expanding the \faicon{ellipsis-v} menu inside the comment and clicking **Delete**.

## Preview panel

The **Preview** panel shows a read-only version of the selected document.

The type of preview depends on the type of document and whether a preview is available or not.


The following non exhaustive list of document types can be previewed:

* PDF documents
* Word documents
* Plain text documents
* Images
* HTML documents
* MP4 video files
* eml (e-mail) files

In case a pdf or word document is selected, a built-in viewer is opened that allows to you to search and zoom in the document.

The presentation of images, HTML documents and MP4 video files is handled by your web browser.

## Versions panel

You can see the version history of the selected document in the **Versions** panel.

The version history is only visible if a document has a version history.

Alfred Finder does not yet support restoring a previous version of a document.
