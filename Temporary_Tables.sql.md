
## Introduction to MySQL temporary table

In MySQL, a temporary table is a special type of table that allows you to store a temporary result set, 
which you can reuse several times in a single session.

## A MySQL temporary table has the following specialized features:

* A temporary table is created by using **CREATE TEMPORARY TABLE** statement.
Notice that the TEMPORARY keyword is added between CREATE and TABLE keywords.

* MySQL **removes the temporary table automatically when the session ends or the connection is terminated**. 
Of course, you can use the  DROP TABLE statement to remove a temporary table explicitly when you are no longer use it.

* A temporary table is **only available and accessible to the client that creates it**. 
Different clients **can create temporary tables with the same name without causing errors** because only the client that creates 
the temporary table can see it. However, in the same session, two temporary tables cannot share the same name.

## Creating a MySQL temporary table

To create a temporary table, you just need to **add the TEMPORARY keyword to the CREATE TABLE statement**.

```mysql
create temporary table _TopCustomers
select p.customerNumber, customerName, sum(amount) total 
from customers c inner join payments p 
on c.customerNumber = p.customerNumber  
group by p.customerNumber 
order by total desc 
limit 10;

mysql> select * from _TopCustomers;
+----------------+------------------------------+-----------+
| customerNumber | customerName                 | total     |
+----------------+------------------------------+-----------+
|            141 | Euro+ Shopping Channel       | 715738.98 |
|            124 | Mini Gifts Distributors Ltd. | 584188.24 |
|            114 | Australian Collectors, Co.   | 180585.07 |

```

## Removing a MySQL temporary table

We can use the DROP TABLE statement to remove temporary tables however it is good practice to add the 
TEMPORARY keyword as follows:

```mysql
DROP TEMPORARY TABLE table_name;

Example

mysql> DROP TEMPORARY TABLE _TopCustomers;
Query OK, 0 rows affected (0.00 sec)

```




