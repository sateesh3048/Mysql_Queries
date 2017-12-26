

Enum Data Type :-
=================


In MySQL, an ENUM is a string object whose value is chosen from a "list of permitted values defined at the time of column creation".

The ENUM data type provides the following advantages:

    1) Compact data storage. MySQL ENUM uses numeric indexes (1, 2, 3, …) to represents string values.
    2) Readable queries and output.
    
Important Note :- 
==============
Only use ENUMs when you do not expect your set of members to change once defined. Otherwise, lookup tables are much easier to 
update and modify.

To define an ENUM column, you use the following syntax:



CREATE TABLE table_name (
    ...
    col ENUM ('value1','value2','value3'),
    ...
);
    

Example:-

create table bugs(
id int(11) unsigned not null auto_increment primary key,
name varchar(225),
description text,
priority enum('Low', "Medium", "High") not null) # Defining enum column with Low, Medium, High Values;
);

The priority column will accept only three values Low, Medium and High. Behind the scenes, MySQL maps each enumeration member 
to a numeric index. In this case, Low, Medium, and High are map to 1, 2 and 3 respectively.

Inserting enum types :-
====================

To insert the data for enum column we can use either string value or interger index.
Eg:
insert into bugs(name, description, priority) values
("bug1", "bug1 desc", "Medium"),  # Here I am sending priority as string
("Bug 2", "bug 2", 3); # Here I am sedning priority as integer index i.e 3 will be pointed to "High"

Note: if the priority column is having not  null constraing and if you not sending any value for prioirty by default it will first value as default value.

insert into bugs(name) values ("Bug4"); # => It will pick "low" as priority since that is first value.

Querying Enum Values :-
======================
We can query enum value either by using string value or index value.

Eg:
mysql> select  * from bugs where priority = "High";
+----+------+-------------+----------+
| id | name | description | priority |
+----+------+-------------+----------+
|  3 | B3   | Bug3        | high     |
+----+------+-------------+----------+
1 row in set (0.00 sec)

mysql> select  * from bugs where priority = 3;
+----+------+-------------+----------+
| id | name | description | priority |
+----+------+-------------+----------+
|  3 | B3   | Bug3        | high     |
+----+------+-------------+----------+
1 row in set (0.00 sec)

MySQL ENUM disadvantages
======================== :-

1) Changing the existing enumeration members requires rebuilding the entire table using the ALTER TABLE statement, 
which is expensive in terms of resources and time.


2) Porting to other RDBMS could be an issue because ENUM is not SQL-standard and not many database system support it.


