create database ola;
use ola;

CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(15),
    City VARCHAR(50),
    VehicleType VARCHAR(20),
    Rating DECIMAL
);

INSERT INTO Drivers (DriverID, FirstName, LastName, Phone, City, VehicleType, Rating)
VALUES
    (1, 'John', 'Doe', '123-456-7890', 'New York', 'Sedan', 4.5),
    (2, 'Jane', 'Smith', '234-567-8901', 'Los Angeles', 'Hatchback', 3.8),
    (3, 'Bob', 'Brown', '345-678-9012', 'Chicago', 'SUV', 3.2),
    (4, 'Alice', 'Davis', '456-789-0123', 'Houston', 'Sedan', 4.7),
    (5, 'Charlie', 'Wilson', '567-890-1234', 'Phoenix', 'Hatchback', 2.3),
    (6, 'Eve', 'Taylor', '678-901-2345', 'Philadelphia', 'SUV', 4.9),
    (7, 'Frank', 'Thomas', '789-012-3456', 'San Antonio', 'Sedan', 1.1),
    (8, 'Grace', 'Lee', '890-123-4567', 'San Diego', 'Hatchback', 4.4),
    (9, 'Hank', 'White', '901-234-5678', 'Dallas', 'SUV', 4.6);
    
    select * from Drivers;
    
    
CREATE TABLE Riders (
    RiderID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(15),
    City VARCHAR(50),
    JoinDate DATE
);


INSERT INTO Riders (RiderID, FirstName, LastName, Phone, City, JoinDate)
VALUES
    (11, 'Emily', 'Johnson', '111-222-3333', 'New York', '2022-01-15'),
    (12, 'Michael', 'Smith', '222-333-4444', 'Los Angeles', '2021-03-20'),
    (13, 'Sarah', 'Brown', '333-444-5555', 'Chicago', '2023-07-10'),
    (14, 'David', 'Wilson', '444-555-6666', 'Houston', '2020-11-05'),
    (15, 'Sophia', 'Taylor', '555-666-7777', 'Phoenix', '2022-05-25'),
    (16, 'James', 'Davis', '666-777-8888', 'Philadelphia', '2023-09-12'),
    (17, 'Olivia', 'Martinez', '777-888-9999', 'San Antonio', '2021-06-18'),
    (18, 'Liam', 'Garcia', '888-999-0000', 'San Diego', '2020-02-14'),
    (19, 'Isabella', 'Lee', '999-000-1111', 'Dallas', '2022-08-30');


CREATE TABLE Rides (
    RideID INT PRIMARY KEY,
    RiderID INT,
    DriverID INT,
    RideDate DATE,
    PickupLocation VARCHAR(100),
    DropLocation VARCHAR(100),
    Distance DECIMAL(5, 2),
    Fare DECIMAL(7, 2),   
    RideStatus VARCHAR(20),
    FOREIGN KEY (RiderID) REFERENCES Riders(RiderID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);


INSERT INTO Rides (RideID, RideDate, PickupLocation, DropLocation, Distance, Fare, RideStatus)
VALUES
    (21, '2023-12-01', 'Central Park', 'Times Square', 5.0, 15.50, 'Completed'),
    (22, '2023-12-02', 'Hollywood', 'Santa Monica', 12.0, 25.00, 'Completed'),
    (23, '2023-12-03', 'Navy Pier', 'Millennium Park', 3.5, 10.00, 'Cancelled'),
    (24, '2023-12-04', 'Downtown', 'Suburbs', 20.0, 45.75, 'Completed'),
    (25, '2023-12-05', 'Airport', 'Hotel', 15.0, 30.00, 'Ongoing'),
    (26, '2023-12-06', 'Liberty Bell', 'Independence Hall', 2.0, 8.50, 'Completed'),
    (27, '2023-12-07', 'Alamo', 'Market Square', 4.5, 12.00, 'Completed'),
    (28, '2023-12-08', 'SeaWorld', 'Zoo', 8.0, 20.00, 'Completed'),
    (29, '2023-12-09', 'Downtown', 'Uptown', 10.0, 22.50, 'Cancelled');


CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    RideID INT,
    PaymentMethod VARCHAR(20),
    Amount DECIMAL(7, 2), 
    PaymentDate datetime,
    FOREIGN KEY (RideID) REFERENCES Rides(RideID)
);


INSERT INTO Payments (PaymentID, PaymentMethod, Amount, PaymentDate)
VALUES
    (01, 'Card', 15.50, '2023-12-01'),
    (02, 'Wallet', 25.00, '2023-12-02'),
    (03, 'Cash', 45.75, '2023-12-04'),
    (04, 'Card', 8.50, '2023-12-06'),
    (05, 'Wallet', 12.00, '2023-12-07'),
    (06, 'Card', 20.00, '2023-12-08'),
    (07, 'Cash', 30.00, '2023-12-05'),
    (08, 'Wallet', 22.50, '2023-12-09'),
    (09, 'Card', 10.00, '2023-12-03');
    
    
SELECT 
    FirstName,
    LastName,
    Phone,
    Rating
FROM 
    Drivers
WHERE 
    Rating >= 4.5;
    
SELECT 
    d.DriverID,
    d.FirstName,
    d.LastName,
    COUNT(r.RideID) AS TotalCompletedRides
FROM 
    Drivers d
LEFT JOIN 
    Rides r
ON 
    d.DriverID = r.DriverID
WHERE 
    r.RideStatus = 'Completed'
GROUP BY 
    d.DriverID, d.FirstName, d.LastName
ORDER BY 
    TotalCompletedRides DESC;


SELECT * FROM Rides;

SELECT 
    r.RiderID,
    r.FirstName,
    r.LastName,
    r.Phone,
    r.City
FROM 
    Riders r
LEFT JOIN 
    Rides ri
ON 
    r.RiderID = ri.RiderID
WHERE 
    ri.RideID IS NULL;

SELECT 
    d.DriverID,
    d.FirstName,
    d.LastName,
    SUM(r.Fare) AS TotalEarnings
FROM 
    Drivers d
JOIN 
    Rides r
ON 
    d.DriverID = r.DriverID
WHERE 
    r.RideStatus = 'Completed'
GROUP BY 
    d.DriverID, d.FirstName, d.LastName
ORDER BY 
    TotalEarnings DESC;
    
SELECT 
    r1.RiderID,
    r.FirstName,
    r.LastName,
    r1.RideID,
    r1.RideDate,
    r1.PickupLocation,
    r1.DropLocation,
    r1.Distance,
    r1.Fare,
    r1.RideStatus
FROM 
    Rides r1
JOIN 
    Riders r
ON 
    r1.RiderID = r.RiderID
WHERE 
    r1.RideDate = (
        SELECT 
            MAX(r2.RideDate)
        FROM 
            Rides r2
        WHERE 
            r2.RiderID = r1.RiderID
    )
ORDER BY 
    r1.RiderID;

SELECT 
    r.City,
    COUNT(ri.RideID) AS TotalRides
FROM 
    Riders r
JOIN 
    Rides ri
ON 
    r.RiderID = ri.RiderID
GROUP BY 
    r.City
ORDER BY 
    TotalRides DESC;

SELECT 
    ri.RideID,
    ri.RiderID,
    ri.DriverID,
    ri.RideDate,
    ri.PickupLocation,
    ri.DropLocation,
    ri.Distance,
    ri.Fare,
    ri.RideStatus
FROM 
    Rides ri
WHERE 
    ri.Distance > 20
ORDER BY 
    ri.Distance DESC;


SELECT 
    p.PaymentMethod,
    COUNT(p.PaymentID) AS UsageCount
FROM 
    Payments p
GROUP BY 
    p.PaymentMethod
ORDER BY 
    UsageCount DESC
LIMIT 1;


SELECT 
    d.DriverID,
    d.FirstName,
    d.LastName,
    SUM(r.Fare) AS TotalEarnings
FROM 
    Drivers d
JOIN 
    Rides r
ON 
    d.DriverID = r.DriverID
WHERE 
    r.RideStatus = 'Completed'
GROUP BY 
    d.DriverID, d.FirstName, d.LastName
ORDER BY 
    TotalEarnings DESC
LIMIT 3;

SELECT 
    r.RideID,
    r.RideDate,
    r.PickupLocation,
    r.DropLocation,
    r.Distance,
    r.Fare,
    rd.FirstName AS RiderFirstName,
    rd.LastName AS RiderLastName,
    d.FirstName AS DriverFirstName,
    d.LastName AS DriverLastName
FROM 
    Rides r
JOIN 
    Riders rd
ON 
    r.RiderID = rd.RiderID
JOIN 
    Drivers d
ON 
    r.DriverID = d.DriverID
WHERE 
    r.RideStatus = 'Cancelled'
ORDER BY 
    r.RideDate DESC;

