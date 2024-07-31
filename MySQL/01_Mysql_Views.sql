CREATE DATABASE mysql_views;
USE mysql_views;

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