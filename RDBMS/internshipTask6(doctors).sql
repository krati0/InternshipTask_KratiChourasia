create database doctors;
use doctors;

create table Doctors(
	doctor_id int primary key,
    first_name varchar(100),
    last_name varchar(100),
    email varchar(100),
    phone varchar(20),
    department_id int,
    specialty_id int,
    joining_date datetime,
    foreign key(department_id) references departments(department_id),
    foreign key(specialty_id) references Specialties(specialty_id)
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) 
);

CREATE TABLE Specialties (
    specialty_id INT PRIMARY KEY,
    specialty_name VARCHAR(100) 
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    date_of_birth DATE,
    gender VARCHAR(10),
    address TEXT
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    status VARCHAR(20),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    appointment_id INT,
    payment_date DATE,
    payment_amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(20),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);


INSERT INTO Departments (department_id, department_name)
 VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'Engineering'),
(4, 'Marketing'),
(5, 'Sales');


INSERT INTO Specialties (specialty_id, specialty_name) 
VALUES
(1, 'Cardiology'),
(2, 'Dermatology'),
(3, 'Pediatrics'),
(4, 'Orthopedics'),
(5, 'Neurology');


INSERT INTO Doctors (doctor_id, first_name, last_name, email, phone, department_id, specialty_id, joining_date) VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '1234567890', 3, 1, '2022-01-15 09:30:00'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '0987654321', 2, 2, '2021-07-20 10:00:00'),
(3, 'Emily', 'Clark', 'emilyclark@example.com', '5678901234', 4, 3, '2020-03-12 08:45:00'),
(4, 'Michael', 'Brown', 'michaelbrown@example.com', '2345678901', 1, 4, '2023-09-10 11:15:00'),
(5, 'Sarah', 'Johnson', 'sarahjohnson@example.com', '3456789012', 5, 5, '2022-06-05 14:00:00');


INSERT INTO Appointments (appointment_id, appointment_date, reason, status) VALUES
(1, '2025-01-10 09:00:00', 'Routine checkup', 'Completed'),
(2, '2025-01-11 10:30:00', 'Skin rash consultation', 'Scheduled'),
(3, '2025-01-12 14:15:00', 'Pediatric checkup', 'Completed'),
(4, '2025-01-13 11:45:00', 'Orthopedic follow-up', 'Cancelled'),
(5, '2025-01-14 16:00:00', 'Neurology consultation', 'Scheduled');


INSERT INTO Payments (payment_id, payment_date, payment_amount, payment_method) VALUES
(1, '2025-01-10', 500.00, 'Credit Card'),
(2, '2025-01-12', 700.00, 'Cash'),
(3, '2025-01-14', 1200.00, 'Insurance'),
(4, '2025-01-11', 300.00, 'Debit Card'),
(5, '2025-01-10', 200.00, 'Wallet');



SELECT 
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM 
    Doctors d
LEFT JOIN 
    Appointments a ON d.doctor_id = a.doctor_id
GROUP BY 
    d.doctor_id, doctor_name
ORDER BY 
    total_appointments DESC;


SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    a.appointment_date,
    a.reason,
    a.status
FROM 
    Patients p
INNER JOIN 
    Appointments a ON p.patient_id = a.patient_id
INNER JOIN 
    Doctors d ON a.doctor_id = d.doctor_id
WHERE 
    d.first_name = 'John' AND d.last_name = 'Smith'
ORDER BY 
    a.appointment_date;



SELECT 
    d.department_id,
    dep.department_name,
    COUNT(a.appointment_id) AS total_appointments
FROM 
    Appointments a
INNER JOIN 
    Doctors d ON a.doctor_id = d.doctor_id
INNER JOIN 
    Departments dep ON d.department_id = dep.department_id
WHERE 
    dep.department_name = 'Engineering' -- Replace 'Engineering' with the desired department name
GROUP BY 
    d.department_id, dep.department_name;


SELECT 
    s.specialty_id,
    s.specialty_name,
    COUNT(a.appointment_id) AS total_appointments
FROM 
    Appointments a
INNER JOIN 
    Doctors d ON a.doctor_id = d.doctor_id
INNER JOIN 
    Specialties s ON d.specialty_id = s.specialty_id
GROUP BY 
    s.specialty_id, s.specialty_name
ORDER BY 
    total_appointments DESC
LIMIT 1;


SELECT 
    SUM(p.payment_amount) AS total_payment_amount
FROM 
    Payments p
INNER JOIN 
    Appointments a ON p.appointment_id = a.appointment_id
WHERE 
    a.status = 'Completed';


SELECT 
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    COUNT(DISTINCT a.patient_id) AS total_patients
FROM 
    Doctors d
LEFT JOIN 
    Appointments a ON d.doctor_id = a.doctor_id
GROUP BY 
    d.doctor_id, doctor_name
ORDER BY 
    total_patients DESC;


SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    a.appointment_date,
    a.reason,
    a.status
FROM 
    Patients p
INNER JOIN 
    Appointments a ON p.patient_id = a.patient_id
WHERE 
    a.status = 'Cancelled'
ORDER BY 
    a.appointment_date DESC;


SELECT 
    status,
    COUNT(appointment_id) AS total_appointments
FROM 
    Appointments
GROUP BY 
    status
ORDER BY 
    total_appointments DESC;


SELECT 
    AVG(p.payment_amount) AS average_payment
FROM 
    Payments p
INNER JOIN 
    Appointments a ON p.appointment_id = a.appointment_id
WHERE 
    a.status = 'Completed';


SELECT 
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM 
    Doctors d
LEFT JOIN 
    Appointments a ON d.doctor_id = a.doctor_id
GROUP BY 
    d.doctor_id, doctor_name
ORDER BY 
    total_appointments DESC
LIMIT 1;
