CREATE USER devnest WITH PASSWORD 'password';         
CREATE DATABASE devsDB;                               
GRANT ALL PRIVILEGES ON DATABASE devsDB to devnest;   
DROP DATABASE IF EXISTS devsDB;                       
CREATE DATABASE devsDB;

\l;                                                  
\c devsDB;                                            


CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);                                                    
CREATE TABLE DEPARTMENT(
   ID INT PRIMARY KEY      NOT NULL,
   DEPT           CHAR(50) NOT NULL,
   EMP_ID         INT      NOT NULL
);                                                  



create schema myschema;                              
create table myschema.company(
   ID   INT              NOT NULL,
   NAME VARCHAR (20)     NOT NULL,
   AGE  INT              NOT NULL,
   ADDRESS  CHAR (25),
   SALARY   DECIMAL (18, 2),
   PRIMARY KEY (ID)
);                                                  
select * from myschema.company;
DROP SCHEMA myschema;                              
DROP SCHEMA myschema CASCADE;                      


/*** Insert Queries examples ***/

DROP TABLE IF EXISTS COMPANY;
CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL,
   JOIN_DATE	    DATE
);
INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY,JOIN_DATE) VALUES (1, 'Paul', 32, 'California', 20000.00,'2001-07-13');
INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,JOIN_DATE) VALUES (2, 'Allen', 25, 'Texas', '2007-12-13');
INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY,JOIN_DATE) VALUES (3, 'Teddy', 23, 'Norway', 20000.00, DEFAULT );
INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY,JOIN_DATE) VALUES (4, 'Mark', 25, 'Rich-Mond ', 65000.00, '2007-12-13' ), (5, 'David', 27, 'Texas', 85000.00, '2007-12-13');


/** Select query example **/
SELECT (15 + 6) AS ADDITION ;                         
SELECT COUNT(*) AS "RECORDS" FROM COMPANY;            
SELECT CURRENT_TIMESTAMP;                            
select * from COMPANY;                               
SELECT * FROM COMPANY WHERE AGE >= 25 AND SALARY >= 65000;    
SELECT * FROM COMPANY WHERE AGE >= 25 OR SALARY >= 65000;     
SELECT * FROM COMPANY WHERE AGE IS NOT NULL;                  
SELECT * FROM COMPANY WHERE NAME LIKE 'Pa%';                  
SELECT * FROM COMPANY WHERE NAME LIKE 'Pau_';                 
SELECT * FROM COMPANY WHERE SALARY::text LIKE '200%';         
SELECT * FROM COMPANY WHERE ADDRESS  LIKE '%-%';              
SELECT * FROM COMPANY WHERE AGE IN ( 25, 27 );                
SELECT * FROM COMPANY WHERE AGE NOT IN ( 25, 27 );           
SELECT * FROM COMPANY WHERE AGE BETWEEN 25 AND 27;            
SELECT AGE FROM COMPANY
        WHERE EXISTS (SELECT AGE FROM COMPANY WHERE SALARY > 65000);  
SELECT * FROM COMPANY
        WHERE AGE > (SELECT AGE FROM COMPANY WHERE SALARY > 65000);   
SELECT * FROM COMPANY LIMIT 4;                                
SELECT * FROM COMPANY LIMIT 3 OFFSET 2;                       
SELECT * FROM COMPANY ORDER BY NAME DESC;                     



/*** UPDATE QUERY ***/
UPDATE COMPANY SET SALARY = 15000 WHERE ID = 3;              
UPDATE COMPANY SET ADDRESS = 'Texas', SALARY=20000;           



DELETE FROM COMPANY WHERE ID = 2;                          












DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS contacts;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);                                                            

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)
);                                                           

INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');	   
	   
INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@bluebird.dev'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@bluebird.dev'),
      (2,'David Wright','(408)-222-1234','david.wright@dolphin.dev');

DELETE FROM customers
WHERE customer_id = 1;                                   



/*** ON DELETE EXAMPLE ***/
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS customers;

/** NOTE : IDENTITY is introduced in postgres version >= 10. For previous versions use serial **/
CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)
	  ON DELETE SET NULL
);                                                            

INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');	   
	   
INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@bluebird.dev'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@bluebird.dev'),
      (2,'David Wright','(408)-222-1234','david.wright@dolphin.dev');


DELETE FROM customers
WHERE customer_id = 1;







DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)
	  ON DELETE CASCADE
);

INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');	   
	   
INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@bluebird.dev'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@bluebird.dev'),
      (2,'David Wright','(408)-222-1234','david.wright@dolphin.dev');

DELETE FROM customers
WHERE customer_id = 1;

SELECT * FROM contacts;
 
