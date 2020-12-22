### LESSON 3 SQL Aggregations


### NULLs and Aggregations


/*
otice that NULLs are different than a zero - they are cells where data does not exist.

When identifying NULLs in a WHERE clause, we write IS NULL or IS NOT NULL. We don't use =, because NULL isn't considered a value in SQL. Rather, it is a property of the data.

NULLs - Expert Tip
There are two common ways in which you are likely to encounter NULLs:

NULLs frequently occur when performing a LEFT or RIGHT JOIN. You saw in the last lesson - when some rows in the left table of a left join are not matched with rows in the right table, those rows will contain some NULL values in the result set.


NULLs can also occur from simply missing data in our database.
*/
SELECT *
FROM accounts
WHERE sales_rep_id IS NULL;


SELECT *
FROM accounts
WHERE sales_rep_id IS NOT NULL;


### First Aggregation - COUNT

/*COUNT the Number of Rows in a Table
Try your hand at finding the number of rows in each table. Here is an example of finding all the rows in the accounts table.
*/
SELECT COUN(*)
FROM accounts

/*
But we could have just as easily chosen a column to drop into the aggregation function:
*/
SELECT COUNT(accounts.id)
FROM accounts;

/* Can help to identify number of NULL values in the particular column */
SELECT COUNT(*) AS account_count
FROM accounts;

/* Can help to identify number of NULL values in ID column */
SELECT COUNT(id) AS account_id_count
FROM accounts;

If the COUNT result of a column is less than the number of rows iuun the table, we know that difference is the number of NULLs.

SELECT *
FROM accounts
WHERE primary_poc IS NULL;

Notice that COUNT does not consider rows that have NULL values. Therefore, this can be useful for quickly identifying which rows have missing data.
You will learn GROUP BY in an upcoming concept, and then each of these aggregators will become much more useful.


### SUM


/*
Unlike COUNT, you can only use SUM on numeric columns. However, SUM will ignore NULL values, as do the other aggregation functions you will see in the upcoming lessons.
Aggregation Reminder
An important thing to remember: aggregators only aggregate vertically - the values of a column.
If you want to perform a calculation across rows, you would do this with simple arithmetic.
We saw this in the first lesson if you need a refresher, but the quiz in the next concept should assure you still remember how to aggregate across rows.
*/
SELECT SUM(standard_qty) AS standard,
      SUM(gloss_qty) AS gloss,
      SUM(poster_qty) AS poster
FROM orders;

You CANT use SUM(*)


/*
Find the total amount of poster_qty paper ordered in the orders table.
*/
SELECT SUM(poster_qty) AS poster
FROM orders;


/*
Find the total amount of standard_qty paper ordered in the orders table.
*/
SELECT SUM(standard_qty) AS standard
FROM orders;


/*
Find the total dollar amount of sales using the total_amt_usd in the orders table.
*/
SELECT SUM(total_amt_usd) as total_usd
FROM orders;


/*
Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table.
This should give a dollar amount for each order in the table.
*/
SELECT SUM(standard_amt_usd) + SUM(gloss_amt_usd) AS total_usd
FROM orders;

/*
Find the standard_amt_usd per unit of standard_qty paper.
Your solution should use both an aggregation and a mathematical operator.
*/
SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;


### MIN & MAX


/*
Notice that here we were simultaneously obtaining the MIN and MAX number of orders of each paper type. However, you could run each individually.

Notice that MIN and MAX are aggregators that again ignore NULL values. Check the expert tip below for a cool trick with MAX & MIN.

Expert Tip
Functionally, MIN and MAX are similar to COUNT in that they can be used on non-numerical columns.
Depending on the column type, MIN will return the lowest number, earliest date, or non-numerical value as early in the alphabet as possible.
As you might suspect, MAX does the opposite—it returns the highest number, the latest date, or the non-numerical value closest alphabetically to “Z.”
*/
SELECT MIN(standard_qty) AS standard_min,
    MAX(standard_qty) AS standard_max
FROM orders;


### AVG


/*
Similar to other software AVG returns the mean of the data - that is the sum of all of the values in the column divided by the number of values in a column.
This aggregate function again ignores the NULL values in both the numerator and the denominator.

If you want to count NULLs as zero, you will need to use SUM and COUNT. However, this is probably not a good idea if the NULL values
truly just represent unknown values for a cell.

MEDIAN - Expert Tip
One quick note that a median might be a more appropriate measure of center for this data, but finding the median happens to be a pretty difficult thing
to get using SQL alone — so difficult that finding a median is occasionally asked as an interview question.
*/
SELECT AVG(standard_qty) AS standard_qty
FROM orders


### MIN, MAX, & AVERAGE


/*
When was the earliest order ever placed? You only need to return the date.
*/
SELECT MIN(occurred_at) AS earliest_order
FROM orders;


/*
Try performing the same query as in question 1 without using an aggregation function.
*/
SELECT occurred_at
FROM orders
ORDER BY occurred_at ASC
LIMIT 1;


/*
When did the most recent (latest) web_event occur?
*/
SELECT MAX(occurred_at)
FROM web_events;


/*
Try to perform the result of the previous query without using an aggregation function.
*/
SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;


/*
Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order.
Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
*/


/*
Via the video, you might be interested in how to calculate the MEDIAN.
Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?
*/


### GROUP BY


/*
The key takeaways here:

GROUP BY can be used to aggregate data within subsets of the data. For example, grouping for different accounts, different regions, or different sales representatives.


Any column in the SELECT statement that is not within an aggregator must be in the GROUP BY clause.


The GROUP BY always goes between WHERE and ORDER BY.


ORDER BY works like SORT in spreadsheet software.

GROUP BY - Expert Tip
Before we dive deeper into aggregations using GROUP BY statements, it is worth noting that SQL evaluates the aggregations before the LIMIT clause.
If you don’t group by any columns, you’ll get a 1-row result—no problem there.
If you group by a column with enough unique values that it exceeds the LIMIT number, the aggregates will be calculated,
and then some rows will simply be omitted from the results.

This is actually a nice way to do things because you know you’re going to get the correct aggregates. 
If SQL cuts the table down to 100 rows, then performed the aggregations, your results would be substantially different.
The above query’s results exceed 100 rows, so it’s a perfect example. In the next concept, use the SQL environment
to try removing the LIMIT and running it again to see what changes.
*/
