create database retail;
use retail;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    join_date DATE
);


INSERT INTO Customers (customer_id, first_name, last_name, email, phone, address, join_date) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Elm Street, Springfield', '2023-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Oak Avenue, Springfield', '2023-02-20'),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '555-123-4567', '789 Maple Drive, Springfield', '2023-03-05'),
(4, 'Bob', 'Brown', 'bob.brown@example.com', '444-555-6666', '321 Pine Lane, Springfield', '2023-04-10'),
(5, 'Charlie', 'Davis', 'charlie.davis@example.com', '222-333-4444', '654 Birch Road, Springfield', '2023-05-25'),
(6, 'Diana', 'Evans', 'diana.evans@example.com', '111-222-3333', '987 Cedar Street, Springfield', '2023-06-15'),
(7, 'Eve', 'Harris', 'eve.harris@example.com', '666-777-8888', '321 Walnut Avenue, Springfield', '2023-07-20'),
(8, 'Frank', 'Garcia', 'frank.garcia@example.com', '999-888-7777', '123 Cherry Boulevard, Springfield', '2023-08-30'),
(9, 'Grace', 'Lee', 'grace.lee@example.com', '333-222-1111', '456 Willow Court, Springfield', '2023-09-10');


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

INSERT INTO Products (product_id, product_name, category, price, stock_quantity)
VALUES
(1, 'Laptop', 'Electronics', 999.99, 50),
(2, 'Smartphone', 'Electronics', 599.99, 200),
(3, 'Coffee Maker', 'Appliances', 49.99, 100),
(4, 'Desk Chair', 'Furniture', 89.99, 75),
(5, 'Washing Machine', 'Appliances', 399.99, 30),
(6, 'Bluetooth Speaker', 'Electronics', 29.99, 150),
(7, 'Running Shoes', 'Footwear', 79.99, 120),
(8, 'Backpack', 'Accessories', 39.99, 80),
(9, 'Smartwatch', 'Electronics', 199.99, 60);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id, order_date, total_amount, order_status)
VALUES
(1,  '2025-01-01', 259.99, 'Shipped'),
(2,  '2025-01-02', 599.95, 'Pending'),
(3,  '2025-01-03', 129.90, 'Shipped'),
(4,  '2025-01-04', 349.99, 'Pending'),
(5,  '2025-01-05', 99.99, 'Delivered'),
(6,  '2025-01-06', 79.98, 'Shipped'),
(7,  '2025-01-07', 239.99, 'Pending'),
(8,  '2025-01-08', 159.97, 'Delivered'),
(9,  '2025-01-09', 79.99, 'Shipped');


CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 1, 999.99),
(2, 1, 3, 2, 49.99),
(3, 2, 2, 1, 599.99),
(4, 2, 4, 2, 89.99),
(5, 3, 5, 1, 399.99),
(6, 3, 7, 3, 79.99),
(7, 4, 8, 1, 39.99),
(8, 5, 6, 2, 29.99),
(9, 6, 9, 1, 199.99);


CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_amount DECIMAL(10, 2),
    payment_method VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Payments (payment_id, order_id, payment_date, payment_amount, payment_method)
VALUES
(1, 1, '2025-01-01', 259.99, 'Credit Card'),
(2, 2, '2025-01-02', 599.95, 'PayPal'),
(3, 3, '2025-01-03', 129.90, 'Credit Card'),
(4, 4, '2025-01-04', 349.99, 'Credit Card'),
(5, 5, '2025-01-05', 99.99, 'PayPal'),
(6, 6, '2025-01-06', 79.98, 'Credit Card'),
(7, 7, '2025-01-07', 239.99, 'PayPal'),
(8, 8, '2025-01-08', 159.97, 'Credit Card'),
(9, 9, '2025-01-09', 79.99, 'PayPal');



SELECT customer_id, COUNT(order_id) AS total_orders
FROM Orders
GROUP BY customer_id;

SELECT p.product_id, p.product_name, SUM(od.quantity * od.unit_price) AS total_sales_amount
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_id, p.product_name;


SELECT p.product_id, p.product_name, MAX(od.unit_price) AS max_price
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY max_price DESC
LIMIT 1;


SELECT DISTINCT o.customer_id
FROM Orders o
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;


SELECT o.customer_id, SUM(p.payment_amount) AS total_paid
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
GROUP BY o.customer_id;


SELECT p.category, SUM(od.quantity) AS total_products_sold
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.category;


SELECT * FROM Orders
WHERE order_status = 'Pending';


SELECT SUM(total_amount) / COUNT(order_id) AS average_order_value
FROM Orders;


SELECT o.customer_id, SUM(p.payment_amount) AS total_spent
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 5;


SELECT p.product_id, p.product_name
FROM Products p
LEFT JOIN OrderDetails od ON p.product_id = od.product_id
WHERE od.product_id IS NULL;










