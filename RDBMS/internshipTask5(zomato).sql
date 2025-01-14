create database zomato;
use zomato;

create table restaurants(
	restaurantID int primary key,
    name varchar(100),
    city varchar(50),
    cuisinetype varchar(100),
    rating decimal,
    avgcostfortwo int
);

create table customers(
	customerID int primary key,
    firstname varchar(50),
    lastname varchar(50),
    phone varchar(20),
    city varchar(50),
    joindate datetime
);

create table orders(
	orderID int primary key,
    customerID int,
    restaurantID int,
    orderdate datetime,
    orderamount decimal,
    oredrstatus varchar(50),
    foreign key(customerID) references customers(customerID),
    foreign key(restaurantID) references restaurants(restaurantID)
);

CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY,
    customerID INT,
    restaurantID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate DATE,
    FOREIGN KEY (customerID) REFERENCES customers(customerID),
    FOREIGN KEY (restaurantID) REFERENCES restaurants(restaurantID)
);


INSERT INTO Reviews (ReviewID, Rating, Comment, ReviewDate)
VALUES
(1, 5, 'Excellent food and great service!', '2025-01-01'),
(2, 4, 'The ambiance was nice, but the food took a while.', '2025-01-03'),
(3, 3, 'Food was average and overpriced.', '2025-01-05'),
(4, 5, 'Amazing experience! Highly recommend.', '2025-01-07'),
(5, 2, 'Not satisfied. The staff was rude.', '2025-01-10');


CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    orderID INT,
    PaymentMethod VARCHAR(20),
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    FOREIGN KEY (orderID) REFERENCES orders(orderID)
);


INSERT INTO Payments (PaymentID, PaymentMethod, Amount, PaymentDate)
VALUES
(1, 'Card', 150.50, '2025-01-01'),
(2, 'Cash', 200.00, '2025-01-02'),
(3, 'Wallet', 75.00, '2025-01-03'),
(4, 'Card', 120.99, '2025-01-04'),
(5, 'Cash', 300.00, '2025-01-05');



INSERT INTO restaurants (restaurantID, name, city, cuisineType, rating, avgcostfortwo)
VALUES
(206, 'The Gourmet Spot', 'New York', 'Italian', 4.5, 50),
(207, 'Spice Heaven', 'San Francisco', 'Indian', 4.2, 40),
(208, 'Sushi World', 'Los Angeles', 'Japanese', 4.8, 60),
(209, 'Burger Bliss', 'Chicago', 'American', 4.0, 25),
(200, 'Taco Fiesta', 'Austin', 'Mexican', 4.3, 30);


INSERT INTO customers (customerID, firstName, lastName, phone, city, joindate)
VALUES
(101, 'John', 'Doe', '123-456-7890', 'New York', '2023-05-01 10:30:00'),
(102, 'Jane', 'Smith', '234-567-8901', 'Los Angeles', '2023-06-15 14:45:00'),
(103, 'Alice', 'Johnson', '345-678-9012', 'Chicago', '2023-07-20 09:00:00'),
(104, 'Bob', 'Brown', '456-789-0123', 'Houston', '2023-08-10 12:15:00'),
(105, 'Grace', 'Taylor', '567-890-1234', 'San Francisco', '2023-09-05 16:20:00');


INSERT INTO orders (orderID, customerID, restaurantID, orderdate, orderamount, oredrstatus)
VALUES
(1, 101, 201, '2025-01-01 18:30:00', 150.50, 'Completed'),
(2, 102, 202, '2025-01-02 19:45:00', 200.00, 'Pending'),
(3, 103, 203, '2025-01-03 20:00:00', 75.00, 'Completed'),
(4, 104, 204, '2025-01-04 17:15:00', 120.99, 'Cancelled'),
(5, 105, 205, '2025-01-05 21:00:00', 300.00, 'Completed');


SELECT name, city
FROM restaurants
WHERE rating >= 4.5;

SELECT c.customerID, CONCAT(c.firstname, ' ', c.lastname) AS customername, COUNT(o.orderID) AS totalorders
FROM customers c
LEFT JOIN orders o ON c.customerID = o.customerID
GROUP BY c.customerID, c.firstname, c.lastname;

SELECT name, city, cuisinetype
FROM restaurants
WHERE cuisinetype = 'Italian' AND city = 'Mumbai';

SELECT r.name AS restaurantname, SUM(o.orderamount) AS totalrevenue
FROM orders o
JOIN restaurants r ON o.restaurantID = r.restaurantID
WHERE o.oredrstatus = 'Completed'
GROUP BY r.restaurantID, r.name;

SELECT o.orderID, o.customerID, o.orderdate, o.orderamount, o.oredrstatus
FROM orders o
INNER JOIN (
    SELECT customerID, MAX(orderdate) AS latestorderdate
    FROM orders
    GROUP BY customerID
) AS recent_orders
ON o.customerID = recent_orders.customerID
AND o.orderdate = recent_orders.latestorderdate;


SELECT c.customerID, c.firstname, c.lastname
FROM customers c
LEFT JOIN orders o ON c.customerID = o.customerID
WHERE o.orderID IS NULL;


SELECT PaymentMethod, COUNT(PaymentID) AS PaymentCount
FROM Payments
GROUP BY PaymentMethod
ORDER BY PaymentCount DESC
LIMIT 1;


SELECT r.name AS restaurantname, SUM(o.orderamount) AS totalrevenue
FROM orders o
JOIN restaurants r ON o.restaurantID = r.restaurantID
WHERE o.oredrstatus = 'Completed'
GROUP BY r.restaurantID, r.name
ORDER BY totalrevenue DESC
LIMIT 5;


SELECT 
    o.orderID,
    o.orderDate,
    o.orderamount,
    c.firstname AS customerfirstname,
    c.lastname AS customerlastname,
    r.name AS restaurantname,
    o.oredrstatus
FROM orders o
JOIN customers c ON o.customerID = c.customerID
JOIN restaurants r ON o.restaurantID = r.restaurantID
WHERE o.oredrStatus = 'Cancelled';





