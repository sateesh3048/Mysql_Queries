
## Stored Function

A stored function is a special kind stored program that **returns a single value**. 
You use stored functions **to encapsulate common formulas or business rules that are reusable among SQL statements** 
or stored programs.

** MySQL stored function syntax
The following illustrates the simplest syntax for creating a new stored function:

```mysql
CREATE FUNCTION function_name(param1,param2,…)
    RETURNS datatype
   [NOT] DETERMINISTIC
 statements
```

1) Specify the name of the stored function after  CREATE FUNCTION  clause.
2) List all parameters of the stored function inside the parentheses. By default, all parameters are IN parameters. 
3)  you must specify the data type of the return value in the **RETURNS** statement.
4) For the same input parameters, if the stored function returns the same result, it is considered deterministic and otherwise 
the stored function is not deterministic.

## MySQL stored function example
```mysql
delimiter $$
create function customerLevel(creditLimit double) 
returns varchar(100) 
DETERMINISTIC
BEGIN
  declare msg varchar(100);
  if(creditLimit > 50000) THEN
    SET msg = "PLATINUM";
  elseif(creditLimit <= 50000 and creditLimit > 10000) then
    SET msg = "Gold";
  else
    SET msg = "Silver";
  end if;
  return (msg);
END $$
delimiter ;
mysql> select customerNumber, creditLimit, customerLevel(creditLimit) from customers limit 10;
+----------------+-------------+----------------------------+
| customerNumber | creditLimit | customerLevel(creditLimit) |
+----------------+-------------+----------------------------+
|            103 |    21000.00 | Gold                       |
|            112 |    71800.00 | PLATINUM                   |
|            114 |   117300.00 | PLATINUM                   |

```




