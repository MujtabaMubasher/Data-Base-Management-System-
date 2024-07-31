CREATE DATABASE ORG;
USE ORG;

-- Creating The Table
CREATE TABLE Worker(
 WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
 FIRST_NAME CHAR(25),
 LAST_NAME CHAR(25),
 SALARY INT,
 JOINING_DATE DATETIME,
 DEPARTMENT CHAR(25)
);

INSERT INTO worker
  (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
  (001, 'Mujtaba', 'Mubasher', 100000, '14-02-24 09.00.00', 'Development'),
  (002, 'Ahmad', 'Naveed', 850000, '20-003-24 09.00.00', 'HR'),
  (003, 'Danish', 'Naeem', 120000, '16-02-24 09.00.00', 'Admin'),
  (004, 'Ahsan', 'Yousaf', 85000, '28-05-24 09.00.00', 'Development'),
  (005, 'Irtaza', 'Haider', 90000, '03-04-24 09.00.00', 'HR'),
  (006, 'Tanzeel', 'Nawaz', 150000, '10-03-24 09.00.00', 'Admin'),
  (007, 'Talal', 'Haider', 200000, '19-06-24 09.00.00', 'Account'),
  (008, 'Ayoub', 'Wahid', 105000, '09-07-24 09.00.00', 'Account');


-- Creating The Table  
CREATE TABLE Bonus (
    WORKER_REF_ID INT,
    BONUS_AMOUNT INT(10),
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
     REFERENCES worker(WORKER_ID)
     ON DELETE CASCADE
);

INSERT INTO Bonus 
(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
(001, 5000, '16-02-20'),
(002, 3000, '16-06-11'),
(003, 4000, '16-02-20'),
(001, 4500, '16-02-20'),
(002, 3500, '16-06-11');


-- Creating The Table
CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORK_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
     REFERENCES worker(WORKER_ID)
     ON DELETE CASCADE
);

INSERT INTO Title
(WORKER_REF_ID,  WORK_TITLE, AFFECTED_FROM) VALUES
(001, "Manager", '2016-02-20'),
(002, "Executive", '2016-06-11'),
(008, "Executive", '2016-06-11'),
(005, "Manager", '2016-06-11'),
(004, "Assist Manager", '2016-06-11'),
(007, "Executive", '2016-06-11'),
(006, "Lead", '2016-06-11'),
(003, "Lead", '2016-06-11');

-- I Am Studing DRL(Data Retrivel Language) || DQL(Data Query Language)
-- 1. Syntax: SELECT <set of column names> FROM <table_name>;
-- 2. Order of execution from RIGHT to LEFT.
select *from worker;
SELECT FIRST_NAME,SALARY FROM worker;  
-- Q. Can we use SELECT keyword without using FROM clause?
-- 1. Yes, using DUAL Tables.
-- 2. Dual tables are dummy tables created by MySQL, help users to do certain obvious actions without referring to user defined tables.
SELECT 5 + 11;
SELECT now();
SELECT LCASE("MUJTABA MUBASHER");
SELECT UCASE("mujtaba mubasher");


-- WHERE
-- 1. Reduce rows based on given conditions.
-- 2. E.g., SELECT * FROM customer WHERE age > 18;
SELECT *FROM worker WHERE SALARY >= 150000;
SELECT *FROM worker WHERE DEPARTMENT = "HR";

-- BETWEEN
-- 1. SELECT * FROM customer WHERE age between 0 AND 100;
-- 2. In the above e.g., 0 and 100 are inclusive.

 -- AND/OR/NOT
-- 1. AND: WHERE cond1 AND cond2
-- 2. OR: WHERE cond1 OR cond2
-- 3. NOT: WHERE col_name NOT IN (1,2,3,4)

SELECT *FROM worker WHERE SALARY BETWEEN 80000 AND 150000 ;

SELECT * FROM worker WHERE DEPARTMENT = "HR" OR DEPARTMENT = "Account" OR DEPARTMENT = "Admin";

-- Better Way

-- IN
-- 1. Reduces OR conditions;
-- 2. e.g., SELECT * FROM officers WHERE officer_name IN ('Lakshay', ‘Maharana Pratap', ‘Deepika’)

SELECT * FROM worker WHERE DEPARTMENT IN("HR","Development");

SELECT *FROM worker WHERE DEPARTMENT NOT IN("HR", "Account");

-- IS NULL
-- 1. e.g., SELECT * FROM customer WHERE prime_status is NULL

SELECT *FROM worker WHERE DEPARTMENT IS NULL;


-- Pattern Searching / Wildcard (‘%’, ‘_’)
-- 1. ‘%’, any number of character from 0 to n. Similar to ‘*’ asterisk in regex.
-- 2. ‘_’, only one character.
-- 3. SELECT * FROM customer WHERE name LIKE ‘%p_’;

SELECT *FROM worker WHERE FIRST_NAME LIKE '%i%';

-- Second Character is a
SELECT *FROM worker WHERE FIRST_NAME LIKE '_a%';
-- Last Character is a 
SELECT *FROM worker WHERE FIRST_NAME LIKE '%_a';
-- Second Last Character is a 
SELECT *FROM worker WHERE FIRST_NAME LIKE '%a_';


-- ORDER BY
-- 1. Sorting the data retrieved using WHERE clause.
-- 2. ORDER BY <column-name> DESC;
-- 3. DESC = Descending and ASC = Ascending
-- 4. e.g., SELECT * FROM customer ORDER BY name DESC

SELECT *FROM worker ORDER BY SALARY DESC;

SELECT *FROM worker ORDER BY SALARY ASC;
                  -- OR
SELECT *FROM worker WHERE SALARY ORDER BY SALARY DESC;

-- DISTINCT
-- 1. Find distinct values in the table.
-- 2. SELECT DISTINCT(col_name) FROM table_name;
-- 3. GROUP BY can also be used for the same
    -- 1. “Select col_name from table GROUP BY col_name;” same output as above DISTINCT query.
    -- 2. SQL is smart enough to realise that if you are using GROUP BY and not using any aggregation function, then you mean “DISTINCT”.

SELECT DISTINCT DEPARTMENT from worker;

-- GROUP BY
-- 1. GROUP BY Clause is used to collect data from multiple records and group the result by one or more column. It is generally used in a SELECT statement.
-- 2. Groups into category based on column given.
-- 3. SELECT c1, c2, c3 FROM sample_table WHERE cond GROUP BY c1, c2, c3.
-- 4. All the column names mentioned after SELECT statement shall be repeated in GROUP BY, in order to successfully execute the query.
-- 5. Used with aggregation functions to perform various actions.
	 -- 1. COUNT()
	 -- 2. SUM()
	 -- 3. AVG()
	 -- 4. MIN()
	 -- 5. MAX()

SELECT DEPARTMENT, MIN(SALARY) FROM worker  GROUP BY DEPARTMENT;
SELECT DEPARTMENT, COUNT(*) FROM worker  GROUP BY DEPARTMENT;
SELECT DEPARTMENT, SUM(SALARY) FROM worker  GROUP BY DEPARTMENT;
SELECT *FROM worker;
SELECT DEPARTMENT, MIN(SALARY) FROM worker  GROUP BY DEPARTMENT;
SELECT DEPARTMENT, AVG(SALARY) FROM worker  GROUP BY DEPARTMENT;



-- GROUP BY HAVING
-- 1. Out of the categories made by GROUP BY, we would like to know only particular thing (cond).
-- 2. Similar to WHERE.
-- 3. Select COUNT(cust_id), country from customer GROUP BY country HAVING COUNT(cust_id) > 50;
-- 4. WHERE vs HAVING
	-- 1. Both have same function of filtering the row base on certain conditions.
	-- 2. WHERE clause is used to filter the rows from the table based on specified condition
	-- 3. HAVING clause is used to filter the rows from the groups based on the specified condition.
	-- 4. HAVING is used after GROUP BY while WHERE is used before GROUP BY clause.
	-- 5. If you are using HAVING, GROUP BY is necessary.
	-- 6. WHERE can be used with SELECT, UPDATE & DELETE keywords while GROUP BY used with SELECT

SELECT FIRST_NAME, SUM(SALARY) FROM worker GROUP BY FIRST_NAME HAVING SUM(SALARY) > 100000; 
SELECT DEPARTMENT, COUNT(DEPARTMENT) FROM worker GROUP BY DEPARTMENT HAVING COUNT(DEPARTMENT) > 1;





















