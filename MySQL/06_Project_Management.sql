-- Active: 1717794070887@@127.0.0.1@3306@projectmanagement
CREATE DATABASE project_management;

USE project_management;

-- JOINING TABLES
 -- 1. All RDBMS are relational in nature, we refer to other tables to get meaningful outcomes.
 -- 2. FK are used to do reference to other table.

CREATE TABLE employee(
    id INT PRIMARY KEY,
    FirstName VARCHAR(25),
    LastName VARCHAR(25),
    age INT,
    Email_ID VARCHAR(255),
    PhoneNo VARCHAR(15),
    City VARCHAR(50)
);

INSERT INTO employee
(id,FirstName,LastName,age,Email_ID,PhoneNo,City)VALUES
(1,"Mujtaba","Mubasher",24, "mujtabamubasher11@gmail.com",
0312413346, "Lahore"),
(2,"Irtza","Mubasher",24, "Irtzamubasher11@gmail.com",
03230998448, "Karchi"),
(3,"Tanzeel","Nawaz",22, "tanzeel11@gmail.com",
03035731554, "Islamabad"),
(4,"Talal","Haider",20, "talalhaider@gmail.com",
03134788861, "kohat"),
(5,"Ahsan","Yousaf",21, "Ahsanyousaf@gmail.com",
03009411984, "faisalabad");

CREATE TABLE client (
    id INT PRIMARY KEY,
    FirstName VARCHAR(25),
    LastName VARCHAR(25),
    age INT,
    Email_ID VARCHAR(255),
    PhoneNo VARCHAR(15),
    City VARCHAR(50),
    empID INT,
    FOREIGN KEY (empID)  REFERENCES employee(id) 
      ON DELETE CASCADE
);

 INSERT INTO client VALUES
 (1,"Mac","Rogers",47,"mac@hotmail.com","+1(512)3125", "NewYork",3),
 (2,"Max","Poirier",27,"max@gmail.com","+1(512)3125", "London",3),
 (3,"Peter","Jain",24,"peter@hotmail.com","+1(512)3125", "Berline",1),
 (4,"Sami","Dewll",47,"sami@gmail.com","+1(512)3125", "Helsinki",5),
 (5,"John","Leo",47,"john@hotmail.com","+1(512)3125", "california",2);

 CREATE TABLE project(
    id INT PRIMARY KEY,
    Name VARCHAR(100),
    StatedDate DATE,
    empID INT,
    clientID INT,
    FOREIGN KEY (empID) REFERENCES employee(id),
    FOREIGN KEY (clientID) REFERENCES client(id)
 );

 INSERT INTO project VALUES
 (1,"A","2024-05-10",1,3),
 (2,"B","2024-04-20",2,1),
 (3,"C","2024-03-26",3,5),
 (4,"D","2024-01-29",3,2),
 (5,"E","2024-06-14",5,4);
 
 select *from  project;
 
-- INNER JOIN
 -- 1. Returns a resultant table that has matching values from both the tables or all the tables

-- Enlist all the employees ID's, name along with the Project Allocated to time
 
SELECT e.id, e.FirstName, e.LastName, p.Name, p.StatedDate
FROM employee as e INNER JOIN project as p ON e.id = p.empID;

SELECT *FROM employee as e INNER JOIN project as p ON e.id = p.empID;

-- Fetch out all the employee ID's, Name and their Contacts Details who have been working from Islamabad with the client Name working from London
                       
SELECT e.id, e.FirstName,e.LastName, e.Email_ID, e.PhoneNo, e.City, c.FirstName, c.LastName, c.City  FROM employee as e INNER JOIN client as c ON e.id = c.empID WHERE e.city = 'Islamabad' AND c.city = 'London';
								
                                -- OR
                                    
SELECT e.id, e.FirstName,e.LastName, e.Email_ID, e.PhoneNo, e.City, c.FirstName, c.LastName, c.City  FROM employee as e INNER JOIN client as c ON e.city = 'Islamabad' AND c.city = 'London';

-- LEFT JOIN
 -- 1. This returns a resulting table that all the data from left table and the matched data from the right table



-- Fetch out each project allocated to each employee

SELECT * FROM employee as e LEFT JOIN project as p ON e.id = p.empID;

SELECT e.id, e.FirstName,e.LastName, p.Name FROM employee as e LEFT JOIN project as p ON e.id = p.empID;

-- RIGHT JOIN
 -- 1. This returns a resulting table that all the data from right table and the matched data from the left table.


-- List out all the Projects along with the employee's name and their respective allocated email ID

SELECT p.id, p.Name, e.FirstName, e.Email_ID FROM employee as e RIGHT JOIN project as p ON p.empID = e.id;

-- CROSS JOIN
  -- 1. This returns all the cartesian products of the data present in both tables. Hence, all possible variations are reflected in the output.
  -- 2. Used rarely in practical purpose.



-- List out all the combinations possible for the employee's name and projects that can exist

SELECT  e.FirstName,e.LastName, p.Name FROM employee as e CROSS JOIN project as p;


                            -- Importent

-- Can we use JOIN without using JOIN Keyword
  -- 1. SELECT * FROM table1, table2 WHERE condition;

SELECT *FROM employee, project WHERE employee.id = project.empID;

                            -- OR

SELECT e.id, e.FirstName, e.LastName, p.Name, p.StatedDate
FROM employee as e , project as p WHERE e.id = p.empID;


 
 

 