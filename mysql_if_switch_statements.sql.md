MySQL IF ELSEIF ELSE statement

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

