
## MySQL aggregate functions

MySQL aggregate functions – provide a brief overview of the most commonly used MySQL aggregate functions

* AVG – calculate the average value of a set of values or an expression.
* COUNT – count the number rows in a table.
* INSTR – return the position of the first occurrence of a substring in a string.
* SUM – calculate the sum of a set of values or an expression.
* MIN – find the minimum value in a set of values
* MAX – find the maximum value in a set of values
* GROUP_CONCAT – concatenate strings from a group into a string with various options such as DISTINCT , ORDER BY and SEPARATOR .

## Count

The COUNT function returns the number of rows in a table. The COUNT function allows you to **count all rows in a table or rows that 
match a particular condition**.

The syntax of the COUNT function is as follows.

```mysql
  COUNT(expression)
  COUNT(*)
  COUNT(DISTINCT expression)
```

##Examples of count function

To get total number of products in products table

mysql> select count(*) from products;
+----------+
| count(*) |
+----------+
|      110 |
+----------+
1 row in set (0.00 sec)

To get count of shipped orders
mysql> select count(*) from orders where status="shipped";
+----------+
| count(*) |
+----------+
|      303 |
+----------+
1 row in set (0.00 sec)

To get the count of orders placed by unique customers
mysql> select count(distinct customerNumber) from orders;
+--------------------------------+
| count(distinct customerNumber) |
+--------------------------------+
|                             98 |
+--------------------------------+
1 row in set (0.00 sec)


## Use of count function in Group by clause

To find the number of products supplied by vendors, you use the following query:
SELECT productvendor, count(*)
FROM products
GROUP BY productvendor;

mysql> select productVendor, count(*) from products group by productVendor;
+---------------------------+----------+
| productVendor             | count(*) |
+---------------------------+----------+
| Autoart Studio Design     |        8 |
| Carousel DieCast Legends  |        9 |
| Classic Metal Creations   |       10 |
| Exoto Designs             |        9 |
| Gearbox Collectibles      |        9 |
| Highway 66 Mini Classics  |        9 |

To find which vendor supplies at least 9 products, you use the COUNT function in the HAVING clause as the following query:

mysql> select productVendor, count(*) as total from products group by productVendor having total >= 9;
+--------------------------+-------+
| productVendor            | total |
+--------------------------+-------+
| Carousel DieCast Legends |     9 |
| Classic Metal Creations  |    10 |

## MySQL COUNT IF

You can **use a control flow function e.g., IF, IFNULL, CASE, etc.,** in the COUNT function to count rows whose 
values match a condition.

mysql> select count(if(status="Cancelled", status, null)) as cancelled, 
    -> count(if(status="On Hold", status, null)) as on_hold,
    -> count(if(status="Shipped", status, null)) as shipped from orders ;
+-----------+---------+---------+
| cancelled | on_hold | shipped |
+-----------+---------+---------+
|         6 |       4 |     303 |
+-----------+---------+---------+
1 row in set, 313 warnings (0.00 sec)

