-- Task 7: Creating Views
-- Objective: Learn to create and use views

-- 1. Drop old tables if exist
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

-- 2. Create base tables
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  city VARCHAR(100)
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  product VARCHAR(100),
  amount DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 3. Insert sample data
INSERT INTO Customers VALUES 
(1, 'Alice', 'Hyderabad'),
(2, 'Bob', 'Delhi'),
(3, 'Charlie', 'Mumbai');

INSERT INTO Orders VALUES
(101, 1, 'Laptop', 50000),
(102, 2, 'Mobile', 15000),
(103, 1, 'Headphones', 2000),
(104, 2, 'Tablet', 12000);

-- ======================
-- VIEW DEFINITIONS
-- ======================

-- View 1: All customer orders (JOIN)
CREATE VIEW customer_orders AS
SELECT c.name, c.city, o.product, o.amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id;

-- Usage
SELECT * FROM customer_orders;

-- View 2: Customer total spending (Aggregation + Group By)
CREATE VIEW customer_spending AS
SELECT c.name, SUM(o.amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

-- Usage
SELECT * FROM customer_spending ORDER BY total_spent DESC;

-- View 3: High-value orders only (Filtered View)
CREATE VIEW high_value_orders AS
SELECT o.order_id, c.name, o.product, o.amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.amount > 20000;

-- Usage
SELECT * FROM high_value_orders;

-- ======================
-- END OF VIEWS
-- ======================
