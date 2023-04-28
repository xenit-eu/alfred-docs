---
title:
  - Alfred Finder
  - Usability Guide
title-slogan:
  - Stop Searching,
  - Start Finding
date: 09/04/2018
document-reference: Finder/Usability Guide/2.0
document-revision: 0.1
copyright-year: 2018

product-version: 2.0
product-color: 5baaa2
frontpage-background-img: AlfredFinder-FrontCover.jpg
backcover-background-img: AlfredFinder-BackCover.jpg
footer-img: AlfredFinder-Footer-Logo.png
pandoc-args:
    template: manual
numbersections: true
secnumdepth: 4
toc: true
fontawesome: true
---

# Usability test guide for Alfred finder

We first give you info about Alfresco, the document model and the test documents we uploaded.
Then you can do some first experience testing, as you never used this program before.

## Alfresco

Alfresco is an ECM system. An Alfresco installation has a lot of documents. These documents have properties, types and aspects.
Alfresco has a document model, which describes which type, aspects or properties a document has.
We developed the Alfred Finder on top of Alfresco to find documents you are looking for.

## Alfresco document model

Alfresco's document model is based around types, aspects and properties.

Every document has exactly one type, for example "Content", "Invoice", "Proposal", "Contrac".
A document can also have a number of aspects like "Has Customer", "Has Product".

Both types and aspects define which structured metadata (properties) will be stored with the document.

* A "Document" type document has a property "Name".
* An "Invoice" type document will contain properties like "Invoice Reference", "Due Date", "Invoice Amount", "Paid".
* A "Proposal" type document will contain properties like "Proposal Reference", "Expiry Date", "Proposal Status".
* A "Contract" type document will contain properties like "Contract Reference", "Contract Status".

Document types are usually laid out in a tree structure, where sub types can add additional properties.

Document

* Invoice
* Proposal
* Contract

Aspects also add additional properties to the metadata of a document, but are not part of the document type tree structure.
They are used to describe properties that are applicable to multiple document types,
or as groups of optional properties that can be added to a document.

* The "Has Customer" aspect will add a "Customer Name" property to the document.
* The "Has Product" aspect will add a "Product Name" property to the document.
* The "Correspondence Info" aspect will add "Correspondence date", "Correspondence sender", "Correspondence receiver", ... properties to the document.

## Test documents

We created the following test documents, which allow you to test the Alfred finder.

* type Invoice Fred, aspects Has Customer, aspect Correspondence Info
  * Name: invoice A.pdf
  * Invoice Reference: 1234-5678
  * Paid: No
  * Customer Name: Acme Inc.
  * Correspondence date: 2018-12-05
  * Correspondence sender: sender
  * Correspondence receiver: receiver
  * Correspondence subject: subject
  * Correspondence reference: reference
  * Department: Finance

* type Invoice, aspects Has Customer, Has Product, aspect Correspondence Info
  * Name: invoice B.pdf
  * Invoice Reference: 1234-5679
  * Paid: Yes
  * Customer Name: Acme Inc.
  * Correspondence date: 2018-10-05
  * Correspondence sender: sender
  * Correspondence receiver: receiver
  * Correspondence subject: subject
  * Correspondence reference: reference
  * Department: Finance
  * Product name: Alfred Finder

* type Fred Document, aspects Has Product
  * Name: Product Description.pdf
  * Product Name: Alfred Finder

* type Proposal Fred, aspects Has Customer
  * Name: proposal A.pdf
  * Proposal reference: 1234-5224
  * Proposal status: Lost
  * Customer Name: Stark Enterprises
  * Correspondence date: 2018-10-05
  * Correspondence sender: sender
  * Correspondence receiver: receiver
  * Correspondence subject: subject
  * Correspondence reference: reference
  * Department: Finance
  * Product name: Alfred Finder

* type Proposal Fred, aspects Has Customer, Has Product
  * Name: proposal B.pdf
  * Proposal Reference: 1234-5216
  * Proposal Status: Lost
  * Customer Name: Acme Inc.
  * Product Name: Alfred Finder

## First experience testing

When we setup a correct Alfresco for you and you know the basis info, you can do your first testing by following the following steps:

### Searching documents

Alfred Finder allows you to search for all properties that are available on documents,
so you can find documents related to a certain subject.

* Search for documents with Customer Name equal to Acme Inc  -> Both the invoice and proposal are shown
* Search for document with Document type equal to Invoice Fred an Customer Name equal to Acme Inc -> Only invoices to Acme Inc are shown.
* Search for documents with product name Alfred Finder.
* Search for documents that were created last month.
* While searching, try sorting on the name property.

### Result list columns

Try changing the columns. (Add `Customer Name` to the result list).
Save your changes so that when you restart the program later, you can restore your changes.

### Metadata editing

* Search for the metadata (the properties) of the proposal B.pdf document.
* Change the name of the document to BBBB.pdf
* Change a date property of the metadata to a year later.
* After reloading the program (F5 in browser), check if the changes are persisted.

### Previewing and downloading document

Search again for the BBBB.pdf document. See the preview. Download the document.

### Version history

See the version history of the BBBB.pdf document. It should say there is none.

### Language

Change the language to dutch. Then to French. Then back to english.

### Panels

Put all panels next to each other. Save this configuration. Reload the application.
Try restoring the configuration with your order of the panels.
