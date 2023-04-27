# Searching with Alfred Finder

Search is the center feature of the Alfred Finder. You can search via the search bar. Alfred Finder provides autocompletion to guide you through your search. 
Search results are viewed via the **Search Results** panel. You can redefine the search via the **Filters** panel and via the **Explorer** panel.

## Chip searchbar and chips

You can search via the chip searchbar.
The chip searchbar is the default searchbar you see when you start the finder. In this sub chapter, it is referred to as "the searchbar".
The chips in the searchbar visualize the specified search parameters.
You can add chips via typing in a query in the searchbar. You can have multiple chips, which narrows the search.
Chips can be removed or edited.


![The search bar](images/search/Searchbar.png)

![The search bar which contains a chip](images/search/SearchbarWithChip.png)

### Chips: properties and values

A chip represents a constraint on your search. You can give a property value pair to your chip.

For example: You only want documents with creator admin. Then you need to make a chip for the property creator, which you want to have value admin.
To do this, type _creator:admin_ in the search bar.

Sometimes you just want to search for a value, not really knowing for which property.

For example: You know that admin has something to do with it, but you don't know whether admin was the creator or the modifier, or just in the title of the document.
In that case you just type _admin_ in the search bar, without a property name or a colon. This will create an _All_ chip with value _admin_.

### Narrow the search by using multiple chips

You can have multiple chips. The constraints of each chip are added together.

For instance: You have a chip _creator: admin_ and another chip _modifier: admin_. The search will only show the documents which were created by admin and were modified by admin.
A document that is created by admin but last modified by somebody else will not be shown in the results.
A document that is modified last by admin but created by somebody else will not be shown in the results.

### Delete a chip

Click **\faicon{times}** in the chip.

### Edit a chip

Double-click a chip to edit it. Click \faicon{check-circle} when done editing. To cancel editing, click \faicon{times}. 

### AND and OR operators

Adding extra chips to the searchbar will always limit the result. The filters that are added in this way are cumulative.

It is possible to use more complex search queries using AND and OR operators.

For example, if you want to see all documents that have been created or modified by alice, you combine the _creator:alice_ chip and the  _modifier:alice_ chip, with the _OR_ operator.

You can create this search query by:

1. Typing _OR_ in the searchbar and selecting the suggested _OR_ chip. \
   ![](images/search/Complex1.png)
2. Clicking \faicon{plus-circle} in the newly created _OR_ chip. \
   ![](images/search/Complex2.png)
3. Typing _creator:alice_ into the textbox and selecting the search suggestion. \
   ![](images/search/Complex3.png) \
   The _creator:alice_ chip is added as the first part of the _OR_ chip. \
   ![](images/search/Complex4.png) \
4. Clicking \faicon{plus-circle} and typing in _modifier:alice_. \
   ![](images/search/Complex5.png) \
   Selecting the search suggestion adds the _modifier:alice_ chip to the _OR_ chip.
   ![](images/search/Complex6.png) \

Adding another chip to the existing _OR_ operator chip can be achieved by clicking \faicon{plus-circle} again.

It is possible to arbitrarily nest operator chips to be able to exactly locate the documents you want.

For example, you want to see all documents that are created or modified by alice. Documents authored by alice in the past week must also be included.
Your previous search can be adjusted to accommodate this:

1. Click \faicon{plus-circle} in the _OR_ chip and type _AND_ into the textbox. Select the suggested _AND_ chip. \
   ![](images/search/Complex7.png) \
   The _AND_ chip is added to the _OR_ chip. \
   ![](images/search/Complex8.png) \
3. Click \faicon{plus-circle} in the newly created _AND_ chip and type _author:alice_ into the textbox. \
   ![](images/search/Complex9.png) \
   Selecting the search suggestion adds the _author:alice_ chip as the first part of the _AND_ chip. \
   ![](images/search/Complex10.png) \
5. Click \faicon{plus-circle} in the _AND_ chip again and type _created date:this week_ into the textbox. \
   ![](images/search/Complex11.png) \
   Selecting the search suggestion adds the _created date:this week_ chip to the _AND_ chip. \
   ![](images/search/Complex12.png) \

### Search examples

#### Search for documents via a property

1. Click in the search bar in the text **Start typing to search**.
2. Type the name of a property and its value. \
   Example: _creator:admin_
3. Select the suggestion. \
   A chip with the searched term appears in the search bar.
4. Press ENTER to execute the search.
4. Select the **Search results** panel to view the results of the search.


#### Search on everything

1. Click in the search bar.
2. Type _\*_ and press ENTER. \
   An _All_ chip is created with the wildcard value _\*_.
2. Press ENTER to execute the search.
3. Select the **Search results** panel to view the results of the search.

The search results show all the documents that can be searched.

#### Search for documents without a property

1. Click in the search bar.
2. Type the value. \
   Example: _admin_
3. Press ENTER. \
   An _All_ chip with the searched term appears in the search bar.
4. Press ENTER to execute the search.
4. Select the **Search results** panel to view the results of the search.

The search results show only documents that are related to the entered value.
For example: The results show only documents that are related to _admin_ (e.g. modified by or created by or admin in the title).

### Search with big queries

If you create a complicated search query, the search bar can become very large.
To shrink the search bar, simply click anywhere on the screen outside the component.
If you want to view the search query, you can hover over the search bar and use the scroll bars to see the entire search query if needed.
To lock the search bar in place, you can click on the chips or the input field.

![](images/search/SearchbarWithChipsFocussed.png) \

### Searchbar Filters

These filters require you to specify conditions through an input field.
They allow you to compose a search query, rather than write one from scratch.

To add a filter, select the filter icon in the search bar.

![The Filter Icon](images/search/filtericon.png)

This will open a popup with fields where you can specify your requirements.

_If you do not find the field you wish to filter on, it has not been made available through this popup or as a filter in general.
You may be able to write a requirement straight to the search bar. If not, ask an it administrator for assistance._

![The filter requirements popup](images/search/filterreqs.png)

Selecting the search button in the popup, will apply the filters as chips, and execute your search query.
Building a query in this way, will clear any previous chips from the bar.

To remove any requirement, delete its chip from the search bar.

### Autocompletion

Autocompletion helps you use the correct chip. When you type in the search bar, autocompletion shows a list of possible chips you can use.
When focused in the searchbar, press down. Then the autocompletion should appear.
You can select an item in the list that appears. This can generate a chip, autocomplete the property of the chip or prompt a date picker.
The autocompletion closes when you click outside the autocompletion dropdown or press escape.

![The autocompletion suggestions](images/search/Autocompletion.png)

#### Autocompletion selection

You can select autocompletion suggestions by clicking or by pressing tab.
The two scenarios below explain this. Each will result in the following: a chip with the selected document type appears in the search bar. To execute the search, press enter.

##### Use autocompletion to search a document type by clicking

1. Type _document type:_ in the searchbar. \
   A list of document types appears in the autocompletion.
2. Click on a document type.

##### Use autocompletion to search a document type by tab

1. Type _document type:_ in the searchbar. \
   A list of document types appears in the autocompletion.
2. Press the tab key.
3. Press enter.

#### Autocompletion for dates

The autocompletion can suggest date values for date properties.
You can choose single dates, date ranges, begin date, end date and fixed suggestions.

##### Use autocompletion to pick a single date

1. In the search bar, type _date:_.
2. Select a date search. \
   Example: **Created date:...** \
   A textbox with a date picker appears.
3. Either enter a date via the textbox or use the date picker to choose a date.
4. Press \faicon{check-circle}. \
   A chip with the date search and date appears in the search bar.
5. Press enter to execute the search.
6. Select the **Search results** panel to view the results of the search.

##### Use autocompletion to pick a date range

1. In the search bar, type _date:_.
2. Select a date search. \
   Example: **Created date:...\faicon{arrow-right}...** \
   Two textboxes with date range pickers appear.
3. Use the first textbox or date picker to choose a start date.
4. Use the second textbox or date picker to choose an end date.
5. Press \faicon{check-circle}. \
   A chip with the date search and date range appears in the search bar.
6. Press enter to execute the search.
7. Select the **Search results** panel to view the results of the search.

##### Use autocompletion to pick a fixed date range suggestion

1. In the search bar, type _date:_.
2. Select a date search. \
   Example: **Created date: This Month** \
   A chip with the date search and date range of the last month appears in the search bar.
3. Press enter to execute the search.
4. Select the **Search results** panel to view the results of the search.

## Refine your search query

### Facet Filters

Facet Filters are used to refine your search. These filters provide predefined categories and criteria
Once you execute a search query, you can narrow the results down by selecting a filter that is available within the remaining search results.

1. Execute a search.
2. Select the **Filters** panel. \
   The panel shows the filters of some properties.
3. Expand a filter by clicking on \faicon{angle-down}. \
   For example: Expand the filter **Modifier**. \
   All the possible values of this property appear.
4. Select a value or multiple values and click **APPLY**. \
   The search is executed with the chosen filter applied. \
   The filters are updated.
5. Select the **Search results** panel to view the results of the search.

To remove all filters from a search, click **CLEAR FILTERS**. Individual filters can be removed by deselecting them and clicking **APPLY**.

### Explorer

The **Explorer** panel is used to narrow down the search to a specific folder and its subfolders. In the **Explorer** panel you will find a tree view of the folders in Alfresco.

1. Execute a search.
2. Select the **Explorer** panel.
3. Browse to the folder you wish to search inside of: Clicking on a folder will expand it. Clicking the folder again will collapse it.
4. Click the menu to the right of the folder and select **Search in folder**. \
   An _Inside folder_ chip appears in the search bar and the search is executed.
6. Select the **Search results** panel to view the results of the search. \

The search results will show both documents directly inside the selected folder as well as documents inside its subfolders.
To narrow the search to only documents directly inside a specific folder, a _Folder_ chip can be used instead of the _Inside folder_ chip.
