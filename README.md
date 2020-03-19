# SMD_Inventory_Database
This is a database for managing the SMD component inventory data in an Excel spreadsheet.
</br>
Matlab 2018b is used to create the database managing scripts.

## Functions
- ___initialize___: imports the inventory into Matlab. This is the first step before everything else.
- ___backup___: backs up the current inventory inside the Matlab workspace and saves it as an ".xlsx" file in the current folder
- ___status___: performs a status check on the current inventory, identifying parts that are out and organizing the rows by ascending quantity
- ___registerboard___: registers a PC board to make it manufacturable. An Altium-generated BOM is imported and the required parts for this board are searched in the inventory.
- ___addpart___: either add parts manually by entering the required info or importing an excel spreadsheet
- ___rmpart___: removes parts from the inventory

## Requirements
- __BOM__: there must be 7 categories but they do not have to be in the same order as the current inventory.