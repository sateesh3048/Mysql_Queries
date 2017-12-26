

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

  



