
Definition of stored procedures
=============================== :-

A stored procedure is a group of SQL statements stored inside the database catalog. A stored procedure can be 
invoked by triggers, other stored procedures, and applications such as Ruby, Java, Python, PHP.

MySQL stored procedures advantages
================================= :-

    1) Typically stored procedures help increase the performance of the applications. Once created, stored procedures are 
    compiled and stored in the database. However, MySQL implements the stored procedures slightly different. MySQL stored procedures 
    are compiled on demand. After compiling a stored procedure, MySQL puts it into a cache. And MySQL maintains its own stored 
    procedure cache for every single connection. If an application uses a stored procedure multiple times in a 
    single connection, the compiled version is used, otherwise, the stored procedure works like a query.
    
    2) Stored procedures help reduce the traffic between application and database server because instead of sending multiple lengthy 
    SQL statements, the application has to send only name and parameters of the stored procedure.
    
    3) Stored procedures are reusable and transparent to any applications. Stored procedures expose the database interface to all 
    applications so that developers don’t have to develop functions that are already supported in stored procedures.
    
    4)Stored procedures are secure. The database administrator can grant appropriate permissions to applications that access 
    stored procedures in the database without giving any permissions on the underlying database tables.

MySQL stored procedures disadvantages
======================================

    1) If you use many stored procedures, the memory usage of every connection that is using those stored procedures will increase 
    substantially. In addition, if you overuse a large number of logical operations inside store procedures, the CPU usage will also 
    increase because the database server is not well-designed for logical operations.
    
    2) Stored procedure’s constructs are not designed for developing complex and flexible business logic.
    
    3) It is difficult to debug stored procedures. Only a few database management systems allow you to debug stored procedures. 
    Unfortunately, MySQL does not provide facilities for debugging stored procedures.
    
    4) It is not easy to develop and maintain stored procedures. Developing and maintaining stored procedures 
    are often required a specialized skill set that not all application developers possess. This may lead to problems in both 
    application development and maintenance phases.

>> Creating simple stored procedure
====================================

DELIMITER $$
 drop procedure if exists getAllPosts$$
create procedure getAllPosts()
  BEGIN
    select * from posts;
  END $$
DELIMITER ;

    1)The first command is DELIMITER // , which is not related to the stored procedure syntax. The DELIMITER statement changes 
    the standard delimiter which is semicolon ( ; ) to another. In this case, the delimiter is changed from the semicolon( ; ) 
    to double-slashes // Why do we have to change the delimiter? Because we want to pass the stored procedure to the server as a 
    whole rather than letting mysql tool interpret each statement at a time.  Following the END keyword, we use the delimiter //  
    to indicate the end of the stored procedure. The last command ( DELIMITER; ) changes the delimiter back to the semicolon (;).
    
    2) We use the "CREATE PROCEDURE"  statement to create a new stored procedure. We specify the name of stored procedure after the 
    CREATE PROCEDURE  statement. In this case, the name of the stored procedure is GetAllPosts . We put the parentheses after the 
    name of the stored procedure.
    
    3)The section between BEGIN and END  is called the body of the stored procedure. You put the declarative SQL statements in the 
    body to handle business logic. In this stored procedure, we use a simple SELECT statement to query data from the posts table.



>> Calling store proceudre
===========================

To call stored procedure we will use call method with stored procedure name.

mysql> call getAllPosts();
+----+-------------------------+----------------------------------+
| id | title                   | content                          |
+----+-------------------------+----------------------------------+
|  1 | hello                   | Hello World                      |
|  2 | hi                      | Hi Sateesh                       |
|  3 | language                | ruby lang                        |
|  4 | lang                    | rails lang                       |
|  5 | language                | mysql lang                       |
|  6 | desc                    | rubyonrails is awesome           |
|  7 | language                | ruby awesome language            |
|  8 | language                | rails awesome language           |
|  9 | language                | WebApplication awesome language  |
| 10 | language                | redis awesome language           |
| 11 | language                | Groovy awesome language          |
| 12 | tutorial                | Rails  Tutorial                  |
| 13 | tutorial                | Ruby  Tutorial                   |
| 14 | tutorial                | WebApplication  Tutorial         |
| 15 | tutorial                | Mysql  Tutorial                  |
| 16 | tutorial                | Fulltext  Tutorial               |
| 17 | language                | ruby awesome language            |
| 18 | language                | rails awesome Tutorial           |
| 19 | language                | WebApplication awesome Tutorial  |
| 20 | language                | redis awesome Tutorial           |
| 21 | language                | Groovy awesome Tutorial          |
| 22 | tutorial                | Rails language Tutorial          |
| 23 | tutorial                | Ruby language Tutorial           |
| 24 | tutorial                | WebApplication language Tutorial |
| 25 | tutorial                | Mysql language Tutorial          |
| 26 | tutorial                | Fulltext language Tutorial       |
| 27 | mysql1                  | mysql awesome tutorial           |
| 28 | mysql awesome           | mysql awesome                    |
| 29 | tutorial awesome        | tutorial is awesome              |
| 30 | training awesome        | mysql awesome training           |
| 31 | mysql tutorial training | awesome mysql tutorial training  |
| 32 | mysql training          | mysql training is good           |
| 33 | mysql tutorial          | mysql tutorial is good           |
| 34 | mysql                   | mysql is superb                  |
| 35 | rails test              | rails awesome tutorial           |
| 36 | rails test2             | awesome rails tutorial           |
| 37 | rails test3             | good tutorial on rails           |
| 38 | rails test2             | good rails tutorial              |
| 39 | rails test3             | bad tutorial on rails            |
+----+-------------------------+----------------------------------+
39 rows in set (0.00 sec)


>> Drop stored procuedure :-
===========================

To drop existing stored procedure we will use drop method

Eg: DROP PROCEDURE IF EXISTS getAllPosts;

>> List all stored procedures in all databases:-
===============================================

To list all stored procedures we will use

>> show procedure status;

Above command will list all stored procedures under all databases

*************************** 36. row ***************************
                  Db: temp_database
                Name: validate_parts
                Type: PROCEDURE
             Definer: root@localhost
            Modified: 2017-12-25 15:33:05
             Created: 2017-12-25 15:33:05
       Security_type: DEFINER
             Comment: 
character_set_client: utf8
collation_connection: utf8_general_ci
  Database Collation: latin1_swedish_ci

==>> To list all stored procedures  of specific database
======================================================

>> show procedure status where db="dummy";
  mysql> show procedure status where db="dummy" \G;
*************************** 1. row ***************************
                  Db: dummy
                Name: debug_msg
                Type: PROCEDURE
             Definer: root@localhost
            Modified: 2018-01-19 17:21:45
             Created: 2018-01-19 17:21:45
       Security_type: DEFINER
             Comment: 
character_set_client: utf8
collation_connection: utf8_general_ci
  Database Collation: latin1_swedish_ci
*************************** 2. row ***************************

==>> Show the body of the stored proecudure :-
  ==========================================
  
  mysql> show create procedure debug_msg \G;
*************************** 1. row ***************************
           Procedure: debug_msg
            sql_mode: ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
    Create Procedure: CREATE DEFINER=`root`@`localhost` PROCEDURE `debug_msg`(enabled INTEGER, msg VARCHAR(255))
BEGIN
  IF enabled THEN BEGIN
    select concat("** ", msg) AS '** DEBUG:';
  END; END IF;
END
character_set_client: utf8
collation_connection: utf8_general_ci
  Database Collation: latin1_swedish_ci
1 row in set (0.01 sec)

ERROR: 
No query specified

MySQL Stored Procedure Variables
=================================

Declaring variables
================== :-

To declare a variable inside a stored procedure, you use the DECLARE  statement as follows:

DECLARE variable_name datatype(size) DEFAULT default_value;

Let’s examine the statement above in more detail:

    1)First, you specify the variable name after the DECLARE keyword. The variable name must follow the naming rules of MySQL table column names.
    2)Second, you specify the data type of the variable and its size. A variable can have any MySQL data types such as INT, VARCHAR , and DATETIME.
    3) Third, when you declare a variable, its initial value is NULL. You can assign the variable a default value using the DEFAULTkeyword.

For example, we can declare a variable named   total_sale with the data type INT and default value 0  as follows:
DECLARE total_sale INT DEFAULT 0;

MySQL allows you to declare two or more variables that share the same data type using a single DECLARE statement as following:
DECLARE x, y INT DEFAULT 0;

We declared two integer variables  x and  y, and set their default values to zero.

DECLARE total_count INT DEFAULT 0;
SET total_count = 10;

The value of the total_count variable is 10  after the assignment.

Besides the SET  statement, you can use the SELECT INTO  statement to assign the result of a query, which returns a scalar value, to 
a variable. See the following example:

DECLARE total_products INT DEFAULT 0
 
SELECT COUNT(*) INTO total_products
FROM products


In the example above:

    First, we declare a variable named total_products  and initialize its value to 0.
    Then, we used the SELECT INTO  statement to assign the total_products  variable the number of products that we selected from the products  table in the sample database.

Variables scope

A variable has its own scope that defines its lifetime. If you declare a variable inside a stored procedure, it will be out of scope when the END statement of stored procedure reached.

====================================================================================================================================

MySQL Stored Procedure Parameters
---------------------------------  :-


Almost stored procedures that you develop require parameters. The parameters make the stored procedure more flexible and useful. 
In MySQL, a parameter has one of three modes: IN,OUT, or INOUT.

    1)IN – is the default mode. When you define an IN parameter in a stored procedure, the calling program has to pass an argument to 
    the stored procedure. In addition, the value of an IN parameter is protected. It means that even the value of the IN parameter is 
    changed inside the stored procedure, its original value is retained after the stored procedure ends. In other words, the stored 
    procedure only works on the copy of the IN parameter.
    
    2)OUT – the value of an OUT parameter can be changed inside the stored procedure and its new value is passed back to the 
    calling program. Notice that the stored procedure cannot access the initial value of the OUT parameter when it starts.
    
    3)INOUT – an INOUT  parameter is the combination of IN  and OUT  parameters. It means that the calling program may pass the 
    argument, and the stored procedure can modify the INOUT parameter and pass the new value back to the calling program.

The syntax of defining a parameter in the stored procedures is as follows:
MODE param_name param_type(param_size)

    The MODE could be IN , OUT,,or INOUT , depending on the purpose of the parameter in the stored procedure.
    The param_name is the name of the parameter. The name of the parameter must follow the naming rules of the column name in MySQL.
    Followed the parameter name is its data type and size. Like a variable, the data type of the parameter can be any valid MySQL data type.

>> Creating stored proceudre which accepts in parameter as content word
=======================================================================

delimiter $$
drop procedure if exists getPostsByContent$$
create procedure getPostsByContent(in content_word varchar(255))
  begin 
    select content, match(content) against(concat_ws("",'+',content_word) in boolean mode) as rank from posts where  match(content) against(concat_ws("",'+',content_word) in boolean mode) order by rank desc;
  end $$
delimiter ;

>> Calling stored procedure with given word

mysql> call getPostsByContent('awesome');
+---------------------------------+---------------------+
| content                         | rank                |
+---------------------------------+---------------------+
| rubyonrails is awesome          | 0.11275633424520493 |
| ruby awesome language           | 0.11275633424520493 |
| rails awesome language          | 0.11275633424520493 |
| WebApplication awesome language | 0.11275633424520493 |
| redis awesome language          | 0.11275633424520493 |
| Groovy awesome language         | 0.11275633424520493 |
| ruby awesome language           | 0.11275633424520493 |
| rails awesome Tutorial          | 0.11275633424520493 |
| WebApplication awesome Tutorial | 0.11275633424520493 |
| redis awesome Tutorial          | 0.11275633424520493 |
| Groovy awesome Tutorial         | 0.11275633424520493 |
| mysql awesome tutorial          | 0.11275633424520493 |
| mysql awesome                   | 0.11275633424520493 |
| tutorial is awesome             | 0.11275633424520493 |
| mysql awesome training          | 0.11275633424520493 |
| awesome mysql tutorial training | 0.11275633424520493 |
| rails awesome tutorial          | 0.11275633424520493 |
| awesome rails tutorial          | 0.11275633424520493 |
+---------------------------------+---------------------+
18 rows in set (0.00 sec)

>> Creating a stored procedure which accpets in, inout parameter
================================================================

DELIMITER $$
create procedure increment_counter(INOUT counter int, IN increment integer)
  begin
    set counter = counter + increment;
  end $$
DELIMITER ;
mysql> set @counter = 5;
Query OK, 0 rows affected (0.00 sec)

mysql> 
mysql> call increment_counter(@counter, 2);
Query OK, 0 rows affected (0.00 sec)

mysql> select @counter;
+----------+
| @counter |
+----------+
|        7 |
+----------+
1 row in set (0.00 sec)

mysql> 
mysql> call increment_counter(@counter, 3);
Query OK, 0 rows affected (0.00 sec)

mysql> select @counter;
+----------+
| @counter |
+----------+
|       10 |
+----------+
1 row in set (0.00 sec)

mysql> call increment_counter(@counter, -10);
Query OK, 0 rows affected (0.00 sec)

mysql> select @counter;
+----------+
| @counter |
+----------+
|        0 |
+----------+
1 row in set (0.00 sec)





