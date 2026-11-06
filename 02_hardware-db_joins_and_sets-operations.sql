/* Exercise 1 - Multi-Table Revenue Analysis
GOAL - Test connecting 3 related tables (sales, customers, products) combined with aggregate functions and filters

- Returning each customer's customer_name, city and the total amount spent (qty x price)*/
SELECT 
	c.customer_name,
	c.city,
	SUM (p.price*s.quantity) as total_amount_spent
FROM customers AS c
LEFT JOIN sales AS s
	INNER JOIN products AS p
	ON s.product_id = p.product_id
ON c.customer_id = s.customer_id

-- WHERE clause ie to only include sales made in 2026
WHERE sale_date >= '2026-01-01' AND
		sale_date < '2027-01-01'
-- Grouping the result by customer & city and to order the final output from highest to lowest spender
GROUP BY customer_name, city
ORDER BY total_amount_spent DESC;


/* Exercise 2 - Auditing Unsold Inventory
GOAL - Test identifying missing/unmatched relationships between tables

Task: The inventory team wants to know which products in the catalog have never been sold.
ie to find product details (product_id, product_name, category) where there is no corresponding record in the sales table.
*/
SELECT 
	p.product_id,
	p.product_name,
	p.category
FROM products AS p
LEFT JOIN sales AS s
ON p.product_id = s.product_id
WHERE s.product_id IS NULL;


/* Exercise 3 - Full Customer Audit
Goal: Stretch your understanding of complete relational overlap using FULL OUTER JOIN.

Task - to help customer success team map activity across sales and customer service so as to:
identify which customers bought products but raised no tickets, and which tickets exist without a registered customer.
*/

SELECT
	c.customer_id,
	c.customer_name,
	t.ticket_id,
	t.issue_type
FROM customers AS c
FULL JOIN support_tickets AS t
ON c.customer_id = t.customer_id
WHERE	c.customer_id IS NULL 
		OR t.customer_id IS NULL;


/* Exercise 4 - Combining Data Streams
Goal: Test stacking data vertically across queries using Set Operators.

Task - create :*/

-- a single unified list of all cities represented across the business
SELECT DISTINCT city
FROM customers;

-- a query that extracts city from customers, 
-- then using a Set Operator to combine it with a list of cities where customer support tickets were raised

-- 1. using UNION
SELECT DISTINCT city
FROM customers

UNION

SELECT c.city
FROM customers AS c
INNER JOIN support_tickets AS t
ON c.customer_id = t.customer_id;

-- 2. using UNION ALL
SELECT DISTINCT city
FROM customers

UNION ALL

SELECT c.city
FROM customers AS c
INNER JOIN support_tickets AS t
ON c.customer_id = t.customer_id;


/* Exercise 5 - Finding Dormant Customers
Goal: Test Set operators vs Anti-joins for business logic.

Task - Get the list of customer ids for customers who signed up but have never placed a single order:*/
-- solved using EXCEPT set operator
SELECT customer_id
FROM customers

EXCEPT

SELECT customer_id
FROM sales

-- solved using Anti-joins
SELECT c.customer_id, c.customer_name, c.city
FROM customers AS c 
LEFT JOIN sales AS s
ON c.customer_id = s.customer_id
WHERE s.customer_id IS NULL;


