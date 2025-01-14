create database university;
use university;

create table Departments(
department_id int primary key, department_name varchar(100)
);

insert into Departments 
values(1, 'IT'),(2,'engi'),(3,'bcom'),(4,'mba'),(5,'IT'),(6,'bcom'),(7,'mcom'),(8,'mcom'),(9,'mcom');

create table Professors(
professor_id int primary key, first_name varchar(100), last_name varchar(100), email varchar(100), phone varchar(100)
);

insert into Professors
values(101,'aryan','jain','aa@gmail.com','2547765274'),(102,'abhay','lakeja','al@gmail.com','9085274'),(103,'piyush','sahu','ps@gmail.com','250005274'),(104,'sameer','khan','sk@gmail.com','27878454'),(105,'sachin','yadav','sy@gmail.com','25477090'),(106,'dev','sharma','dev@gmail.com','1111765274'),(107,'jyoti','sharma','js@gmail.com','25098774'),(108,'ankur','jain','ak@gmail.com','2547712124'),(109,'zaid','khan','zk@gmail.com','907890274');

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    department_id INT,
    professor_id INT,
    credits INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
);

insert into Courses(course_id,course_name)
values(11,'mern'),(12,'mern'),(13,'python'),(14,'java'),(15,'backend'),(16,'python'),(17,'java'),(18,'backend'),(19,'frontend');

create table Students(student_id int primary key, first_name varchar(100), last_name varchar(100), email varchar(100), phone varchar(20), date_of_birth datetime, enrollment_date datetime, department_id int, foreign key(department_id) references Departments(department_id));

insert into Students(student_id,first_name,last_name,email,phone)
values(21,'kartik','sharma','ks@gmail.com','789056546'),(22,'vyas','sharma','vs@gmail.com','3456788'),(23,'vikas','gupta','vg@gmail.com','6789054'),(24,'vikas','verma','vv@gmail.com','123456'),(25,'jyoti','khori','jk@gmail.com','29056546'),(26,'jass','shukla','js@gmail.com','909096546'),(27,'virat','kholi','vk@gmail.com','45056546'),(28,'hardik','sharma','hs@gmail.com','78945452'),(29,'rohit','sharma','rs@gmail.com','78905656');

create table enrollments(
enrollmenr_id int primary key, student_id int, course_id int, enrollment_date datetime, grade varchar(5), foreign key(student_id) references Students(student_id), foreign key(course_id) references Courses(course_id));

insert into enrollments(enrollmenr_id, grade)
values(201,4),(202,1),(203,2),(204,4),(205,3),(206,2),(207,1),(208,3),(209,4);

SELECT 
    d.department_id,
    d.department_name,
    COUNT(s.student_id) AS total_students
FROM 
    Departments d
LEFT JOIN 
    Students s
ON 
    d.department_id = s.department_id
GROUP BY 
    d.department_id, d.department_name;
    
SELECT 
    c.course_id,
    c.course_name,
    c.credits,
    d.department_name
FROM 
    Courses c
JOIN 
    Departments d
ON 
    c.department_id = d.department_id
WHERE 
    c.professor_id = 101;
    
 SELECT 
    c.course_id,
    c.course_name,
    AVG(e.grade) AS average_grade
FROM 
    Courses c
JOIN 
    Enrollments e
ON 
    c.course_id = e.course_id
GROUP BY 
    c.course_id, c.course_name
ORDER BY 
    average_grade DESC;


show tables;

select * from students;
select * from Professors;
select * from Departments;
select * from Courses;

SELECT 
    s.student_id,
    s.first_name
FROM 
    Students s
LEFT JOIN 
    enrollments e
ON 
    s.student_id = e.student_id
WHERE 
    e.course_id IS NULL;

SELECT 
    d.department_id,
    d.department_name,
    COUNT(c.course_id) AS number_of_courses
FROM 
    Departments d
LEFT JOIN 
    Courses c
ON 
    d.department_id = c.department_id
GROUP BY 
    d.department_id, d.department_name
ORDER BY 
    number_of_courses DESC;

SELECT 
    s.student_id,
    s.first_name,
    c.course_id,
    c.course_name
FROM 
    Students s
JOIN 
    enrollments e
ON 
    s.student_id = e.student_id
JOIN 
    Courses c
ON 
    e.course_id = c.course_id
WHERE 
    c.course_name = 'python';
    
    
SELECT 
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS enrollment_count
FROM 
    Courses c
JOIN 
    enrollments e
ON 
    c.course_id = e.course_id
GROUP BY 
    c.course_id, c.course_name
ORDER BY 
    enrollment_count DESC
LIMIT 1;

SELECT 
    d.department_id,
    d.department_name,
    AVG(c.credits) AS average_credits_per_student
FROM 
    Departments d
JOIN 
    Students s
ON 
    d.department_id = s.department_id
JOIN 
    enrollments e
ON 
    s.student_id = e.student_id
JOIN 
    Courses c
ON 
    e.course_id = c.course_id
GROUP BY 
    d.department_id, d.department_name;
    
    SELECT 
    p.professor_id,
    p.first_name
FROM 
    Professors p
JOIN 
    Courses c
ON 
    p.professor_id = c.professor_id
JOIN 
    Departments d
ON 
    c.department_id = d.department_id
GROUP BY 
    p.professor_id, p.first_name
HAVING 
    COUNT(DISTINCT c.department_id) > 1;


SELECT 
    c.course_name,
    MAX(e.grade) AS highest_grade,
    MIN(e.grade) AS lowest_grade
FROM 
    Courses c
JOIN 
    enrollments e
ON 
    c.course_id = e.course_id
WHERE 
    c.course_name = 'mern'
GROUP BY 
    c.course_name;

