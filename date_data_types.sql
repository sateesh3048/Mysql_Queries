

Datetime Datatype:-
=================

You use MySQL DATETIME to store a value that contains both date and time. When you query data from a DATETIME column, MySQL 
displays the DATETIME value in the following format:

"YYYY-MM-DD HH:MM:SS"

By default, DATETIME values range from 1000-01-01 00:00:00 to 9999-12-31 23:59:59

alter table categories add column begin_at datetime # Using datetime datatype to store begin_at value.


Timestamp datatype:-
===================

The MySQL TIMESTAMP is a temporal data type that holds the combination of date and time. The format of a TIMESTAMP column is 
YYYY-MM-DD HH:MM:SS which is fixed at 19 characters.


The TIMESTAMP value has a range from '1970-01-01 00:00:01' UTC to '2038-01-19 03:14:07' UTC.

When you insert a TIMESTAMP value into a table, MySQL converts it from your connection’s time zone to UTC for storage. When you 
query a TIMESTAMP value, MySQL converts the UTC value back to your connection’s time zone.

Example: -

create table categories(
  id int(11) unsigned not null auto_increment primary key,
  name varchar(255) not null,
  expire_at timestamp,
  created_at timestamp default current_timestamp, # Note: Here I am setting default value as current time stamp
  updated_at timestamp default current_timestamp on update current_timestamp); # it will automatically update current time stamp when record is updated
  
  NOTE: timestamp column only accept values upto 2038-01-19. if you tried to give value greater than that then it will give you incorrect date time error.

MySQL DATETIME vs. TIMESTAMP
============================ :-

1. Timestamp column can store dates between 1970 to 2038. where as datetime can store dates between 1000 to 9999. 

2. MySQL stores TIMESTAMP in UTC value. However, MySQL stores the DATETIME value as is without timezone information.

Note: If you change the timezone value then the display value of timestamp data will change so we need to be very careful 
with timestamp fields when we moving server from one timezone to different time zone.

create table ts_and_datetime(
    id int(11) unsigned not null auto_increment primary key,
    ts timestamp,
    dt datetime  )

insert into ts_and_datetime(ts, dt) values(now(),now())
    
mysql> select * from ts_and_datetime; # Compare ts value here with ts value after chaning time zone.
+----+---------------------+---------------------+
| id | ts                  | dt                  |
+----+---------------------+---------------------+
|  1 | 2017-12-26 15:14:46 | 2017-12-26 15:14:46 |
+----+---------------------+---------------------+
1 row in set (0.00 sec)

mysql> set time_zone = '+03:00';  # Note: I have changed the time zone here 
Query OK, 0 rows affected (0.00 sec)

mysql> select * from ts_and_datetime; # Observe ts value changed after changing time zone
+----+---------------------+---------------------+
| id | ts                  | dt                  |
+----+---------------------+---------------------+
|  1 | 2017-12-26 12:44:46 | 2017-12-26 15:14:46 |
+----+---------------------+---------------------+
1 row in set (0.00 sec)

MySQL DATETIME functions
========================
using now() function I am taking current date and time.
set @dt = now();

mysql> select time(@dt)
    -> ;
+-----------+
| time(@dt) |
+-----------+
| 12:57:50  |
+-----------+
1 row in set (0.00 sec)

Mysql Date() function :-
========================
We can use Date() function to get the date from date time.
mysql> select date(@dt);
+------------+
| date(@dt)  |
+------------+
| 2017-12-26 |
+------------+
1 row in set (0.00 sec)

Mysql Time() function :-
======================
we can use time() function to get time from date time.
mysql> select time(@dt);
+-----------+
| time(@dt) |
+-----------+
| 12:57:50  |
+-----------+
1 row in set (0.00 sec)


MySQL YEAR, QUARTER, MONTH, WEEK, DAY, HOUR, MINUTE and SECOND functions
========================================================================= :-
Year => To get the year from given date.
Month => To get the month from given date.
day => To get the day from given date.
Hour => To get the hour from given date.
Minute => To get the minute from given date.
Second => To get the second from given date.
Week => To get the week from given date.
Quarter => To get the quarter from given date.

mysql> select YEAR(@dt), MONTH(@dt), DAY(@dt), HOUR(@dt), MINUTE(@dt), SECOND(@dt), WEEK(@dt), Quarter(@dt);
+-----------+------------+----------+-----------+-------------+-------------+-----------+--------------+
| YEAR(@dt) | MONTH(@dt) | DAY(@dt) | HOUR(@dt) | MINUTE(@dt) | SECOND(@dt) | WEEK(@dt) | Quarter(@dt) |
+-----------+------------+----------+-----------+-------------+-------------+-----------+--------------+
|      2017 |         12 |       26 |        12 |          57 |          50 |        52 |            4 |
+-----------+------------+----------+-----------+-------------+-------------+-----------+--------------+
1 row in set (0.00 sec)

MySQL DATE_FORMAT function
==========================

We can use DATE_FORMAT() function to convert the given date into required format.

mysql> select DATE_FORMAT(@dt, "%m/%d/%y");
+------------------------------+
| DATE_FORMAT(@dt, "%m/%d/%y") |
+------------------------------+
| 12/26/17                     |
+------------------------------+
1 row in set (0.00 sec)

mysql> select DATE_FORMAT(@dt, "%m/%d/%Y");
+------------------------------+
| DATE_FORMAT(@dt, "%m/%d/%Y") |
+------------------------------+
| 12/26/2017                   |
+------------------------------+
1 row in set (0.00 sec)

mysql> select DATE_FORMAT(@dt, "%W %M %Y");
+------------------------------+
| DATE_FORMAT(@dt, "%W %M %Y") |
+------------------------------+
| Tuesday December 2017        |
+------------------------------+
1 row in set (0.00 sec)

mysql> select DATE_FORMAT(@dt, "%m/%d/%y-%h:%i:%s");
+---------------------------------------+
| DATE_FORMAT(@dt, "%m/%d/%y-%h:%i:%s") |
+---------------------------------------+
| 12/26/17-12:57:50                     |
+---------------------------------------+
1 row in set (0.00 sec)


MYSQL DATE ADD Function :-
=======================


select @dt,
date_add(@dt, interval 1 second) as 'second',
date_add(@dt, interval 1 minute) as "minute",
date_add(@dt, interval 1 hour) as "Hour",
date_add(@dt, interval 1 day) as "Day",
date_add(@dt, interval 1 month) as "Month",
date_add(@dt, interval 1 year) as "Year";

mysql> select @dt, date_add(@dt, interval 1 second) as 'second', date_add(@dt, interval 1 minute) as "minute", date_add(@dt, interval 1 hour) as "Hour", date_add(@dt, interval 1 day) as "Day", date_add(@dt, interval 1 month) as "Month", date_add(@dt, interval 1 year) as "Year" \G;
*************************** 1. row ***************************
   @dt: 2017-12-26 12:57:50
second: 2017-12-26 12:57:51
minute: 2017-12-26 12:58:50
  Hour: 2017-12-26 13:57:50
   Day: 2017-12-27 12:57:50
 Month: 2018-01-26 12:57:50
  Year: 2018-12-26 12:57:50
1 row in set (0.00 sec)


MySQL DATE_SUB function :-
========================

mysql> select @dt,
    -> date_sub(@dt, interval 1 second) as 'second',
    -> date_sub(@dt, interval 1 minute) as "minute",
    -> date_sub(@dt, interval 1 hour) as "Hour",
    -> date_sub(@dt, interval 1 day) as "Day",
    -> date_sub(@dt, interval 1 month) as "Month",
    -> date_sub(@dt, interval 1 year) as "Year" \G;
*************************** 1. row ***************************
   @dt: 2017-12-26 12:57:50
second: 2017-12-26 12:57:49
minute: 2017-12-26 12:56:50
  Hour: 2017-12-26 11:57:50
   Day: 2017-12-25 12:57:50
 Month: 2017-11-26 12:57:50
  Year: 2016-12-26 12:57:50
1 row in set (0.00 sec)

MySQL DATE_DIFF function
======================== :-

To calculate a difference in days between two DATETIME values, you use the DATEDIFF function. 
Notice that the DATEDIFF function only considers the date part of a DATETIME value in the calculation.

mysql> select datediff(@dt, "2016-01-01") as dates_difference;
+------------------+
| dates_difference |
+------------------+
|              725 |
+------------------+
1 row in set (0.00 sec)


Sql Query By using above mentioned date functions :-
=========================================================

select  

NOW() as CURRENT_DATE_TIME, # Get current Date and Time using now() function
CURDATE() as SYSTEM_DATE, # Get System Date
DATE(NOW()) as Today_DATE, # Get the current date from now() function using date() function

# Get DAY(), MONTH(), QUARTER(), YEAR() values from given date using below functions

DAY(NOW()) as day, # Get the current day using DAY() function ,
MONTH(NOW()) as current_month, # Get the current month using MONTH() function,
QUARTER(NOW()) as current_qurater, # Get the current quarter using QUARTER() function,
YEAR(NOW()) as current_year, # Get the current year using YEAR() function

# Get Week(), WeekDay(), Weekofyear() from below functions

WEEK(NOW()) as CURRENT_WEEK, # Get Current week number,
WEEKOFYEAR(NOW()) AS WEEK_OF_YEAR,
WEEKDAY(NOW()) as WEEK_DAY, # Get current day of week using WEEKDAY function, 

DATE_FORMAT(NOW(), '%m-%d-Y') as USA_DATE, # Convert givent date to mm-dd-yyyy format using DATE_FORMAT function,
DATEDIFF(NOW(), "2016-12-26") as DATES_DIFFERENCE, # Get the difference between two dates using DATEDIFF function,

# DATE ADD Function to increment dates
DATE_ADD(NOW(), INTERVAL 1 DAY) as 'One day Later', # add 1 day to current date using DATE_ADD function and INTERVAL 1 day
DATE_ADD(NOW(), INTERVAL 1 Week) as 'one week later', # Similarly Adding 1 week to current date using INTERVAL 1 week
DATE_ADD(NOW(), INTERVAL 1 MONTH) as 'One month later',

# Date subtract function to subtract dates
DATE_SUB(NOW(),  INTERVAL 1 year) as 'One year before', # Get one year before date,
DATE_SUB(NOW(), INTERVAL 1 month) as 'One month before' \G; # Get one month before date

*************************** 1. row ***************************
CURRENT_DATE_TIME: 2017-12-26 14:59:48
      SYSTEM_DATE: 2017-12-26
       Today_DATE: 2017-12-26
              day: 26
    current_month: 12
  current_qurater: 4
     current_year: 2017
     CURRENT_WEEK: 52
     WEEK_OF_YEAR: 52
         WEEK_DAY: 1
         USA_DATE: 12-26-Y
 DATES_DIFFERENCE: 365
    One day Later: 2017-12-27 14:59:48
   one week later: 2018-01-02 14:59:48
  One month later: 2018-01-26 14:59:48
  One year before: 2016-12-26 14:59:48
 One month before: 2017-11-26 14:59:48
1 row in set (0.00 sec)



