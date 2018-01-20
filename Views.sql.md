## Introduction to Database View

A database view is a virtual table or logical table which is defined as a SQL SELECT query with joins. 

## Advantages of database view

1) A database view helps **limit data access to specific users**. 
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

## Introduction to CREATE VIEW statement

To create a new view in MySQL, you use the CREATE VIEW statement. The syntax of creating a view in MySQL is as follows:

```mysql
CREATE 
   [ALGORITHM = {MERGE  | TEMPTABLE | UNDEFINED}]
VIEW [database_name].[view_name] 
AS
[SELECT  statement]
```
## View processing algorithms

The algorithm attribute allows you to control which mechanism MySQL uses when creating the view. MySQL provides three algorithms: 
** MERGE, TEMPTABLE, and UNDEFINED **.

1) Using **MERGE algorithm**, MySQL first combines the **input query with the SELECT statement, which defines the view, into a single query**. And then MySQL executes the combined query to return the result set. The MERGE  algorithm **is not allowed if the SELECT statement contains aggregate functions such as MIN, MAX, SUM, COUNT, AVG or DISTINCT, GROUP BY, HAVING, LIMIT, UNION, UNION ALL, subquery**. In case the SELECT statement refers to no table, the MERGE algorithm is also not allowed. If the MERGE  algorithm is not allowed, MySQL changes the algorithm to UNDEFINED. Note that the combination of input query and the query in the view definition into one query is referred to as view resolution.

2) Using **TEMPTABLE algorithm**, **MySQL first creates a temporary table based on the SELECT statement that defines the view, and then it executes the input query against this temporary table**. Because MySQL has to create a temporary table to store the result set and moves the data from the base tables to the temporary table, the **TEMPTABLE  algorithm is less efficient than the MERGE algorithm**. In addition, a view that uses TEMPTABLE  algorithm is not updatable.

3) The **UNDEFINED algorithm** is the *default algorithm when you create a view without specifying an explicit algorithm*. The UNDEFINED algorithm lets MySQL make a choice of using MERGE or TEMPTABLE  algorithm. MySQL prefers MERGE  algorithm to TEMPTABLE  algorithm because the MERGE algorithm is much more efficient.

## View name
Within a database, **views and tables share the same namespace**, therefore, a view and a table cannot have the same name. In addition, the name of a view must follow the table’s naming rules.

## Creating MySQL view examples
Let’s take a look at the orderDetails table. We can create a view that represents total sales per order.
```mysql
create view TotalAmountPerOrder AS
select orderNumber, sum(quantityOrdered*priceEach) as total
from orderdetails 
group by orderNumber 
order by total desc;
```

## Watch newly created view using show tables 
```mysql
  mysql> show tables;
+-------------------------+
| Tables_in_classicmodels |
+-------------------------+
| TotalAmountPerOrder     |
| article_tags            |
| customers               |
| employees               |

To get full details we can use show full tables command
mysql> show full tables;
+-------------------------+------------+
| Tables_in_classicmodels | Table_type |
+-------------------------+------------+
| TotalAmountPerOrder     | VIEW       |
| article_tags            | BASE TABLE |
| customers               | BASE TABLE |
| employees               | BASE TABLE |
The table_type column in the result set specifies which object is view and which object is a table (base table).
```
## Showing view definition
The following is the syntax of the SHOW CREATE VIEW statement:
```mysql
SHOW CREATE VIEW [database_name].[view_ name];
```
To display the definition of a view, you need to specify its name after the SHOW CREATE VIEW  clause.

```mysql
mysql> show create view classicmodels.vps \G;
*************************** 1. row ***************************
                View: vps
         Create View: CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vps` AS select `employees`.`lastName` AS `lastName`,`employees`.`firstName` AS `firstName`,`employees`.`email` AS `email`,`employees`.`jobTitle` AS `jobTitle` from `employees` where (`employees`.`jobTitle` like '%vp%')
character_set_client: utf8
collation_connection: utf8_general_ci
1 row in set (0.00 sec)

ERROR: 
No query specified
```

## Modifying views

MySQL provides two statements that allow you to modify an existing view: **ALTER VIEW and CREATE OR REPLACE VIEW**
Modifying views using ALTER VIEW statement
Once a view is created, you can modify it using the ALTER VIEW statement.

The syntax of the ALTER VIEW statement is similar to the CREATE VIEW statement except that the CREATE keyword is replaced by the ALTER keyword.

```mysql
ALTER
 [ALGORITHM =  {MERGE | TEMPTABLE | UNDEFINED}]
  VIEW [database_name].  [view_name]
   AS 
 [SELECT  statement]

ALTER VIEW EMPINFO
SELECT 
        firstName, lastName, extension, email
    FROM
        employees;

```

## Fetch data from view

```mysql
 mysql> select * from TotalAmountPerOrder;
+-------------+----------+
| orderNumber | total    |
+-------------+----------+
|       10165 | 67392.85 |
|       10287 | 61402.00 |
|       10310 | 61234.67 |

```

## Removing views

Once a view created, you can remove it using the **DROP VIEW statement**. The following illustrates the syntax of the DROP VIEW statement:

```mysql
DROP VIEW [IF EXISTS] [database_name].[view_name]

Example :-
DROP VIEW IF EXISTS organization;

```

## Creating a view based on another view
MySQL allows you to **create a view based on another view**. For example, you can create a view called big sales order based on the SalesPerOrder view to show every sales order whose total is greater than 60,000 as follows:
```mysql
create view TopCustomerOrders AS
select orderNumber, ROUND(total,2) as total 
from TotalAmountPerOrder
where total > 60000;
```
## Creating views with join
```mysql
CREATE VIEW customerOrders AS
    SELECT 
        d.orderNumber,
        customerName,
        SUM(quantityOrdered * priceEach) total
    FROM
        orderDetails d
            INNER JOIN
        orders o ON o.orderNumber = d.orderNumber
            INNER JOIN
        customers c ON c.customerNumber = c.customerNumber
    GROUP BY d.orderNumber
    ORDER BY total DESC;
  ```
 ## Creating views with subquery
 ```mysql
 CREATE VIEW aboveAvgProducts AS
    SELECT 
        productCode, productName, buyPrice
    FROM
        products
    WHERE
        buyPrice > 
 (SELECT 
                AVG(buyPrice)
            FROM
                products)
    ORDER BY buyPrice DESC;
  ```

