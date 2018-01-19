
MySQL supports indexing and re-indexing data automatically for a full-text search enabled column. MySQL version 
5.6 or later allows you to define a full-text index for a column whose data type is CHAR, VARCHAR or TEXT in MyISAM or InnoDB table type.

MySQL allows you to define the FULLTEXT index by using the CREATE TABLE statement when you create the table or ALTER TABLE or CREATE 
INDEX statement for the existing tables.

Defining FULLTEXT index using CREATE TABLE statement

Typically, you define the FULLTEXT index for a column when you create a new table using the CREATE TABLE statement as follows:
CREATE TABLE table_name(
	column1 data_type,	
        column2 data_type,
        column3 data_type,
	…
PRIMARY_KEY(key_column),
FULLTEXT (column1,column2,..)
);

Eg: 
CREATE TABLE posts (
  id int(4) NOT NULL AUTO_INCREMENT,
  title varchar(255) NOT NULL,
  post_content text,
  PRIMARY KEY (id),
  FULLTEXT KEY post_content (post_content)
);

> Defining FULLTEXT index for existing tables
==============================================

In case you already have existing tables and want to define full-text indexes, you can use the ALTER TABLE statement or CREATE INDEX 
statement.

> Defining FULLTEXT index using ALTER TABLE statement
------------------------------------------------------

The following syntax defines a FULLTEXT index using the ALTER TABLE statement:
ALTER TABLE  table_name  
ADD FULLTEXT(column_name1, column_name2,…);

For example, you can define a FULLTEXT index for the productDescription and productLine columns in the products table of the sample database as follows:
ALTER TABLE products  
ADD FULLTEXT(productDescription,productLine)

Defining FULLTEXT index using CREATE INDEX statement
------------------------------------------------------

You can also use the CREATE INDEX statement to create a FULLTEXT index for existing tables. See the following syntax:
CREATE FULLTEXT INDEX index_name
ON table_name(idx_column_name,...)

The following statement creates a FULLTEXT index for the addressLine1 and addressLine2 columns of the offices table.
CREATE FULLTEXT INDEX address
ON offices(addressLine1,addressLine2)

*Removing full-text search columns*
================================= :-

To remove a FULLTEXT index, you just delete the index using the ALTER TABLE … DROP INDEX statement. For example, the following statement removes the address FULLTEXT index in the offices table:
ALTER TABLE offices
DROP INDEX address;
