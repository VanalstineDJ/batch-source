--SELECT ALL RECORDS FROM EMPLOYEE TABLE
SELECT *
FROM EMPLOYEE;

--SELECT ALL RECORDS FROM EMPLOYEE CONTAINING LASTNAME = King
SELECT *
FROM EMPLOYEE
WHERE LASTNAME = 'King';

--SELECT ALL RECORS FROM EMPLOYEE WHERE FIRST NAME IS Andrew AND REPORTSTO IS NULL
SELECT *
FROM EMPLOYEE
WHERE FIRSTNAME = 'Andrew' AND REPORTSTO IS NULL;

--SELECT ALL ALBUMS IN ALBUM AND SORT IN DECENDING BY TITLE
SELECT * 
FROM ALBUM
ORDER BY TITLE DESC;

--SELECT ALL ALBUMS IN ALBUM AND SORT IN ASCENDING BY TITLE
SELECT FIRSTNAME
FROM CUSTOMER
ORDER BY CITY ASC;

--SELECT INVOICES WITH A BILLIND ADDRESS LIKE "T%"
SELECT *
FROM INVOICE
WHERE BILLINGADDRESS LIKE 'T%';

--INSERT TWO NEW RECORDS INTO GENRE TABLE
INSERT INTO GENRE VALUES(26, 'Horror');
INSERT INTO GENRE VALUES(27, 'Romance');

--INSERT TWO NEW ENTRIES INTO THE EMPLOYEE TABLE
INSERT INTO EMPLOYEE VALUES (9,'Rogers', 'Dave', 'Moral Suport Associate', 1, DATE '1990-04-23', DATE '2019-01-23', '643 Love All Street', 'Anthony', 'NM', 'UNITED STATES OF AMERICA', 88021, '+1 (915) 456 9087','+1 (915) 456 9087', 'd.rodgers@gmail.com');
INSERT INTO EMPLOYEE VALUES (10,'Davis', 'Kylee', 'Data Entry Specialist', 1, DATE '1992-12-01', DATE '2018-03-23', '1212 Data Best Road', 'Kansas City', 'MO', 'UNITED STATES OF AMERICA', 64030, '+1 (890) 653 8759','+1 (890) 653 8759', 'K.Dis@gmail.com');

--INSERT TWO NEW RECORDS TO THE CUSTOMER TABLE
INSERT INTO CUSTOMER VALUES(60, 'Prisca', 'Trenoweth', 'TallgrassEnergy Partners, LP', '1790 Dennis Park', 'Liuhou', null, 'China', null, '902-515-5924','902-515-5924', 'ptrenoweth0@techcrunch.com', 2);
INSERT INTO CUSTOMER VALUES(61, 'Yuryev', 'Holt', 'CACI International, Inc.', '7348 Claremont Point', 'J�rf�lla', 'Stockholm', 'Sweden', 17671	, '970-927-6274','970-927-6274', 'hyuryev0@google.fr', 5);

--UPDATE Aaron Mitchell IN CUSTOMER TABLE TO Robert Walter
UPDATE CUSTOMER
SET FIRSTNAME = 'Robert', LASTNAME = 'Walter'
WHERE FIRSTNAME = 'Aaron' AND LASTNAME = 'Mitchell';

--UPDATE ARTIST NAME IN ARTIST TABLE FROM "Creedence Clearwater Revival" TO "CCR"
UPDATE ARTIST
SET NAME = 'CCR'
WHERE NAME ='Creedence Clearwater Revival';

-- CREATE AN INNER JOIN FOR CUSTOMERS AND ORDERS AND SPECIFIES THE CUSTOMER AND INVOICEID
SELECT I.INVOICEID AS INVOICE , C. FIRSTNAME AS FIRSTNAME, C.LASTNAME AS LASTNAME
FROM INVOICE I
INNER JOIN CUSTOMER C
ON I.CUSTOMERID = C.CUSTOMERID
ORDER BY I.INVOICEID ASC;

--CREATE AN OUTER  JOIN THAT JOINS THE CUSTOMER AND INVOICE TABLE, SPECIFYING THE CUSTOMERID AND INVOICEID
SELECT I.INVOICEID AS INVOICE, CONCAT(C.FIRSTNAME, CONCAT(' ', C.LASTNAME)) AS CUSTOMER_NAME, C.CUSTOMERID AS ID, I.TOTAL 
FROM INVOICE I
FULL OUTER JOIN CUSTOMER C
ON I.CUSTOMERID = C.CUSTOMERID
ORDER BY I.INVOICEID ASC;

--CREATE A RIGHT JOIN THAT JOINS ALBUM AND ARTIST SPECIFYING ARTIST NAME AND TITLE
SELECT A.TITLE, B.NAME
FROM ALBUM A
RIGHT JOIN ARTIST B
ON A.ARTISTID = B.ARTISTID
ORDER BY A.ARTISTID ASC;

--CREATE A CROSS JOIN THAT JOINS ALBUM AND ARTIST AND SORTS BY ARTISTNAME IN ASCENDING ORDER
SELECT *
FROM ALBUM
CROSS JOIN ARTIST
ORDER BY ARTIST.NAME ASC;

--CREATE A SELF JOIN ON THE EMPLOYEE TABLE JOINING ON THE REPORTSTO COLUMN
SELECT CONCAT(B1.FIRSTNAME, CONCAT(' ', B1.LASTNAME)) AS EMPLOYEE,CONCAT(A1.FIRSTNAME, CONCAT(' ', A1.LASTNAME)) AS MANAGER
FROM EMPLOYEE B1, EMPLOYEE A1
WHERE B1.REPORTSTO = A1.EMPLOYEEID
ORDER BY B1.REPORTSTO ASC;

--CREATE A QUEARY THAT SHOWS THE CUSTOMER FULL_NAME WITH THE TOTAL AMOUNT THEY HAVE SPENT AS TOTAL
SELECT CONCAT(C.FIRSTNAME, CONCAT(' ', C.LASTNAME)) AS FULL_NAME,  SUM(I.TOTAL) AS TOTAL
FROM CUSTOMER C
JOIN INVOICE I
ON C.CUSTOMERID = I.CUSTOMERID 
GROUP BY C.CUSTOMERID, CONCAT(C.FIRSTNAME, CONCAT(' ', C.LASTNAME))
ORDER BY C.CUSTOMERID ASC;

--CREATE A QUEARY THAT SHOWS THE EMPLOYEE WHO HAS MADE THE HIGHEST TOTAL VALUE OF SALES
SELECT CONCAT(E.FIRSTNAME, CONCAT(' ', E.LASTNAME)) AS EMPLOYEE_NAME,  COUNT(I.CUSTOMERID) AS NUM_OF_SALES
FROM EMPLOYEE E
JOIN CUSTOMER C
ON C.SUPPORTREPID = E.EMPLOYEEID
JOIN INVOICE I
ON C.CUSTOMERID = I.CUSTOMERID 
GROUP BY CONCAT(E.FIRSTNAME, CONCAT(' ', E.LASTNAME))
ORDER BY COUNT(I.CUSTOMERID) DESC
FETCH NEXT 1 ROW ONLY;

--CREATE A QUERY WHICH SHOWS THE NUMBER OF PURCHASES PER EACH GENRE. DISPLAY THE NAME OF EACH GENRE AND THE NUMER OF PURCHASES
SELECT G.NAME, COUNT(G.GENREID) AS NUM_OF_SALES
FROM GENRE G
INNER JOIN TRACK T
ON G.GENREID = T.GENREID
JOIN INVOICELINE IL
ON T.TRACKID = IL.TRACKID
JOIN INVOICE I
ON IL.INVOICEID=I.INVOICEID 
GROUP BY G.NAME
ORDER BY COUNT( G.GENREID) DESC;

-- Create a function that returns the current time.	
create or replace FUNCTION MY_TIME
RETURN VARCHAR2
IS
BEGIN
 RETURN CURRENT_TIMESTAMP;
END;
/

SELECT MY_TIME
FROM DUAL;

--create a function that returns the length of name in MEDIATYPE table
CREATE OR REPLACE FUNCTION MY_LENGTH(X VARCHAR2)
RETURN NUMBER
IS
BEGIN
RETURN LENGTH(X);
END;
/

SELECT MY_LENGTH(NAME)
FROM MEDIATYPE;

--Create a function that returns the average total of all invoices 
create or replace FUNCTION MY_AVG
RETURN NUMBER
IS
TOTAL_AVG INVOICE.TOTAL%TYPE;
BEGIN
SELECT AVG(TOTAL) INTO TOTAL_AVG
FROM INVOICE;
RETURN TOTAL_AVG;
END;
/

SELECT MY_AVG
FROM DUAL;

commit;

--Create a function that returns the most expensive track
 CREATE OR REPLACE FUNCTION MAX_PRICE_TRACK
 RETURN VARCHAR2
 IS 
 MAX_TRACK NUMBER;
 BEGIN
 SELECT MAX(UNITPRICE) INTO MAX_TRACK
 FROM TRACK ;
 RETURN MAX_TRACK;
 END;
 /

SELECT MAX_PRICE_TRACK
FROM DUAL;

-- Create a function that returns the average price of invoiceline items in the invoiceline table
CREATE OR REPLACE FUNCTION INVOICELINE_AVG
RETURN NUMBER
IS
INAVG NUMBER(3,2);
BEGIN
SELECT AVG(UNITPRICE) INTO INAVG
FROM INVOICELINE;
RETURN INAVG;
END;
/

SELECT INVOICELINE_AVG
FROM DUAL;

--Create a function that returns all employees who are born after 1968.
CREATE OR REPLACE FUNCTION AFTER1968
RETURN  SYS_REFCURSOR
IS BDAY SYS_REFCURSOR;
BEGIN
OPEN BDAY
FOR
SELECT FIRSTNAME,LASTNAME, BIRTHDATE
FROM EMPLOYEE
WHERE BIRTHDATE > DATE '1968-01-01' ;
RETURN BDAY;
END;
/

DECLARE
 NAME_GET  SYS_REFCURSOR:= AFTER1968();
 NAME_FN EMPLOYEE.FIRSTNAME%TYPE;
 NAME_LN  EMPLOYEE.LASTNAME%TYPE;
 BIRTH_DAY EMPLOYEE.BIRTHDATE%TYPE;

BEGIN
 LOOP
       FETCH NAME_GET INTO
        NAME_FN, NAME_LN, BIRTH_DAY;
       EXIT WHEN NAME_GET%NOTFOUND;
       DBMS_OUTPUT.PUT_LINE((NAME_FN || ' ' ||NAME_LN) || ' ' || BIRTH_DAY);
   END LOOP;
   CLOSE NAME_GET;
END;


--Create a stored procedure that selects the first and last names of all the employees.--
CREATE OR REPLACE PROCEDURE ALL_NAMES(NAMES OUT SYS_REFCURSOR)
IS
BEGIN
OPEN NAMES FOR
SELECT FIRSTNAME, LASTNAME
FROM EMPLOYEE
ORDER BY FIRSTNAME;
END;
/

DECLARE 
    MY_EMP_NAMES SYS_REFCURSOR;
    EMP_FN EMPLOYEE.FIRSTNAME%TYPE;
    EMP_LN EMPLOYEE.LASTNAME%TYPE;
BEGIN
    ALL_NAMES(MY_EMP_NAMES);
    LOOP
        FETCH MY_EMP_NAMES INTO EMP_FN, EMP_LN;
        EXIT WHEN MY_EMP_NAMES%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(EMP_FN|| ' ' ||EMP_LN);
        END LOOP;
        CLOSE MY_EMP_NAMES;
END;
/

COMMIT;

--Create a stored procedure that updates the personal information of an employee.
--CREATE OR REPLACE  PROCEDURE EMP_INFO_UPDATE( NEW_LAST VARCHAR2, NEW_ADDRESS VARCHAR2, 
--NEW_CITY VARCHAR2, NEW_STATE VARCHAR2, NEW_COUNTRY VARCHAR2, 
--NEW_ZIP EMPLOYEE.POSTALCODE%TYPE)
--IS
--    CURRENT_LASTNAME EMPLOYEE.LASTNAME%TYPE;
--    CURRENT_ADDRESS EMPLOYEE.ADDRESS%TYPE;
--    CURRENT_CITY EMPLOYEE.CITY%TYPE;
--    CURRENT_STATE EMPLOYEE.STATE%TYPE;
--    CURRENT_COUNTRY EMPLOYEE.COUNTY%TYPE;
--    CURRENT_ZIP EMPLOYEE.POSTALCODE%TYPE;
--BEGIN
--SELECT LASTNAME. ADDRESS, CITY, STATE, COUNTRY, POSTALCODE INTO CURRENT_LASTNAME, CURRENT_ADDRESS, CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY, CURRENT_ZIP
--FROM EMPLOYEE
--WHERE CURRENT_LASTNAME= NEW_LAST; CURRENT_ADDRESS=NEW_ADDRESS; CURRENT_CITY=NEW_CITY, CURRENT_STATE=NEW_STATE, CURRENT_COUNTRY=NEW_COUNTRY, CURRENT_ZIP=NEW_ZIP

CREATE OR REPLACE  PROCEDURE EMP_INFO_UPDATE(EMP_ID NUMBER, NEW_LAST VARCHAR2, NEW_ADDRESS VARCHAR2)
IS    
BEGIN
UPDATE EMPLOYEE
SET LASTNAME = NEW_LAST, ADDRESS = NEW_ADDRESS
WHERE EMPLOYEEID = EMP_ID;

DBMS_OUTPUT.PUT_LINE('INFO UPDATED');
END;
/

SET SERVEROUTPUT ON;
EXEC EMP_INFO_UPDATE(1, 'Banana', '3454 Code For Life Circle');

--Create a stored procedure that returns the managers of an employee.
CREATE OR REPLACE PROCEDURE EMP_MANAGER(EMP_ID NUMBER)
IS
EMP_NAME VARCHAR2(25);
MANA_ID NUMBER(5);
BEGIN
SELECT FIRSTNAME, REPORTSTO INTO EMP_NAME, MANA_ID
FROM EMPLOYEE
WHERE EMPLOYEEID = EMP_ID;
DBMS_OUTPUT.PUT_LINE(EMP_NAME||' MANAGER IS '||MANA_ID);
END;
/

SET SERVEROUTPUT ON;
EXEC EMP_MANAGER(7);


--Create a stored procedure that returns the name and company of a customer.
CREATE OR REPLACE PROCEDURE CUSTOMER_COMP(CUST OUT SYS_REFCURSOR)
IS
BEGIN
OPEN CUST FOR
SELECT FIRSTNAME, COMPANY
FROM CUSTOMER
ORDER BY FIRSTNAME;
END;
/

DECLARE 
    CUST_COM SYS_REFCURSOR;
    CUST_FN CUSTOMER.FIRSTNAME%TYPE;
    COMP_NAME CUSTOMER.COMPANY%TYPE;
BEGIN
    CUSTOMER_COMP(CUST_COM);
    LOOP
        FETCH CUST_COM INTO CUST_FN, COMP_NAME;
        EXIT WHEN CUST_COM%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('THE CUSTOMER  '||CUST_FN||'WORKS FOR '||COMP_NAME);
        END LOOP;
        CLOSE CUST_COM;
END;
/

--Create a transaction that given a invoiceId will delete that invoice (There may be constraints that rely on this, find out how to resolve them).
BEGIN
DELETE FROM INVOICEline WHERE INVOICEID = 1;
DELETE FROM INVOICE WHERE INVOICEID = 1;
END;
/

--Create a transaction nested within a stored procedure that inserts a new record in the Customer table
CREATE OR REPLACE PROCEDURE NEW_EMP(
EMP_ID NUMBER,
EMP_LAST VARCHAR2,
EMP_FIRST VARCHAR2,
EMP_TITLE VARCHAR2,
MANAGER_ID NUMBER,
EMP_BIRTH DATE,
EMP_HIRE DATE,
EMP_ADDRESS VARCHAR2,
EMP_CITY VARCHAR2,
EMP_STATE VARCHAR2,
EMP_COUNTRY VARCHAR2,
EMP_ZIP VARCHAR2,
EMP_NUM VARCHAR2,
EMP_FAX VARCHAR2,
EMP_EMAIL VARCHAR2)
IS
BEGIN
INSERT INTO EMPLOYEE
VALUES(EMP_ID, EMP_LAST, EMP_FIRST, EMP_TITLE, MANAGER_ID, EMP_BIRTH, EMP_HIRE, EMP_ADDRESS, EMP_CITY, EMP_STATE, EMP_COUNTRY, EMP_ZIP, EMP_NUM,EMP_FAX,EMP_EMAIL);
END;
/


SET SERVEROUTPUT ON;
EXEC NEW_EMP(11,'Rogers', 'Dave', 'Moral Suport Associate', 1, DATE '1990-04-23', DATE '2019-01-23', '643 Love All Street', 'Anthony', 'NM', 'UNITED STATES OF AMERICA', 88021, '+1 (915) 456 9087','+1 (915) 456 9087', 'd.rodgers@gmail.com');

--Create an after insert trigger on the employee table fired after a new record is inserted into the table.
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER PRIOR_INSERT
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
ENABLE
DECLARE
  v_user  VARCHAR2 (15);
BEGIN
 SELECT user INTO v_user FROM dual;
 DBMS_OUTPUT.PUT_LINE('INSERTION SUCCESSFUL'|| v_user); 
END;
/

--Create an after update trigger on the album table that fires after a row is inserted in the table
CREATE OR REPLACE TRIGGER AFTER_ALBUM
AFTER UPDATE ON ALBUM
FOR EACH ROW
ENABLE
BEGIN
 DBMS_OUTPUT.PUT_LINE('ALBUM UPDATE SUCCESSFUL'); 
END;
/

UPDATE ALBUM
SET TITLE = 'THERE WAS ROCK'
WHERE ALBUMID = 4 AND ARTISTID = 1;

--Create an after delete trigger on the customer table that fires after a row is deleted from the table.
CREATE OR REPLACE TRIGGER AFTER_DEL_CUST
AFTER DELETE ON CUSTOMER
FOR EACH ROW
ENABLE
BEGIN
 DBMS_OUTPUT.PUT_LINE('CUSTOMER DELETED SUCESSFULLY'); 
END;
/

DELETE CUSTOMER
WHERE CUSTOMERID = 61;







