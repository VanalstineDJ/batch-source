CREATE TABLE CUSTOMER (
    C_ID NUMBER(5) CONSTRAINT PK_C PRIMARY KEY,
    C_FIRST_NAME VARCHAR2(3000 CHAR),
    C_LAST_NAME  VARCHAR2(3000 CHAR)
);

CREATE TABLE INVOICE (
    I_ID NUMBER(5) PRIMARY KEY,
    I_AMOUNT NUMBER(5, 2) NOT NULL,
    I_DATE DATE,
    C_ID  NUMBER(5) CONSTRAINT FK_I_C REFERENCES CUSTOMER
);

INSERT INTO CUSTOMER VALUES (1, 'LeBron', 'James');
INSERT INTO CUSTOMER VALUES (2, 'James', 'Harden');
INSERT INTO CUSTOMER VALUES (3, 'Kobe', 'Bryant');
INSERT INTO CUSTOMER VALUES (4, 'Jeremy', 'Lin');
INSERT INTO CUSTOMER VALUES (5, 'Kryie', 'Irving');

INSERT INTO INVOICE VALUES (1, 20, DATE '1998-07-24', 2);
INSERT INTO INVOICE VALUES (2, 126,DATE '2014-10-12', 5);
INSERT INTO INVOICE VALUES (3, 59, DATE '2016-10-12', 2);
INSERT INTO INVOICE VALUES (4, 78, DATE '2008-04-18', 4);
INSERT INTO INVOICE VALUES (5, 48, DATE '2019-01-12', 2);
INSERT INTO INVOICE VALUES (6, 37, DATE '1992-10-12', 2);
INSERT INTO INVOICE VALUES (7, 98, DATE '2019-01-26', 5);
INSERT INTO INVOICE VALUES (8, 92, DATE '2013-10-12', 2);
INSERT INTO INVOICE VALUES (9, 17, DATE '2011-10-12', 3);
INSERT INTO INVOICE VALUES (10, 95, DATE '2015-10-12', 3);

UPDATE INVOICE SET I_DATE = DATE '2019-02-26' WHERE I_ID = 4;
UPDATE INVOICE SET C_ID = 1 WHERE I_ID = 5;

-- query to show purchase from today
SELECT i_amount
FROM INVOICE
WHERE I_DATE = DATE '2019-02-26';


-- query to show each CUSTOMER and the number of purchases made by each
SELECT CUSTOMER.C_FIRST_NAME, CUSTOMER.C_LAST_NAME, COUNT(invoice.c_id) AS PURCHASES
FROM INVOICE
INNER JOIN CUSTOMER 
ON INVOICE.C_ID = Customer.C_ID
GROUP BY CUSTOMER.C_FIRST_NAME, CUSTOMER.C_LAST_NAME
ORDER BY COUNT(invoice.c_id) DESC;


-- query to show each CUSTOMER and the total cost of all their purchases
SELECT CUSTOMER.C_FIRST_NAME, CUSTOMER.C_LAST_NAME, SUM(INVOICE.I_AMOUNT) AS TOTAL
FROM INVOICE
INNER JOIN CUSTOMER 
ON INVOICE.C_ID = Customer.C_ID
GROUP BY CUSTOMER.C_FIRST_NAME, CUSTOMER.C_LAST_NAME
ORDER BY SUM(INVOICE.I_AMOUNT) DESC;


-- query to return all the purchases which took place in the last month, dipslay in desc order
SELECT I_DATE
FROM INVOICE
WHERE I_DATE BETWEEN DATE '2019-01-01' AND DATE '2019-01-31'
ORDER BY I_DATE DESC;


-- query to show the three most expensive purchases
SELECT i_amount
FROM INVOICE
ORDER BY I_AMOUNT DESC
FETCH FIRST 3 ROW ONLY;
