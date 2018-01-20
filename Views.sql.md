## Introduction to Database View

A database view is a virtual table or logical table which is defined as a SQL SELECT query with joins. 

## Advantages of database view

1) A database view helps limit data access to specific users. 
You may not want a subset of sensitive data can be queryable by all users. 
You can use **a database view to expose only non-sensitive data to a specific group of users**.

2) A database view **enables computed columns**. A database table should not have calculated columns however a database view should. 
Suppose in the orderDetails table you have quantityOrder (the number of ordered products) and priceEach (price per product item) columns.
However, the orderDetails  table does not have a computed column to store **total sales** for each line item of the order. We can 
store these details in views.

3) Using database views we can hide the complexity  of underlying tables with joins to the end-users.

## Disadvantages of database view

1) **Tables Schema dependency**: you create a view based on underlying tables of the database. Whenever 
**you change the structure of these tables that view associated with, you have to change the view as well.**
2) Performance: querying data from a database view can be slow especially if the view is created based on other views.
