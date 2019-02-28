-- CREATE A INVOICE TABLE
CREATE TABLE INVOICE(

    INVOICE_ID NUMBER(5) PRIMARY KEY,
    INVOICE_DATE DATE,
    CUSTOMER_ID NUMBER(3)REFERENCES CUSTOMER,
    AMOUNT NUMBER(5,2)
    
    );

-- CREATE A CUSTOMER TABLE  
CREATE TABLE CUSTOMER(

    ID_NUM NUMBER(3) PRIMARY KEY,
    C_NAME VARCHAR2(25),
    C_EMAIL VARCHAR2(50)   
    
    );
    
-- I CREATED AN EMAIL FIELD, BUT I DON'T ACTUALL WANT TO USE IT SO IM GOING TO REMOVE THAT COLUMN
ALTER TABLE CUSTOMER
DROP COLUMN C_EMAIL;


-- CREATE 7 CUSTOMERS FIRST BECAUSE IF I TRIRED TO CREATE AN INSTANCE, THERE'D BE NO REFERENCE FOR THE CUSTOMER ID YET
INSERT INTO CUSTOMER(ID_NUM, C_NAME) VALUES (1, 'CASH MONEY');
INSERT INTO CUSTOMER(ID_NUM, C_NAME) VALUES (2, 'JOE SMOE');
INSERT INTO CUSTOMER(ID_NUM, C_NAME) VALUES (3, 'MIKE WRIGHT');
INSERT INTO CUSTOMER(ID_NUM, C_NAME) VALUES (4, 'OTTO MO BEAL');
INSERT INTO CUSTOMER(ID_NUM, C_NAME) VALUES (5, 'LUCY LUE');
INSERT INTO CUSTOMER(ID_NUM, C_NAME) VALUES (6, 'TOM FOOLERY');
INSERT INTO CUSTOMER(ID_NUM, C_NAME) VALUES (7, 'DAVID VALENTINE');

-- CREATE 13 INVOICES AND ADD THEM TO THE INVOICE TABLE
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (1, DATE '2019-02-10' , 1, 250.00);
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (2, DATE '2015-08-30', 4, 345.25); 
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (3, DATE '2016-09-09', 3, 500.00); 
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (4, DATE '2018-03-21', 7, 100.00); 
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (5, DATE '2017-11-13', 6, 750.23); 
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (6, DATE '2019-01-29', 4, 30.75); 
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (7, DATE '2016-12-11', 2, 475.15); 
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (8, DATE '2015-10-05', 5, 680.00); 
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (9, DATE '2018-04-03', 2, 10.00); 
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (10, DATE '2017-03-07', 4, 200.25); 
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (11, DATE '2019-05-15', 1, 45.20); 
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (12, DATE '2018-06-17', 4, 950.50); 
INSERT INTO INVOICE(INVOICE_ID, INVOICE_DATE, CUSTOMER_ID, AMOUNT) VALUES (13, DATE '2016-07-18' , 3, 715.60); 

-- UPDATEING THREE INVOICE RECORDS
UPDATE INVOICE
SET AMOUNT = 875.25
WHERE CUSTOMER_ID = 7;

UPDATE INVOICE
SET INVOICE_DATE = DATE '2013-04-01'
WHERE INVOICE_ID = 11;

UPDATE INVOICE
SET CUSTOMER_ID = 6
WHERE AMOUNT = 200.25;

-- DELETE 2 INVOICES AT THE SAMETIME 
DELETE FROM INVOICE
WHERE AMOUNT > 850.00;  

-- TWO MORE UPDATES
UPDATE INVOICE
SET CUSTOMER_ID = 7
WHERE INVOICE_ID = 9;

UPDATE INVOICE
SET INVOICE_DATE = DATE '2019-02-27'
WHERE INVOICE_ID = 7;

-- ANOTHER DELETE COUPLE
DELETE FROM INVOICE
WHERE CUSTOMER_ID = 7;

DELETE FROM INVOICE
WHERE CUSTOMER_ID = 2;

SAVEPOINT FIRSTSAVEPOINT;
COMMIT;

-- CREATE QUERY TO SHOW PURCHASES MADE TODAY
SELECT *
FROM INVOICE
WHERE INVOICE_DATE = TRUNC(CURRENT_DATE);
-- WHERE INVOICE_DATE LIKE CONVERT(VARCHAR(10), GETDATE(), 120);

-- CREATE A QUERY TO SHOW EACH CUSTOMER AND THE NUMBER OF PURCHASES MADE BY EACH
SELECT CUSTOMER_ID, COUNT(*) AS TOTAL_PURCHASES 
FROM INVOICE
GROUP BY CUSTOMER_ID 
HAVING COUNT(*) > 1
ORDER BY CUSTOMER_ID ASC;

-- CREATE A QUERY WHICH SHOWS EACH CUSTOMER AND THE TOTAL COST OF ALL THEIR PURCHASES
SELECT CUSTOMER_ID, SUM(AMOUNT) AS CUSTOMER_SUM
FROM INVOICE
GROUP BY CUSTOMER_ID
HAVING COUNT(*) > 1
ORDER BY CUSTOMER_ID ASC;


-- CREATE A QUERY WHICH RETURNS ALL PURCHASES MADE IN THE LAST MONTH, DISPLAY THEM IN DESCENDING ORDER
SELECT *
FROM INVOICE
WHERE INVOICE_DATE > ADD_MONTHS(TRUNC(CURRENT_DATE), -1)
ORDER BY INVOICE_DATE ASC;



-- CREATE A QUERY WHICH SHOWS THE TOP THREE MOST EXPENSIVE PURCHASES
SELECT *
FROM 
    (SELECT * 
    FROM INVOICE
    ORDER BY AMOUNT DESC)
WHERE ROWNUM < 4;

--UPDATE INVOICE TABLE TO SHOW TWO DECIMAL PLACES
ALTER TABLE INVOICE 
MODIFY AMOUNT DECIMAL(5,2);

COMMIT;

SAVEPOINT PREAMOUNTFORMATUPDATE; 

--------------
--  PART 2  --
--------------


-- Create a query which returns all of the invoices which have a listed customer, but not invoices who have no customer listed and not customers who have no invoices listed --
SELECT C.C_NAME AS PERSON, I.INVOICE_ID AS TRANSACTION
FROM CUSTOMER C
JOIN INVOICE I
ON C.ID_NUM = I.CUSTOMER_ID;

-- Create a query which returns all of the invoices and their customer, not invoices who have no customer listed but include customers which have no invoices listed --
SELECT C.C_NAME AS CUSTOMER, I.INVOICE_ID AS INVOICE
FROM CUSTOMER C
LEFT JOIN INVOICE I
ON C.ID_NUM = I.CUSTOMER_ID;

-- Create a query which shows each record in the invoice table, along with the name of the customer --
SELECT C.C_NAME AS PERSON, I.INVOICE_ID AS TRANSACTION
FROM CUSTOMER C
RIGHT JOIN INVOICE I
ON C.ID_NUM = I.CUSTOMER_ID;

-- Create a query which shows the name of each customer and the total amount they have spent --
SELECT C.C_NAME AS CUSTOMER_NAME, SUM(I.AMOUNT) AS CUSTOMER_SUM
FROM CUSTOMER C
LEFT JOIN  INVOICE I
ON C.ID_NUM =I.CUSTOMER_ID
GROUP BY C.C_NAME;


SAVEPOINT FIRSTFOURDONE;
COMMIT;






    