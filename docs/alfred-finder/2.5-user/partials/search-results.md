# Working with the search results

Once a search has been executed, the results of the search are listed in the **Search results** panel. The results can be sorted. You can browse through the multiple pages of the results.
Each column in the list represents the value of a property. Each row represents a result (which is a document in Alfresco). This result list is configurable.

A result can be selected, printed and downloaded.

![The search results table](images/search-results/resultlist.png)

## Sorting search results

The documents in the result list can be sorted by any metadata field.

You can click on the sorting icon in the column header to sort the search results by that field.

![The sorting icon](images/search-results/sortingicon.png)

if a column is sorted, the sorting icon will be replaced with an arrow indicating the sorting order (ascending or descending).

![Sorted Ascending](images/search-results/sortascending.png) ![Sorted Descending](images/search-results/sortdescending.png)

The sorting order can be toggled by clicking on the icon again.

## Grouping search results

The documents in the result list can be grouped by any metadata field.

Clicking on the double arrow icon in a column header, will change the presentation of the results on the current results page
to collapsable sets containing the results that match the selected metadata group. 

![The grouping icon](images/search-results/groupingicon.png)

![Grouped search results](images/search-results/basicgroups.png)

The group can be opened or closed with the arrow at the the front of the row.
The group denominator will also show the number of results from this page in that group.

This operation can be repeated recursively within groups.

![Nested groups](images/search-results/nestedgroups.png)

To undo grouping, click the double arrow icon in the column header once more.


## Browse through the result pages

A search can result in more documents than fit in a single page.

You can see the current page, the number of results requested per page, as well as the a previous and next button at the bottom of the results table.

Navigating to an other page works by clicking the previous or next button.

The number of requested results can be changed by selecting an option from the 'Documents per page' dropdown menu.

When you do a new search, you go back to page 1.


## Result list document actions

The document menu (**\faicon{ellipsis-h}**) contains a list of actions that you can perform on the selected document.

The **Print** and **Download** actions are available for all kinds of documents.

If the *Google Drive* integration is enabled by your organisation, you can use the **Edit with Google Drive** action to collaborate on office documents in *Google Docs*, *Google Sheets* or *Google Slides*.

By clicking the document row itself, you select the document. The selected result is highlighted in the result list.
You can use the arrow keys to select the previous and the next result.
As soon as you select a document, all the detail panels will show the details of the selected document. The next chapter explains the detail panels for the selected result.
The document gets unselected as soon as you do another search.
You can unselect the selected document by clicking on it.
The document gets unselected if you go to another page.


## Configure the results list

You can configure which columns are shown and their order in the result list configuration.

You can enter the result list configuration by clicking the **\faicon{cog}** icon above the result list panel.

In the **Columns to display** window, you can configure the columns that are used in the result list configuration.

![The "columns to display" window](images/search-results/columns-to-display.png)

At the top of the window, you can see a list of *Column sets*. A column set is a group of columns that can be displayed in the result list. Predefined column sets can be created by your organisation, and you can create your own column sets as well.

You can manage the columns that you want to see under *Columns to display*.
You can reorder the visible columns by dragging and dropping, or hide columns by clicking the remove button **\faicon{times-circle}**.

*Other available columns* can be added to the visible columns by clicking on the respective chips. When you click a chip, it is highlighted and is added to the *Columns to display*.

Click *Done* when you are finished to apply your changes.

### Managing column sets

Your *Saved column sets* can be applied by selecting them from the dropdown box.
The columns that are currently displayed will be overwritten with the columns configured in the column set.

You can create your own column set by clicking the **Save as new...** button and typing in a name for your column set.

If you make further changes to the displayed columns, you can save these in the selected column set by using the **Save** button.
The selected column set can also be removed by using the **Delete** button.

> *Note:* It is not possible to modify or remove column sets that are predefined by your organisation.
