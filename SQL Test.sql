#CREATE DATABASE mysqltest;

#1 Write a SQL query which will sort out the customer and their grade who made an order. Every customer must have a grade and be served by at least one seller, who belongs to a region.

SELECT customer.cust_name AS "Customer",
customer.grade AS "Grade",orders.ord_no AS "Order No."
FROM orders, salesman, customer
WHERE orders.customer_id = customer.ï»¿custemor_id
AND orders.salesman_id = salesman.salesman_id
AND salesman.city IS NOT NULL
AND customer.grade IS NOT NULL;

#2 Write a query for extracting the data from the order table for the salesman who earned the maximum commission.

SELECT * FROM orders WHERE salesman_id IN
(SELECT salesman_id FROM salesman WHERE commision = (SELECT MAX(commision) FROM salesman));

#3 From orders retrieve only ord_no, purch_amt, ord_date, ord_date, salesman_id where salesman’s city is Nagpur(Note salesman_id of orderstable must be other than the list within the IN operator.)

SELECT ord_no, purch_amt, ord_date, salesman_id
FROM orders
WHERE salesman_id IN (SELECT salesman_id FROM salesman WHERE city='nagpur');

#4 Write a query to create a report with the order date in such a way that the latest order date will come last along with the total purchase amount and the total commission for that date is (15 % for all sellers).

SELECT ord_date, SUM(purch_amt), 
SUM(purch_amt)*.15 
FROM orders 
GROUP BY ord_date 
ORDER BY ord_date;

#5 Retrieve ord_no, purch_amt, ord_date, ord_date, salesman_id from Orders table and display only those sellers whose purch_amt is greater than average purch_amt.

SELECT ord_no, purch_amt, ord_date, salesman_id FROM orders
WHERE purch_amt >(SELECT  AVG(purch_amt) FROM orders);

#6 Write a query to determine the Nth (Say N=5) highest purch_amt from Orders table.

SELECT purch_amt FROM orders ORDER BY purch_amt DESC LIMIT 4, 1;

#7 What are Entities and Relationships?
/*
Entity:
 An entity can be a real-world object, either tangible or intangible,
that can be easily identifiable. For example, in a college database,
students, professors, workers, departments, and projects can be
referred to as entities. Each entity has some associated properties
that provide it an identity.

Relationships:
Relations or links between entities that have something to do with each other.
For example - The employees table in a company's database can be associated with
the salary table in the same database.
*/

#8 Print customer_id, account_number and balance_amount, condition that if balance_amount is nil then assign transaction_amount for account_type = "Credit Card"

SELECT customer_id , bank_account_details.account_number, CASE WHEN ifnull(balance_amount,0) = 0 THEN Transaction_amount ELSE balance_amount END AS balance_amount
FROM bank_account_details INNER JOIN bank_account_transaction ON bank_account_details.account_number = bank_account_transaction.account_number
AND account_type = "Credit Card";

#9 Print customer_id, account_number, balance_amount, conPrint account_number, balance_amount, transaction_amount from Bank_Account_Details and bank_account_transaction for all the transactions occurred during march, 2020 and april, 2020.

SELECT bank_account_details.account_number, balance_amount, transaction_amount
FROM bank_account_details INNER JOIN bank_account_transaction ON bank_account_details.account_number = bank_account_transaction.account_number
AND (date_format(Transaction_Date , '%Y-%m')  BETWEEN "2020-03" AND "2020-04");

#10 Print all of the customer id, account number, balance_amount,transaction_amount from bank_cutomer, bank_account_details and bank_account_transactions tables where excluding all of their transactions in march, 2020 month 

SELECT bank_account_details.customer_id, bank_account_details.account_number, balance_amount, transaction_amount
FROM bank_account_details LEFT JOIN bank_account_transaction ON bank_account_details.account_number = bank_account_transaction.account_number
LEFT JOIN bank_customer ON bank_account_details.customer_id = bank_customer.customer_id
AND NOT ( date_format(Transaction_Date , '%Y-%m') = "2020-03" );