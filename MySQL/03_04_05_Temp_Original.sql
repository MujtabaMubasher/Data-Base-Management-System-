-- Active: 1717794070887@@127.0.0.1@3306@bank
CREATE DATABASE Temp;
USE temp;

-- ----------------CONSTRAINTS (DDL)-----------------------

-- 1. Primary Key
   --  1. PK is not null, unique and only one per table.

-- 2. Foreign Key
   /*  
    -- 1. FK refers to PK of other table.
    -- 2. Each relation can having any number of FK.
    -- 3. CREATE TABLE ORDER (
    id INT PRIMARY KEY,
    delivery_date DATE,
    order_placed_date DATE,
    cust_id INT,
    FOREIGN KEY (cust_id) REFERENCES customer(id)
  );*/


-- 3. UNIQUE
  /* 
    -- 1. Unique, can be null, table can have multiple unique attributes.
    -- 2. CREATE TABLE customer (
    …
    email VARCHAR(1024) UNIQUE,
    …
    );
  */


-- 4. CHECK
   /* 1. CREATE TABLE customer (
    …
    CONSTRAINT age_check CHECK (age > 12),
    …
    );
    2. “age_check”, can also avoid this, MySQL generates name of constraint automatically.
   */


-- 5. DEFAULT
    /* --  1. Set default value of the column.
       --  2. CREATE TABLE account (
        …
        saving-rate DOUBLE NOT NULL DEFAULT 4.25,
        …
        );
    */
-- 6. An attribute can be PK and FK both in a table.


 CREATE Table Account (
    id INT PRIMARY KEY,
    Name VARCHAR(25) UNIQUE,
    Balance INT NOT NULL DEFAULT 0
    /* CONSTRAINT Check_Acc_Balnc CHECK(balance > 100)*/
);

INSERT INTO account VALUES
(1,"Mujtaba", 1200);

INSERT INTO account VALUES
(2,"Irtaza", 1500);
INSERT INTO account (id, Name) VALUES
(3,"Mubasher");

SELECT *FROM account;

DROP TABLE account;


-- ------------------ ALTER OPERATIONS  -------------------

-- ADD:  New Column
   
    -- 1. Add new column.
    -- 2. ALTER TABLE table_name ADD new_col_name datatype ADD new_col_name_2 datatype;
    -- 3. e.g., ALTER TABLE customer ADD age INT NOT NULL;

ALTER TABLE account ADD intrest FLOAT NOT NULL DEFAULT 0;  
DESC account;  -- Describe Account(DataType);

-- MODIFY
    -- 1. Change datatype of an attribute.
    -- 2. ALTER TABLE table-name MODIFY col-name col-datatype;
    -- 3. E.g., VARCHAR TO CHAR
    -- ALTER TABLE customer MODIFY name CHAR(1024);

ALTER TABLE account MODIFY intrest DOUBLE; 

DESC account; -- Describe Account(DataType);

-- RENAME Table Name
    -- 1. Rename table name itself.
    -- 2. ALTER TABLE table-name RENAME TO new-table-name;
    -- 3. e.g., ALTER TABLE customer RENAME TO customer-details

ALTER TABLE saving_acc_interest RENAME account_details;

-- CHANGE Column Name
    -- 1. Rename column name.
    -- 2. ALTER TABLE table-name CHANGE COLUMN old-col-name new-col-name new-col-datatype;
    -- 3. e.g., ALTER TABLE customer CHANGE COLUMN name customer-name VARCHAR(1024);
ALTER TABLE account_details CHANGE COLUMN  intrest saving_interest FLOAT NOT NULL DEFAULT 0;

DESC account_details; -- Describe Account(DataType);

-- DROP COLUMN
    -- 1. Drop a column completely.
    -- 2. ALTER TABLE table-name DROP COLUMN col-name;
    -- 3. e.g., ALTER TABLE customer DROP COLUMN middle-name

ALTER TABLE account_details DROP COLUMN saving_interest; 


-- ------------ DATA MANIPULATION LANGUAGE (DML)  -----------------


CREATE TABLE Customer(
    id INTEGER PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255),
    Gender CHAR(2),
    City VARCHAR(255),
    Pincode integer
);

-- INSERT
    -- 1. INSERT INTO table-name(col1, col2, col3) VALUES (v1, v2, v3), (val1, val2, val3);
INSERT INTO Customer VALUES
(1,'Mujtaba Mubasher','Punjab Society', 'M', 'Lahore', 54000),
(2,'Irtaza Mubasher','Punjab Society', 'M', 'Lahore', 54000),
(3,'Sufyan Ahmad','Township', 'M', 'Islamabad', 54000),
(4,'Ahsan Yousaf','Walton', 'M', 'Multan', 54000),
(5,'Noman Javed','Kheyabana Amin', 'M', 'Lahore', 54000);

INSERT INTO Customer (id, Name, Address, Gender, City, Pincode  ) VALUES
(6,'Arslan Ahmad','Wapda Town', 'M', 'Karachi', NULL);
INSERT INTO Customer (id, Name, Address, Gender, City, Pincode  ) VALUES
(7,'Hamza Arfan','Faisal Town', 'M', 'Karachi', 542211);
INSERT INTO Customer (id, Name) VALUES
(8,'Tanzeel Nawaz');

-- UPDATE
-- 1. UPDATE table-name SET col1 = 1, col2 = ‘abc’ WHERE id = 1;
-- 2. Update multiple rows e.g.,
    -- 1. UPDATE student SET standard = standard + 1;
-- 3. ON UPDATE CASCADE
    -- 1. Can be added to the table while creating constraints. Suppose there is a situation where we have two tables such that primary key of one table is the foreign key for another table. if we update the primary key of the first table then using the ON UPDATE CASCADE foreign key of the second table automatically get updated

UPDATE customer SET address = 'Joher Town', city = 'Lahore' WHERE id = 8;

-- UPDATE MULTIPLE ROWS

UPDATE customer SET pincode = 54000;
            -- OR
UPDATE customer SET pincode = pincode + 1;

-- DELETE
-- 1. DELETE FROM table-name WHERE id = 1;
-- 2. DELETE FROM table-name; //all rows will be deleted.
-- 3. DELETE CASCADE - (to overcome DELETE constraint of Referential constraints)
    -- 1. What would happen to child entry if parent table’s entry is deleted?
  /*
    -- 2. 
    CREATE TABLE ORDER (
    order_id int PRIMARY KEY,
    delivery_date DATE,
    cust_id INT,
    CodeHelp
    FOREIGN KEY(cust_id) REFERENCES customer(id) ON DELETE CASCADE
    );

  */

  DELETE FROM customer WHERE id = 8;
              -- OR
  -- DELETE FROM table-name; //all rows will be deleted.
 

-- ON DELETE NULL - (can FK have null values?)
    /*
        -- 1. CREATE TABLE ORDER (
        order_id int PRIMARY KEY,
        delivery_date DATE,
        cust_id INT,
        FOREIGN KEY(cust_id) REFERENCES customer(id) ON DELETE SET NULL
      );
   */

CREATE TABLE Order_details(
    Order_id INTEGER PRIMARY KEY,
    Delivery_Date DATE,
    Customer_id INT,
    FOREIGN KEY(Customer_id) REFERENCES Customer(id) ON DELETE SET NULL /* This SET to NULL in child Table If entry deleted from parent*/
     -- ON DELETE CASCADE // Delete Entery from Parent as well as Child
);

INSERT INTO order_details VALUES 
(1,'2024-06-09',4);
INSERT INTO order_details VALUES 
(2,'2024-06-13',6);
INSERT INTO order_details VALUES 
(3,'2024-06-19',4);

SELECT *FROM customer;

DROP TABLE Order_details;
DROP TABLE customer;
DELETE FROM customer WHERE id = 4;

-- REPLACE
-- 1. Primarily used for already present tuple in a table.
-- 2. As UPDATE, using REPLACE with the help of WHERE clause in PK, then that row will be replaced.
-- 3. As INSERT, if there is no duplicate data new tuple will be inserted.
-- 4. REPLACE INTO student (id, class) VALUES(4, 3);
-- 5. REPLACE INTO table SET col1 = val1, col2 = val2;


-- Note
  -- 1 Data Already Present Replace
  -- 2 Data not present Insert
-- Replace Vs Update
   -- 1 If row is not present Replace will add the new row while Update will do nothing

REPLACE INTO customer(id, city) -- Replace Existing VALUES
VALUES(6, "London");

REPLACE INTO customer(id, name, city) -- Insert New value
VALUES(9,"Hamza", "NewYork");

REPLACE customer SET id = 2, name = "Irfan", city = "Shargha Dubai";

/*
  // Note Commonly use
 REPLACE INTO customer (id, name, city)
 SELECT id, name, city
 FROM customer WHERE id = 1;
 */

