-- challenge.sql
-- Tool used: VS Code with SQLTools (SQLite)
-- Database: bais_sqlite_lab.db
-- Validation: Each query was run and verified with sample outputs.

-- Task 1 Top 5 Customers by Total Spend

SELECT
  customers.first_name || ' ' || customers.last_name AS customer_name,
  SUM(order_items.quantity * order_items.unit_price) AS total_spend
FROM orders
JOIN customers   ON customers.id = orders.customer_id
JOIN order_items ON order_items.order_id = orders.id
GROUP BY customers.id, customers.first_name, customers.last_name
ORDER BY total_spend DESC
LIMIT 5;

-- Task 2 Total Revenue by Product Category
SELECT
  products.category,
  SUM(order_items.quantity * order_items.unit_price) AS total_revenue
FROM order_items
JOIN orders   ON orders.id = order_items.order_id
JOIN products ON products.id = order_items.product_id
GROUP BY products.category
ORDER BY total_revenue DESC;

-- Task 3 Employees Earning Above Their Department Average
WITH department_average AS (
  SELECT
    employees.department_id AS department_id,
    AVG(employees.salary)   AS avg_salary
  FROM employees
  GROUP BY employees.department_id
)
SELECT
  employees.first_name,
  employees.last_name,
  departments.name AS department_name,
  employees.salary AS employee_salary,
  ROUND(department_average.avg_salary, 2) AS department_average
FROM employees
JOIN departments        ON departments.id = employees.department_id
JOIN department_average ON department_average.department_id = employees.department_id
WHERE employees.salary > department_average.avg_salary
ORDER BY departments.name ASC, employees.salary DESC;

-- Task 4 Cities with the Most Loyal Customers
SELECT
  customers.city,
  COUNT(*) AS gold_customer_count
FROM customers
WHERE customers.loyalty_level = 'Gold'
GROUP BY customers.city
ORDER BY gold_customer_count DESC, customers.city ASC;







