### Lesson 2 - SQL Joins

### Why split data in separate table

/*
Database Normalization
When creating a database, it is really important to think about how data will be stored. This is known as normalization, and it is a huge part of most SQL classes. If you are in charge of setting up a new database, it is important to have a thorough understanding of database normalization.

There are essentially three ideas that are aimed at database normalization:

Are the tables storing logical groupings of the data?
Can I make changes in a single location, rather than in many tables for the same information?
Can I access and manipulate data quickly and efficiently?
This is discussed in detail here.

However, most analysts are working with a database that was already set up with the necessary properties in place. As analysts of data, you don't really need to think too much about data normalization. You just need to be able to pull the data from the database, so you can start making insights. This will be our focus in this lesson.
*/

### Joins
/*
We use ON clause to specify a JOIN condition which is a logical statement to combine the table in FROM and JOIN statements.
*/
SELECT *
FROM orders
JOIN accounts
ON orders.account_id = account.id;
/*
As we've learned, the SELECT clause indicates which column(s) of data you'd like to see in the output (For Example, orders.* gives us all the columns in orders table in the output). The FROM clause indicates the first table from which we're pulling data, and the JOIN indicates the second table. The ON clause specifies the column on which you'd like to merge the two tables together
*/

/*
Try pulling all the data from the accounts table, and all the data from the orders table.
*/
SELECT accounts.*, orders.*
FROM accounts
JOIN orders
ON orders.accounts_id = accounts.id;


/*
Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
*/
SELECT accounts.website, accounts.primary_poc, orders.standard_qty, orders.gloss_qty, orders.poster_qty
FROM accounts
JOIN orders
ON orders.account_id = accounts.id

/*
 PK is associated with the first column in every table. The PK here stands for primary key.
 A primary key exists in every table, and it is a column that has a unique value for every row.
 */

 /*
 Primary Key (PK)
A primary key is a unique column in a particular table. This is the first column in each of our tables. Here, those columns are all called id, but that doesn't necessarily have to be the name. It is common that the primary key is the first column in our tables in most databases.

Foreign Key (FK)
A foreign key is a column in one table that is a primary key in a different table. We can see in the Parch & Posey ERD that the foreign keys are:

region_id
account_id
sales_rep_id
Each of these is linked to the primary key of another table. An example is shown in the image below:


Primary - Foreign Key Link
In the above image you can see that:

The region_id is the foreign key.
The region_id is linked to id - this is the primary-foreign key link that connects these two tables.
The crow's foot shows that the FK can actually appear in many rows in the sales_reps table.
While the single line is telling us that the PK shows that id appears only once per row in this table.
If you look through the rest of the database, you will notice this is always the case for a primary-foreign key relationship. In the next concept, you can make sure you have this down!
*/

### Join all three of these tables


SELECT *
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id


### SELECT

/*
lternatively, we can create a SELECT statement that could pull specific columns from any of the three tables.
Again, our JOIN holds a table, and ON is a link for our PK to equal the FK.

To pull specific columns, the SELECT statement will need to specify the table that you are wishing to pull the column from, as well as the column name.
We could pull only three columns in the above by changing the select statement to the below, but maintaining the rest of the JOIN information:
*/

SELECT web_events.channel, accounts.name, orders.total


### ALIAS



### Other JOIN Notes


/*
INNER JOINs
Notice every JOIN we have done up to this point has been an INNER JOIN. That is, we have always pulled rows only if they exist as a match across two tables.

Our new JOINs allow us to pull rows that might only exist in one of the two tables. This will introduce a new data type called NULL. This data type will be discussed in detail in the next lesson.

Quick Note
You might see the SQL syntax of
*/


LEFT OUTER JOIN
OR

RIGHT OUTER JOIN


/*
These are the exact same commands as the LEFT JOIN and RIGHT JOIN we learned about in the previous video.

OUTER JOINS
The last type of join is a full outer join. This will return the inner join result set, as well as any unmatched rows from either of the two tables being joined.

Again this returns rows that do not match one another from the two tables. The use cases for a full outer join are very rare.

You can see examples of outer joins at the link here and a description of the rare use cases here. We will not spend time on these given the few instances you might need to use them.

Similar to the above, you might see the language FULL OUTER JOIN, which is the same as OUTER JOIN.
*/


### JOINs and Filtering


SELECT o.*
        a.*
FROM orders AS o
LEFT JOIN accounts AS a
ON o.account_id = a.id
WHERE a.sales_rep_id = 214502
/*
A simple rule to remember this is that, when the database executes this query,
it executes the join and everything in the ON clause first.
Think of this as building the new result set. That result set is then filtered using the WHERE clause.

The fact that this example is a left join is important.
Because inner joins only return the rows for which the two tables match,
moving this filter to the ON clause of an inner join will produce the same result as keeping it in the WHERE clause.
*/


/*
Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for the Midwest region. Your final table should include three columns:
the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
*/
SELECT r.name region, s.name rep, a.name account
FROM sales_reps AS s
JOIN region AS r
ON s.region_id = r.id
JOIN accounts AS a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name ASC;

/*
Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for accounts where the sales rep has a first name starting with S and in the Midwest region.
Your final table should include three columns: the region name, the sales rep name, and the account name.
Sort the accounts alphabetically (A-Z) according to account name.
*/
SELECT r.name region, s.name rep, a.name account
FROM sales_reps AS s
JOIN region AS r
ON s.region_id = r.id
JOIN accounts AS a
ON s.id = a.sales_rep_id
WHERE s.name LIKE 'S%'
AND r.name = 'Midwest'
ORDER BY a.name ASC;


/*
Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for accounts where the sales rep has a last name starting with K and in the Midwest region.
Your final table should include three columns: the region name, the sales rep name, and the account name.
Sort the accounts alphabetically (A-Z) according to account name.
*/
SELECT r.name region, s.name rep, a.name account
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON r.id = a.sales_rep_id
WHERE s.name LIKE 'K%'
AND r.name = 'Midwest'
ORDER BY a.name;















### Recap
Primary and Foreign Keys
You learned a key element for JOINing tables in a database has to do with primary and foreign keys:

primary keys - are unique for every row in a table. These are generally the first column in our database (like you saw with the id column for every table in the Parch & Posey database).

foreign keys - are the primary key appearing in another table, which allows the rows to be non-unique.

Choosing the set up of data in our database is very important, but not usually the job of a data analyst. This process is known as Database Normalization.

JOINs
In this lesson, you learned how to combine data from multiple tables using JOINs. The three JOIN statements you are most likely to use are:

JOIN - an INNER JOIN that only pulls data that exists in both tables.
LEFT JOIN - pulls all the data that exists in both tables, as well as all of the rows from the table in the FROM even if they do not exist in the JOIN statement.
RIGHT JOIN - pulls all the data that exists in both tables, as well as all of the rows from the table in the JOIN even if they do not exist in the FROM statement.
There are a few more advanced JOINs that we did not cover here, and they are used in very specific use cases. UNION and UNION ALL, CROSS JOIN, and the tricky SELF JOIN. These are more advanced than this course will cover, but it is useful to be aware that they exist, as they are useful in special cases.

Alias
You learned that you can alias tables and columns using AS or not using it. This allows you to be more efficient in the number of characters you need to write, while at the same time you can assure that your column headings are informative of the data in your table.

Looking Ahead
The next lesson is aimed at aggregating data. You have already learned a ton, but SQL might still feel a bit disconnected from statistics and using Excel like platforms. Aggregations will allow you to write SQL code that will allow for more complex queries, which assist in answering questions like:

Which channel generated more revenue?
Which account had an order with the most items?
Which sales_rep had the most orders? or least orders? How many orders did they have?
