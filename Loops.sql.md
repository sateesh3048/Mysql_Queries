

## MySQL Loops

MySQL loop statements including WHILE, REPEAT and LOOP to run a block of code repeatedly based on a condition.

## WHILE loop

The syntax of the WHILE statement is as follows:
```mysql
WHILE expression DO
   statements
END WHILE
```

## Example code for while loop
```mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS RunCounter $$
CREATE PROCEDURE RunCounter(
IN no_of_times INT,
OUT msg VARCHAR(255))
BEGIN
   DECLARE x int DEFAULT 1;
   SET msg = '';
   WHILE (x <=  no_of_times) DO
    SET msg = concat(msg, x, ',');
    SET x = x + 1;
   END WHILE;
END $$
DELIMITER ;
call RunCounter(10, @msg);
mysql> select @msg;
+-----------------------+
| @msg                  |
+-----------------------+
| 1,2,3,4,5,6,7,8,9,10, |
+-----------------------+
```

## REPEAT loop
```mysql
REPEAT
 statements;
UNTIL expression
END REPEAT
```
## Example for Repeat loop

```mysql
DELIMITER $$
DROP PROCEDURE SumOfNumbers $$
create procedure SumOfNumbers(
  IN MaxNumber int,
  OUT Sum int)
  BEGIN
    DECLARE numVal int DEFAULT  1;
    SET Sum = 0;
    REPEAT
      SET Sum = Sum + numVal;
      SET numVal = numVal + 1;
    UNTIL numVal > 10
    END REPEAT;
  END $$
DELIMITER ;

set @sum = 0; call SumOfNumbers(12, @sum);
mysql> select @sum;
+------+
| @sum |
+------+
|   55 |
+------+
1 row in set (0.00 sec)

```

