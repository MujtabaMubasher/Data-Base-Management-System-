-- Active: 1717794070887@@127.0.0.1@3306@set_operations

									 -- Differnet Between JOIN & SET OPERATIONs
 -- JOIN                                                                               -- SET Operations;
 -- Combines multiple tables based on matching condition.                              -- Combination is resulting set from two or more SELECT statements.
 --  Column wise combination.                                                          -- Row wise combination.
 -- Data types of two tables can be different.                                         -- Datatypes of corresponding columns from each table should be the same.
 -- Can generate both distinct or duplicate rows.                                      -- Generate distinct rows.
 -- The number of column(s) selected may or may not be the same from each table.       -- The number of column(s) selected must be the same from each table.
 -- Combines results horizontally.                                                     -- Combines results vertically


CREATE DATABASE set_operations;
USE set_operations;

CREATE Table department_1(
    empID INT PRIMARY KEY,
    name VARCHAR(25),
    role VARCHAR(25)
);

INSERT INTO department_1 VALUES 
(1,"A","engineer"),
(2,"B","salesman"),
(3,"C","manager"),
(4,"D","salesman"),
(5,"E","engineer");


CREATE Table department_2(
    empID INT PRIMARY KEY,
    name VARCHAR(25),
    role VARCHAR(25)
);

INSERT INTO department_2 VALUES 
(3,"C","manager"),
(6,"F","marketing"),
(7,"G","salesman");


-- UNION
    -- 1. Combines two or more SELECT statements.
    -- 2. SELECT * FROM table UNION SELECT * FROM table2;
    -- 3. Number of column, order of column must be same for table1 and table2.

-- List out All the Employees in a company 
SELECT *FROM department_1 
UNION
SELECT *FROM department_2;


-- List out all the employees in all departments who work as salesman
SELECT *FROM department_1 WHERE role = "salesman"
UNION 
SELECT *FROM department_2 WHERE role = "salesman";


-- INTERSECT
    -- 1. Returns common values of the tables.
    -- 2. Emulated.
    -- 3. SELECT DISTINCT column-list FROM table-1 INNER JOIN table-2 USING(join_cond);
    -- 4. SELECT DISTINCT * FROM table1 INNER JOIN table2 ON USING(id);



-- List out all the employees who work for both the department

SELECT *FROM department_1 INNER JOIN department_2 using(empID);
SELECT department_1. *FROM department_1 INNER JOIN department_2 using(empID);


-- MINUS
    -- 1. This operator returns the distinct row from the first table that does not occur in the second table.
    -- 2. Emulated.
    -- 3. SELECT column_list FROM table1 LEFT JOIN table2 ON condition WHERE table2.column_name IS NULL;
    -- 4. e.g., SELECT id FROM table-1 LEFT JOIN table-2 USING(id) WHERE table-2.id IS NULL;


-- List out all the employees working department_1 but not in department_2

SELECT *FROM department_1 LEFT JOIN department_2 using(empID); 


SELECT department_1. *FROM department_1 LEFT JOIN department_2 USING (empID) WHERE department_2.empID IS NULL;

