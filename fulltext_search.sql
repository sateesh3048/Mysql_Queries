
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


Introduction to MySQL natural language full-text searches
========================================================= :-


To perform natural language full-text searches, you use MATCH()  and  AGAINST() functions. The MATCH()  function specifies the 
column where you want to search and the AGAINST()  function determines the search expression to be used.

Example:-

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `post_content` (`content`),
  FULLTEXT KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'hello','Hello World'),(2,'hi','Hi Sateesh'),(3,'language','ruby lang'),(4,'lang','rails lang'),(5,'language','mysql lang'),(6,'desc','rubyonrails is awesome'),(7,'language','ruby awesome language'),(8,'language','rails awesome language'),(9,'language','WebApplication awesome language'),(10,'language','redis awesome language'),(11,'language','Groovy awesome language'),(12,'tutorial','Rails  Tutorial'),(13,'tutorial','Ruby  Tutorial'),(14,'tutorial','WebApplication  Tutorial'),(15,'tutorial','Mysql  Tutorial'),(16,'tutorial','Fulltext  Tutorial'),(17,'language','ruby awesome language'),(18,'language','rails awesome Tutorial'),(19,'language','WebApplication awesome Tutorial'),(20,'language','redis awesome Tutorial'),(21,'language','Groovy awesome Tutorial'),(22,'tutorial','Rails language Tutorial'),(23,'tutorial','Ruby language Tutorial'),(24,'tutorial','WebApplication language Tutorial'),(25,'tutorial','Mysql language Tutorial'),(26,'tutorial','Fulltext language Tutorial'),(27,'mysql1','mysql awesome tutorial'),(28,'mysql awesome','mysql awesome'),(29,'tutorial awesome','tutorial is awesome'),(30,'training awesome','mysql awesome training'),(31,'mysql tutorial training','awesome mysql tutorial training'),(32,'mysql training','mysql training is good'),(33,'mysql tutorial','mysql tutorial is good'),(34,'mysql','mysql is superb'),(35,'rails test','rails awesome tutorial'),(36,'rails test2','awesome rails tutorial'),(37,'rails test3','good tutorial on rails'),(38,'rails test2','good rails tutorial'),(39,'rails test3','bad tutorial on rails');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;


MySQL natural language full-text search example
==============================================

> To get all the posts which contains 'awesome' as content we can use below query

mysql> select content from posts where match(content) against('awesome');
+---------------------------------+
| content                         |
+---------------------------------+
| rubyonrails is awesome          |
| ruby awesome language           |
| rails awesome language          |
| WebApplication awesome language |
| redis awesome language          |
| Groovy awesome language         |
| ruby awesome language           |
| rails awesome Tutorial          |
| WebApplication awesome Tutorial |
| redis awesome Tutorial          |
| Groovy awesome Tutorial         |
| mysql awesome tutorial          |
| mysql awesome                   |
| tutorial is awesome             |
| mysql awesome training          |
| awesome mysql tutorial training |
| rails awesome tutorial          |
| awesome rails tutorial          |
+---------------------------------+
18 rows in set (0.00 sec)

> To get all posts which contains 'awesome' or 'Hello' we will use below query

mysql> select content from posts where match(content) against('awesome, Hello');
+---------------------------------+
| content                         |
+---------------------------------+
| Hello World                     |
| rubyonrails is awesome          |
| ruby awesome language           |
| rails awesome language          |
| WebApplication awesome language |
| redis awesome language          |
| Groovy awesome language         |
| ruby awesome language           |
| rails awesome Tutorial          |
| WebApplication awesome Tutorial |
| redis awesome Tutorial          |
| Groovy awesome Tutorial         |
| mysql awesome tutorial          |
| mysql awesome                   |
| tutorial is awesome             |
| mysql awesome training          |
| awesome mysql tutorial training |
| rails awesome tutorial          |
| awesome rails tutorial          |
+---------------------------------+
19 rows in set (0.00 sec)

There are some important points you should remember when using the full-text search:

    1) The minimum length of the search term defined in MySQL full-text search engine is 4. It means that if you search for 
    the keyword whose length is less than 4 e.g., car, cat, etc., you will not get any results.
    2)Stop words are ignored. MySQL defines a list of stop words in the MySQL source code distribution storage/myisam/ft_static.c
