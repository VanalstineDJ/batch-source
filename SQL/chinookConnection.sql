-------------
-- SQL LAB --
-------------



-- SECTION 2 QUERIES AND DML --

-- 2.1 SELECT --
-- a
SELECT * 
FROM EMPLOYEE;

-- b 
SELECT *
FROM EMPLOYEE
WHERE EMPLOYEE.LASTNAME = 'King';

-- c
SELECT * 
FROM EMPLOYEE
WHERE EMPLOYER.FIRSTNAME = 'Andrew' AND EMPLOYEE.REPORTSTO IS NULL;

-- d
SELECT *
FROM ALBUM
ORDER BY ALBUM.TITLE DESC;

-- e
SELECT C.FIRSTNAME
FROM CUSTOMER C
ORDER BY C.CITY ASC;

-- f
SELECT *
FROM INVOICE
WHERE BILLINGADDRESS LIKE 'T%';

SAVEPOINT SELECTDONE;
COMMIT;

-- 2.2 INSERT INTO --
-- a
INSERT INTO GENRE VALUES (26, 'Punk Rock');
INSERT INTO GENRE VALUES (27, 'Crossover');

 -- b
 
INSERT INTO EMPLOYEE VALUES (9, 'Krabs', 'Eugene', 'Sales Director', Null, TO_DATE('1943-11-17 00:00:00','yyyy-mm-dd hh24:mi:ss'), TO_DATE('1999-5-1 00:00:00','yyyy-mm-dd hh24:mi:ss'), '247 Bikini Bottom SW', 'Calgary', 'AB', 'Canada', 'T2P 2T3', '+1 (403) 484-1638', '+1 (403) 484-3912', 'krustykrab@chinookcorp.com');
INSERT INTO EMPLOYEE VALUES (10, 'Shape', 'Bob', 'Maintenance', 9, TO_DATE('1965-5-14 00:00:00','yyyy-mm-dd hh24:mi:ss'), TO_DATE('1995-6-1 00:00:00','yyyy-mm-dd hh24:mi:ss'), '782 Bikini Bottom W', 'Calgary', 'AB', 'Canada', 'T2P 2T3', '+1 (403) 288-2106', '+1 (403) 288-8943', 'ilovekrabbypatties@chinookcorp.com');

-- c

INSERT INTO INVOICE VALUES (413, 17, TO_DATE('2011-6-27 00:00:00','yyyy-mm-dd hh24:mi:ss'), '3245 82 Ave', 'Portland', 'OR', 'USA', '97299', 24.59);
INSERT INTO INVOICE VALUES (414, 44, TO_DATE('2004-2-3 00:00:00','yyyy-mm-dd hh24:mi:ss'), '1 Patriot Drive', 'Foxborough', 'MA', 'USA', '02035', 678.98);

SAVEPOINT INSERTDONE;
COMMIT;

-- 2.3 UPDATE --
-- a
UPDATE CUSTOMER
SET FIRSTNAME = 'Robert', LASTNAME = 'Walter'
WHERE FIRSTNAME = 'Aaron' AND LASTNAME = 'Mitchell';

UPDATE ARTIST
SET NAME = 'CCR'
WHERE NAME = 'Creedence Clearwater Revival';

SAVEPOINT UPDATESDONE;
COMMIT;

-- SECTION 3: JOINS --

-- 3.1 INNER JOIN --
SELECT C.FIRSTNAME AS FIRST_NAME, C.LASTNAME AS LAST_NAME, I.INVOICEID AS INVOICE_ID
FROM CUSTOMER C
JOIN INVOICE I
ON C.CUSTOMERID = I.CUSTOMERID;
COMMIT;

-- 3.2 OUTER JOIN --
SELECT C.CUSTOMERID AS CUSTOMER_ID,C.FIRSTNAME AS FIRST_NAME, C.LASTNAME AS LAST_NAME, I.INVOICEID AS INVOICE_ID, I.TOTAL AS TOTAL
FROM CUSTOMER C
JOIN INVOICE I
ON C.CUSTOMERID = I.CUSTOMERID;
COMMIT;

-- 3.3 RIGHT JOIN --
SELECT AL.TITLE AS ALBUM, AR.NAME AS ARTIST
FROM ALBUM AL
RIGHT JOIN ARTIST AR
ON AR.ARTISTID = AL.ARTISTID;
COMMIT;

-- 3.4 CROSS JOIN --
SELECT AL.TITLE AS ALBUM, AR.NAME AS ARTIST
FROM ALBUM AL
RIGHT JOIN ARTIST AR
ON AR.ARTISTID = AL.ARTISTID
ORDER BY AR.NAME ASC;
COMMIT;

-- 3.5 SELF JOIN --
SELECT E.EMPLOYEEID AS EMPLOYEE_ID, CONCAT(E.FIRSTNAME, CONCAT(' ', E.LASTNAME)) AS EMPLOYEE, CONCAT(M.FIRSTNAME, CONCAT(' ', M.LASTNAME)) AS MANAGER
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.REPORTSTO = M.EMPLOYEEID
ORDER BY E.EMPLOYEEID ASC;
COMMIT;

-- 3.6 JOINED QUERIES --
-- a
SELECT C.CUSTOMERID AS ID, CONCAT(C.FIRSTNAME, CONCAT(' ', C.LASTNAME)) AS FULL_NAME, SUM(I.TOTAL) AS TOTAL
FROM CUSTOMER C
LEFT JOIN INVOICE I
ON C.CUSTOMERID = I.CUSTOMERID
GROUP BY C.CUSTOMERID, CONCAT(C.FIRSTNAME, CONCAT(' ', C.LASTNAME))
ORDER BY C.CUSTOMERID ASC;
COMMIT;

-- b
SELECT *
FROM
    (SELECT CONCAT(E.FIRSTNAME, CONCAT(' ', E.LASTNAME)) AS EMPLOYEE, SUM(I.INVOICEID) AS TOTAL_SALES
    FROM EMPLOYEE E  
    JOIN CUSTOMER C
    ON C.SUPPORTREPID = E.EMPLOYEEID
    JOIN INVOICE I
    ON I.CUSTOMERID = C.CUSTOMERID
    GROUP BY CONCAT(E.FIRSTNAME, CONCAT(' ', E.LASTNAME))
    ORDER BY SUM(I.INVOICEID) DESC)
WHERE ROWNUM = 1;

COMMIT;

-- c
SELECT G.NAME AS GENRE, SUM(I.INVOICEID) AS TOTAL_SALES
FROM GENRE G 
JOIN TRACK T
ON G.GENREID = T.GENREID
JOIN INVOICELINE IL
ON IL.TRACKID = T.TRACKID
JOIN INVOICE I
ON I.INVOICEID = IL.INVOICEID
GROUP BY G.NAME
ORDER BY SUM(I.INVOICEID) DESC;

SAVEPOINT JOINSDONE;
COMMIT;

-- SECTION 4 SQL FUNCTIONS --

-- 4.1 SYSTEM DEFINED FUNCTIONS --
SET SERVEROUTPUT ON;
COMMIT;
-- a 
CREATE OR REPLACE FUNCTION TIMEFUNCTION
RETURN TIMESTAMP
IS
BEGIN
    RETURN CURRENT_TIMESTAMP;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('CURRENT TIME: ' || TIMEFUNCTION());
END;
/

COMMIT;
-- b
CREATE OR REPLACE FUNCTION FIND_LENGTH(X VARCHAR2)
RETURN NUMBER
IS 
Y NUMBER;
BEGIN
    Y := LENGTH(X);
    RETURN Y;
END;
/

SELECT FIND_LENGTH(M.NAME)
FROM MEDIATYPE M
WHERE MEDIATYPEID = 1;

SAVEPOINT SYSDEFINEDFUNCTIONS;
COMMIT;

-- 4.2 SYSTEM DEFINED AGGREGATE FUNCTIONS --
-- a
CREATE OR REPLACE FUNCTION FIND_AVG_TOTAL
RETURN NUMBER 
IS TOTAL NUMBER(5,2);
BEGIN
    SELECT AVG(I.TOTAL) INTO TOTAL 
    FROM INVOICE I;
    RETURN TOTAL;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('AVG INVOICE TOTAL: $' || FIND_AVG_TOTAL());
END;
/
COMMIT;


-- b
CREATE OR REPLACE FUNCTION MOST_EXPENSIVE_TRACK
RETURN NUMBER
IS PRICIEST_TRACK NUMBER(5,2);
BEGIN
    SELECT MAX(T.UNITPRICE) INTO PRICIEST_TRACK
    FROM TRACK T;
    RETURN PRICIEST_TRACK;
END;
/

SELECT T.NAME AS MOST_EXPENSIVE_TRACKS
FROM TRACK T
WHERE T.UNITPRICE = MOST_EXPENSIVE_TRACK();

BEGIN
    DBMS_OUTPUT.PUT_LINE('MOST EXPENSIVE TRACK IS: $' || MOST_EXPENSIVE_TRACK());
END;
/

SAVEPOINT AGGREGATEFUNCTIONS;
COMMIT;

-- 4.3 USER DEFINED SCALAR FUNCTIONS --
-- a
CREATE OR REPLACE FUNCTION AVG_INVOICELINE_PRICE
RETURN NUMBER 
IS
UNITS NUMBER;
TOTAL_PRICE NUMBER;
AVG_PRICE NUMBER(5,2);
BEGIN
    SELECT COUNT(I.INVOICEID), SUM(I.UNITPRICE) INTO UNITS, TOTAL_PRICE 
    FROM INVOICELINE I;
    AVG_PRICE := TOTAL_PRICE/UNITS;
    RETURN AVG_PRICE;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('AVERAGE INVOICELINE PRICE: $' || AVG_INVOICELINE_PRICE());
END;
/

SAVEPOINT USERDEFINEDFUNCS;
COMMIT;

-- 4.4 USER DEFINED TABLE VALUE FUNCTIONS --
-- a
CREATE OR REPLACE FUNCTION POSTSIXTYEIGHT
RETURN SYS_REFCURSOR
IS PERSON SYS_REFCURSOR;
BEGIN
    OPEN PERSON FOR
    SELECT E.BIRTHDATE, E.FIRSTNAME, E.LASTNAME
    FROM EMPLOYEE E
    WHERE E.BIRTHDATE > '31-DEC-68';
    RETURN PERSON;
END;
/

DECLARE
    SVAR SYS_REFCURSOR := POSTSIXTYEIGHT;
    DOB EMPLOYEE.BIRTHDATE%TYPE;
    FIRST_NAME EMPLOYEE.FIRSTNAME%TYPE;
    LAST_NAME EMPLOYEE.LASTNAME%TYPE;
BEGIN
    LOOP
        FETCH SVAR INTO DOB, FIRST_NAME, LAST_NAME;
        EXIT WHEN SVAR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('EMPLOYEE: ' || FIRST_NAME ||' '|| LAST_NAME ||' DOB: '|| DOB);
    END LOOP;
    CLOSE SVAR;
END;
/

SAVEPOINT USERDEFINEDTABLEVALUEDFUNCTION;
COMMIT;

-- SECTION 5 STORED PROCEDURES --

-- 5.1 Basic Stored Procedure --
--a
CREATE OR REPLACE PROCEDURE EMPLOYEE_NAMES(S OUT SYS_REFCURSOR)
IS
BEGIN
    OPEN S FOR
    SELECT E.FIRSTNAME, E.LASTNAME
    FROM EMPLOYEE E
    ORDER BY E.LASTNAME;
END;
/

DECLARE
    SVAR SYS_REFCURSOR;
    TEMP_FIRST EMPLOYEE.FIRSTNAME%TYPE;
    TEMP_LAST EMPLOYEE.LASTNAME%TYPE;
BEGIN
    EMPLOYEE_NAMES(SVAR);
    LOOP
        FETCH SVAR INTO TEMP_FIRST, TEMP_LAST;
        EXIT WHEN SVAR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(TEMP_FIRST || ' ' || TEMP_LAST);
    END LOOP;
    CLOSE SVAR;
END;
/

SAVEPOINT BASICSTOREDPROCEDURE;
COMMIT;

-- 5.2 Strored Procedure Input Parameters --
--a
CREATE OR REPLACE PROCEDURE UPDATE_EMPLOYEE(EMP IN EMPLOYEE.EMPLOYEEID%TYPE, 
                                        NEWLASTNAME IN EMPLOYEE.LASTNAME%TYPE, 
                                        NEWFIRSTNAME IN EMPLOYEE.FIRSTNAME%TYPE,
                                        NEWTITLE IN EMPLOYEE.TITLE%TYPE,
                                        NEWREPORTSTO IN EMPLOYEE.REPORTSTO%TYPE,
                                        NEWPHONE IN EMPLOYEE.PHONE%TYPE,
                                        NEWFAX IN EMPLOYEE.LASTNAME%TYPE,
                                        NEWEMAIL IN EMPLOYEE.EMAIL%TYPE)
IS
BEGIN
    UPDATE EMPLOYEE
    SET LASTNAME = NEWLASTNAME, FIRSTNAME = NEWFIRSTNAME, TITLE = NEWTITLE, REPORTSTO = NEWREPORTSTO, PHONE = NEWPHONE, FAX = NEWFAX, EMAIL = NEWEMAIL
    WHERE EMPLOYEEID = EMP;
END;
/

BEGIN
    UPDATE_EMPLOYEE(8, 'Lance', 'Laural', 'IT Staff', 6, '+1 (780) 435-9976', '+1 (780) 435-5546', 'llance@chinookcorp.com');
END;

SAVEPOINT UPDATEEMPLOYEE;
COMMIT;

--b
CREATE OR REPLACE PROCEDURE FIND_MANAGERS(EMP IN EMPLOYEE.EMPLOYEEID%TYPE, S OUT SYS_REFCURSOR)
IS
BEGIN
      OPEN S FOR
        SELECT M.FIRSTNAME, M.LASTNAME
        FROM EMPLOYEE M, EMPLOYEE E
        WHERE M.EMPLOYEEID = 
            (SELECT E.REPORTSTO
            FROM EMPLOYEE E
            WHERE  E.EMPLOYEEID = EMP);
END;
/

DECLARE
    SVAR SYS_REFCURSOR;
    TEMP_FIRST_NAME EMPLOYEE.FIRSTNAME%TYPE;
    TEMP_LAST_NAME EMPLOYEE.LASTNAME%TYPE;
BEGIN
    FIND_MANAGERS(10, SVAR);
    FETCH SVAR INTO TEMP_FIRST_NAME, TEMP_LAST_NAME;
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE MANAGER NAME: ' || TEMP_FIRST_NAME || ' ' || TEMP_LAST_NAME);
    CLOSE SVAR;
END;
/

SAVEPOINT GETEMPLOYEEMANAGER;
COMMIT;

-- 5.3 Stored Procedure Output Parameters --
-- a
CREATE OR REPLACE PROCEDURE CUSTOMER_INFO(CUS IN CUSTOMER.CUSTOMERID%TYPE, S OUT SYS_REFCURSOR)
IS
BEGIN
    OPEN S FOR
    SELECT C.FIRSTNAME, C.LASTNAME, C.COMPANY
    FROM CUSTOMER C
    WHERE C.CUSTOMERID = CUS;
END;
/

DECLARE
    SVAR SYS_REFCURSOR;
    TEMP_FIRST_NAME CUSTOMER.FIRSTNAME%TYPE;
    TEMP_LAST_NAME CUSTOMER.LASTNAME%TYPE;
    TEMP_COMPANY CUSTOMER.COMPANY%TYPE;
BEGIN
    CUSTOMER_INFO(16, SVAR);
    FETCH SVAR INTO TEMP_FIRST_NAME, TEMP_LAST_NAME, TEMP_COMPANY;
    DBMS_OUTPUT.PUT_LINE('CUSTOMER NAME: ' || TEMP_FIRST_NAME || ' ' || TEMP_LAST_NAME || ' ' || 'COMPANY: ' || TEMP_COMPANY);
    CLOSE SVAR;
END;
/

SAVEPOINT CUSTOMERINFO;
COMMIT;

-- SECTION 6 TRANSACTIONS --

-- 6.0 Transactions --
-- a
ALTER TABLE INVOICELINE
DROP CONSTRAINT FK_INVOICELINEINVOICEID;
/

ALTER TABLE INVOICE
DROP CONSTRAINT FK_INVOICECUSTOMERID;
/

BEGIN  
    DELETE FROM INVOICE I
    WHERE I.INVOICEID = INVID;
END;
/

BEGIN
    DELETE_INVOICE(137);
END;
/ 

SAVEPOINT TRANS1;
COMMIT;

-- b
CREATE OR REPLACE PROCEDURE INSERT_CUSTOMER(S OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN S FOR
    SELECT C.CUSTOMERID, C.FIRSTNAME, C.LASTNAME, C.COMPANY, C.ADDRESS, C.CITY, C.STATE, C.COUNTRY, C.POSTALCODE, C.PHONE, C.FAX, C.EMAIL, C.SUPPORTREPID
    FROM CUSTOMER C;
END;
/

DECLARE
    S SYS_REFCURSOR;
    NEW_ID CUSTOMER.CUSTOMERID%TYPE;
    NEW_FIRSTNAME CUSTOMER.FIRSTNAME%TYPE;
    NEW_LASTNAME CUSTOMER.LASTNAME%TYPE;
    NEW_COMPANY CUSTOMER.COMPANY%TYPE;
    NEW_ADDRESS CUSTOMER.ADDRESS%TYPE;
    NEW_CITY CUSTOMER.CITY%TYPE;
    NEW_STATE CUSTOMER.STATE%TYPE;
    NEW_COUNTRY CUSTOMER.COUNTRY%TYPE;
    NEW_ZIP CUSTOMER.POSTALCODE%TYPE;
    NEW_PHONE CUSTOMER.PHONE%TYPE;
    NEW_FAX CUSTOMER.FAX%TYPE;
    NEW_EMAIL CUSTOMER.EMAIL%TYPE;
    NEW_SUPPORTREP CUSTOMER.SUPPORTREPID%TYPE;
BEGIN
    INSERT INTO CUSTOMER VALUES (60, 'D. J.', 'Valentine', '2k Sports', '1260 NW Naito Pkwy', 'Portland', 'OR', 'USA', '97209', '+1 (925) 657-8935', NULL, 'flamethrower@nba2k.com', 9);
    INSERT_CUSTOMER(S);
    FETCH S INTO NEW_ID, NEW_FIRSTNAME, NEW_LASTNAME, NEW_COMPANY, NEW_ADDRESS, NEW_CITY, NEW_STATE, NEW_COUNTRY, NEW_ZIP, NEW_PHONE, NEW_FAX, NEW_EMAIL, NEW_SUPPORTREP;
    CLOSE S;
END;
/

SAVEPOINT TRANS2;
COMMIT;

-- SECTION 7 TRIGGERS --




