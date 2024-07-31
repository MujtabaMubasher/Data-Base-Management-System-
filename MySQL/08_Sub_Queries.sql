
USE sub_queries;

									 -- Differnet Between JOIN & Sub Queries
 -- JOIN                                                                               -- Sub Queries;
 -- Faster                                                                             -- Slower
 -- Joins maximise calculation burden on DBMS                                          -- Keeps responsibility of calculation on user
 -- Complex, difficult to understand and implement                                     -- Comparatively easy to understand and implement
 -- Choosing optimal join for optimal use case is difficult                            -- Easy.
 

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

-- Sub Queries
    -- 1. Outer query depends on inner query.
    -- 2. Alternative to joins.
    -- 3. Nested queries.


-- Sub queries exist mainly in 3 clauses
    -- 1. Inside a WHERE clause.
    -- 2. Inside a FROM clause.
    -- 3. Inside a SELECT clause.



-- WHERE Clause same table
-- employee with age > 21

SELECT *FROM employee WHERE age IN (SELECT age FROM employee WHERE age > 21);

-- WHERE Caluse Different Table
-- employee details working in more then 1 project

SELECT *FROM employee WHERE id IN (SELECT empID from project GROUP BY empID having count(empID)>1);

-- Single Value Subquery
-- emp details having age > avg(age)

SELECT *FROM employee WHERE age > (SELECT AVG(age) FROM employee);

SELECT AVG(age) FROM employee;

-- FROM Clause - Derived Caluse

-- Select max age person whose first name  contains 'a'

SELECT MAX(age) FROM(SELECT *FROM employee WHERE FirstName LIKE '%a%') as emp;


-- Co-related sub-queries
    -- 1. With a normal nested subquery, the inner SELECT query runs first and executes once, returning values to be used by the main query. A correlated subquery, however, executes once for each candidate row considered by the outer query. In other words, the inner query is driven by the outer query

-- Find 3rd Oldest Employee

SELECT *FROM employee e1 WHERE 4 = (
 SELECT COUNT(e2.age)
 FROM employee e2 
 WHERE e2.age >= e1.age
);

