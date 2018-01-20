## Introduction to MySQL cursor

To handle a result set inside a stored procedure, you use a cursor. A cursor allows you to iterate a set of rows returned by a query and process each row accordingly.

## MySQL cursor is read-only, non-scrollable and asensitive.

**Read only**: you cannot update data in the underlying table through the cursor.
**Non-scrollable**: you can only fetch rows in the order determined by the SELECT statement. You cannot fetch rows in the reversed order. In addition, you cannot skip rows or jump to a specific row in the result set.
**Asensitive*: there are two kinds of cursors: asensitive cursor and insensitive cursor. An asensitive cursor points to the actual data, whereas an insensitive cursor uses a temporary copy of the data. An asensitive cursor performs faster than an insensitive cursor because it does not have to make a temporary copy of data. However, any change that made to the data from other connections will affect the data that is being used by an asensitive cursor, therefore, it is safer if you don’t update the data that is being used by an asensitive cursor. MySQL cursor is asensitive.

## Working with MySQL cursor

First, you have to declare a cursor by using the DECLARE statement:

```mysql
DECLARE cursor_name CURSOR FOR SELECT_statement;
```

The cursor declaration must be after any variable declaration. If you declare a cursor before variables declaration, MySQL will issue an error. A cursor must always be associated with a SELECT statement.

Next, you open the cursor by using the **OPEN statement**. The OPEN statement initializes the result set for the cursor, therefore, 
you must call the OPEN statement before fetching rows from the result set.
```mysql
OPEN cursor_name;
```

Then, you **use the FETCH statement to retrieve the next row** pointed by the cursor and move the cursor to the next row in the result set.
```mysql
FETCH cursor_name INTO variables list;
```

After that, you can check to see if there is any row available before fetching it.

Finally, you call the CLOSE statement to deactivate the cursor and release the memory associated with it as follows:
```mysql
CLOSE cursor_name;
```

When the cursor is no longer used, you should close it.

When working with MySQL cursor, you must also declare a NOT FOUND handler to handle the situation when the cursor could not find any row. Because each time you call the FETCH statement, the cursor attempts to read the next row in the result set. When the cursor reaches the end of the result set, it will not be able to get the data, and a condition is raised. The handler is used to handle this condition.

To declare a NOT FOUND handler, you use the following syntax:
```mysql
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
```

Where finished is a variable to indicate that the cursor has reached the end of the result set. Notice that the handler 
declaration must appear after variable and cursor declaration inside the stored procedures.

## Example for cursor program :-

```mysql
DELIMITER $$
drop procedure getEmailsList $$
create procedure getEmailsList(out email_list text)
  BEGIN
    -- variables declaration
    DECLARE v_email varchar(255) default "";
    DECLARE v_finished integer default 0;
    
    -- Cursor declaration
    DECLARE email_cursor CURSOR FOR 
    select email from employees;
    
    -- Finish handler declaration for cursor
    DECLARE CONTINUE HANDLER
       FOR NOT FOUND SET v_finished=1;
    -- open cursor   
    OPEN email_cursor;
    
    SET email_list = "";
    -- Defining loop to fetch data from cursor
    get_email: LOOP
      FETCH email_cursor INTO v_email;
      IF v_finished = 1 THEN
        LEAVE get_email;
      END IF;
      call dummy.debug_msg(1, concat("email ", v_email));
      SET email_list = CONCAT(v_email, ',',email_list);
    END LOOP get_email;
    -- closing cursor
    CLOSE email_cursor;
  END $$
DELIMITER ;
set @mail_list=""; call getEmailsList(@mail_list); select @mail_list;
| mgerard@classicmodelcars.com,ykato@classicmodelcars.com,mnishi@classicmodelcars.com,tking@classicmodelcars.com,pmarsh@classicmodelcars.com,afixter@classicmodelcars.com,bjones@classicmodelcars.com,lbott@classicmodelcars.com,pcastillo@classicmodelcars.com,ghernande@classicmodelcars.com,lbondur@classicmodelcars.com,gvanauf@classicmodelcars.com,ftseng@classicmodelcars.com,spatterson@classicmodelcars.com,jfirrelli@classicmodelcars.com,lthompson@classicmodelcars.com,ljennings@classicmodelcars.com,abow@classicmodelcars.com,gbondur@classicmodelcars.com,wpatterson@classicmodelcars.com,jfirrelli@classicmodelcars.com,mp@test.com,dmurphy@classicmodelcars.com, |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
```

