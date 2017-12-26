









timestamp datatype:-

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
