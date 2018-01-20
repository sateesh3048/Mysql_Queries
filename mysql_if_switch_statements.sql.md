## MySQL IF ELSEIF ELSE statement

If you want to execute statements conditionally based on multiple expressions, you use the IF ELSEIF ELSE statement as follows:
```mysql
IF expression THEN
   statements;
ELSEIF elseif-expression THEN
   elseif-statements;
...
ELSE
   else-statements;
END IF;
```

## Example code for mysql If else statements

```mysql
IF credit_limit < 10000 THEN
  SET customer_level = "Silver";
ELSEIF credit_limit >= 10000 AND credit_limit <= 50000 THEN
  SET customer_level = "Gold";
ELSE
  SET customer_level = "Diamond";
END IF;
```


## Mysql Switch Statements 

```mysql
CASE  case_expression
   WHEN when_expression_1 THEN commands
   WHEN when_expression_2 THEN commands
   ...
   ELSE commands
END CASE;
```

## Example code for switch case statements

```mysql
DELIMITER $$
DROP PROCEDURE getCustomerShippingDetails $$
CREATE PROCEDURE getCustomerShippingDetails(
  IN CustId int,
  OUT ShippingDaysInfo VARCHAR(80))
  BEGIN
    DECLARE country_info varchar(255);
    select country into country_info from customers
    where customerNumber = CustId;
    CASE country_info
    WHEN "USA" THEN
      SET ShippingDaysInfo = "Five Days";
    WHEN "Australia" THEN
      SET ShippingDaysInfo = "Three Days";
    WHEN "Singapore" THEN
      SET ShippingDaysInfo = "One Day";
    ELSE
      SET ShippingDaysInfo = "No Shipping Details";
    END CASE;
  END $$
DELIMITER ;
set @shipping_info=""; call  getCustomerShippingDetails(471, @shipping_info);
mysql> select @shipping_info;
+----------------+
| @shipping_info |
+----------------+
| Three Days     |
+----------------+
1 row in set (0.00 sec)
```
