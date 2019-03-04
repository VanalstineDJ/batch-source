CREATE TABLE DEPARTMENT(
    DEPT_ID NUMBER(5) CONSTRAINT PK_DEPT PRIMARY KEY,
    DEPT_NAME VARCHAR2(50),
    MONTHLY_BUDGET NUMBER(5,2)
);

CREATE TABLE EMPLOYEE(
    EMP_ID NUMBER(5) PRIMARY KEY,
    EMP_NAME VARCHAR2(50),
    BIRTHDAY DATE,
    MONTHLY_SALARY NUMBER(5,2) NOT NULL,
    POSITION VARCHAR2(20),
    MANAGER_ID NUMBER(5),
    DEPT_ID NUMBER(5) CONSTRAINT FK_EMP_DEPT REFERENCES DEPARTMENT
);


ALTER TABLE DEPARTMENT
MODIFY MONTHLY_BUDGET NUMBER(7,2);

ALTER TABLE EMPLOYEE
MODIFY MONTHLY_SALARY NUMBER(7,2);

ALTER TABLE EMPLOYEE
ADD HIRE_DATE DATE;

-- THIS WOULD NOT INSERT, AS WE DO NOT HAVE A RECORD IN OUR DEPARTMENT TABLE WITH AN ID OF 2
--INSERT INTO EMPLOYEE VALUES (1, 'JOHN SMITH', DATE '1988-02-26', 2800, 'MK_REP', NULL, 2, DATE '2018-10-12');
    
-- INSERTING RECORDS INTO OUR DEPARTMENT TABLE
INSERT INTO DEPARTMENT VALUES (1,'HUMAN RESOURCES', 8000);
INSERT INTO DEPARTMENT VALUES (2,'MARKETING',9000);
INSERT INTO DEPARTMENT VALUES (3, 'ACCOUNTING', 5800);
INSERT INTO DEPARTMENT VALUES (4, 'INFORMATION TECHNOLOGY', 3500);
INSERT INTO DEPARTMENT VALUES (5, 'LEGAL', 1);
INSERT INTO DEPARTMENT VALUES (6, 'CUSTOMER SERVICE', 5800);
INSERT INTO DEPARTMENT (DEPT_ID, DEPT_NAME) VALUES (7, 'SALES');


SELECT * 
FROM DEPARTMENT;

SELECT DEPT_NAME
FROM DEPARTMENT;

-- THIS IS REFERENCED BY EMPLOYEE AND CANNOT BE DROPPED
DROP TABLE DEPARTMENT;

ALTER TABLE EMPLOYEE
DROP CONSTRAINT FK_EMP_DEPT;

-- RECREATE FOREIGN KEY RELATIONSHIP BETWEEN EMPLOYEE AND DEPARTMENT TABLE
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_EMP_DEPT
FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID) ON DELETE CASCADE;

-- INSERT EMPLOYEE RECORDS
INSERT INTO EMPLOYEE VALUES (1, 'JOHN SMITH', DATE '1988-02-26', 2800, 'MK_REP', NULL, 2, DATE '2018-10-12');
INSERT INTO EMPLOYEE VALUES (2, 'JAMES BOSH', DATE '1982-03-04', 2900, 'ACCOUNT', NULL, 3, DATE '2019-01-04');
INSERT INTO EMPLOYEE VALUES (3, 'LISA JACKSON', DATE '1993-01-06', 3000, 'MK_REP', 1, 2, DATE '2018-12-12');
INSERT INTO EMPLOYEE VALUES (4, 'NIGEL OAKS', DATE '1987-03-04', 1900, 'ACCOUNT', 2, 3, DATE '2017-10-11');
INSERT INTO EMPLOYEE VALUES (5, 'ANGELA DEAN', DATE '1989-02-15', 3200, 'HR_COORD', NULL, 1, DATE '2017-04-05');
INSERT INTO EMPLOYEE VALUES (6, 'HOLLY JENKINS', DATE '1990-03-04', 2200, 'HR_ASSIST', 5, 1, DATE '2019-01-16');
      
SELECT *
FROM EMPLOYEE;

SELECT EMP_NAME
FROM EMPLOYEE;

SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID > 3;

--SELECT EMP_NAME, DEPT_ID
--FROM EMPLOYEE
--WHERE MANAGER_ID = NULL;

DELETE FROM EMPLOYEE
WHERE MONTHLY_SALARY>2900;

UPDATE EMPLOYEE
SET MONTHLY_SALARY = 3100
WHERE EMP_ID = 3;

UPDATE EMPLOYEE
SET MONTHLY_SALARY = 3300
WHERE EMP_ID = 5;

-- USING DQL TO MAKE MORE QUERIES 
SELECT EMP_NAME, MONTHLY_SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_ID = 5;

SELECT COUNT(EMP_ID) AS TOTAL_EMPLOYEES
FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE 'J%'
ORDER BY MONTHLY_SALARY DESC;

-- SELECT AVERAGE SALARY FROM EACH DEPARTMENT
SELECT AVG(MONTHLY_SALARY) AVG_SALARY
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING DEPT_ID<3;

SELECT *
FROM EMPLOYEE 
WHERE DEPT_ID = 1 OR DEPT_ID = 3 OR DEPT_ID = 5;

SELECT *
FROM EMPLOYEE
WHERE DEPT_ID IN (1,3,5);

-- USING A SUBQUERY
SELECT *
FROM EMPLOYEE 
WHERE MONTHLY_SALARY =  
    (SELECT MAX(MONTHLY_SALARY)
    FROM EMPLOYEE);


ROLLBACK TO MYSAVEPOINT;


-----------------------------------------
-- SET OPERATORS
-----------------------------------------
SELECT *
FROM EMPLOYEE
WHERE EMP_ID>3
UNION
SELECT * 
FROM EMPLOYEE
WHERE MONTHLY_SALARY>2900;

SELECT *
FROM
    (SELECT *
    FROM EMPLOYEE
    WHERE EMP_ID>3
    UNION ALL
    SELECT * 
    FROM EMPLOYEE
    WHERE MONTHLY_SALARY>2900)
ORDER BY MONTHLY_SALARY;

SELECT *
FROM EMPLOYEE
WHERE EMP_ID>3
MINUS
SELECT * 
FROM EMPLOYEE
WHERE MONTHLY_SALARY>2900;


SELECT * 
FROM EMPLOYEE
WHERE MONTHLY_SALARY>2900
MINUS
SELECT *
FROM EMPLOYEE
WHERE EMP_ID>3;

SELECT *
FROM EMPLOYEE
WHERE EMP_ID>3
INTERSECT
SELECT * 
FROM EMPLOYEE
WHERE MONTHLY_SALARY>2900;


CREATE TABLE EMPLOYEE2 AS 
    SELECT EMP_ID, EMP_NAME, MONTHLY_SALARY
    FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE
WHERE EMP_ID>3
UNION
SELECT * 
FROM EMPLOYEE2
WHERE MONTHLY_SALARY>2900;


SELECT EMP_ID, EMP_NAME, MONTHLY_SALARY
FROM EMPLOYEE
WHERE EMP_ID>3
UNION
SELECT * 
FROM EMPLOYEE2
WHERE MONTHLY_SALARY>2900;

--------------------------------------------
-- WORKING WITH JOINS
--------------------------------------------

INSERT INTO EMPLOYEE VALUES (7, 'LOLA JACKSON', DATE '1993-01-06', 3000, 'MK_REP', 1, 2, DATE '2018-12-12');
INSERT INTO EMPLOYEE VALUES (8, 'NICK OAKS', DATE '1987-03-04', 1900, 'ACCOUNT', 2, 3, DATE '2017-10-11');
INSERT INTO EMPLOYEE VALUES (9, 'ANNA DEAN', DATE '1989-02-15', 3200, 'HR_COORD', NULL, NULL, DATE '2017-04-05');
INSERT INTO EMPLOYEE VALUES (10, 'HARRIET JENKINS', DATE '1990-03-04', 2200, 'HR_ASSIST', 5, NULL, DATE '2019-01-16');
COMMIT;

-- INNER JOIN
SELECT E.EMP_NAME AS NAME, D.DEPT_NAME AS DEPARTMENT
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;

-- IMPLICIT JOIN
SELECT E.EMP_NAME AS NAME, D.DEPT_NAME AS DEPARTMENT
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- NATURAL JOIM
SELECT E.EMP_NAME AS NAME, D.DEPT_NAME AS DEPARTMENT
FROM EMPLOYEE E
NATURAL JOIN DEPARTMENT D;

-- FULL OUTER JOIN
SELECT E.EMP_NAME AS NAME, D.DEPT_NAME AS DEPARTMENT
FROM EMPLOYEE E
FULL JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;

-- RIGHT OUTER JOIN
SELECT E.EMP_NAME AS NAME, D.DEPT_NAME AS DEPARTMENT
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;

-- LEFT OUTER JOIN
SELECT E.EMP_NAME AS NAME, D.DEPT_NAME AS DEPARTMENT
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;

-- USING AN IMPLICIT INNER JOIN TO ACCOMPLISH A SELF JOIN
SELECT E1.EMP_NAME AS EMPLOYEE, E2.EMP_NAME AS MANAGER
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.MANAGER_ID = E2.EMP_ID;

-- CROSS JOIN
SELECT E.EMP_NAME, D.DEPT_NAME
FROM EMPLOYEE E
CROSS JOIN DEPARTMENT D;

-- FIND DEPARTMENT WITH THE MOST RECENT HIRE
SELECT D.*
FROM DEPARTMENT D
JOIN EMPLOYEE E
ON E.DEPT_ID = D.DEPT_ID
WHERE E.HIRE_DATE =
    (SELECT MAX(HIRE_DATE)
    FROM EMPLOYEE);
    
-- SUM OF EACH DEPARTMENT SALARY
SELECT D.DEPT_NAME, SUM(E.MONTHLY_SALARY) AS TOTAL
FROM DEPARTMENT D
JOIN EMPLOYEE E
ON E.DEPT_ID = D.DEPT_ID
GROUP BY D.DEPT_NAME;

-------------------------------------
-- ADDING LOCATIONS TABLE
-------------------------------------

CREATE TABLE LOCATIONS(
    LOCATION_ID NUMBER(5),
    STREET VARCHAR2(20),
    CITY VARCHAR2(20),
    STATE VARCHAR2(2),
    ZIPCODE NUMBER(5)
);
-- ADD A PRIMARY KEY
ALTER TABLE LOCATIONS
ADD CONSTRAINT PK_LOCATIONS PRIMARY KEY (LOCATION_ID);


-- MODIFY EMPLOYEE TABLE, ADDING A COLUMN FOR LOCATION
ALTER TABLE EMPLOYEE
ADD LOCATION_ID NUMBER(5);

ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_EMP_LOCATION
FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS;

-- ADD LOCATIONS TO TABLE
INSERT INTO LOCATIONS VALUES (1, '14 MAIN STREET', 'RESTON','VA',20190);
INSERT INTO LOCATIONS VALUES (2, '1060 TCHOPITOULAS ST', 'NEW ORLEANS', 'LA', 70118);
INSERT INTO LOCATIONS VALUES (3, '200 LOMBARD ST', 'SAN FRANCISCO', 'CA', 94109);
COMMIT;

INSERT INTO EMPLOYEE VALUES (11, 'ARIEL PAVIS', DATE '1981-09-23', 4500.00, 'LG_LAW', NULL, 5, DATE '2015-07-12',1);
INSERT INTO EMPLOYEE VALUES (12, 'MELISSA ITZKOVSKY', DATE '1983-03-03', 3870.00, 'LG_LAW',11, 5, DATE '2014-09-15',1);
INSERT INTO EMPLOYEE VALUES (13, 'MALIA FILISOV', DATE '1976-07-11', 4620.00, 'CS_REP', NULL, 6, DATE '2014-11-09',1);
INSERT INTO EMPLOYEE VALUES (14, 'BRENDAN LOUISET', DATE '1979-01-21', 3760.00, 'CS_REP',13, 6, DATE '2018-03-28',1);
INSERT INTO EMPLOYEE VALUES (15, 'MILT KLIEMANN', DATE '1983-02-25', 3820.00, 'AC_ACCOUNT', 2, 2, DATE '2016-05-01',1);
INSERT INTO EMPLOYEE VALUES (16, 'LUCILLE HUNE', DATE '1994-01-04', 2300.00, 'MK_REP',1, 1, DATE '2016-04-17',3);
INSERT INTO EMPLOYEE VALUES (17, 'PETA POLTZOLD', DATE '1990-09-24', 2500.00, 'IT_DEV',3, 3, DATE '2015-07-10',3);
INSERT INTO EMPLOYEE VALUES (18, 'LYDIA POVER', DATE '1991-10-01', 2800.00, 'IT_DEV', 17, 3, DATE '2016-08-03',1);
INSERT INTO EMPLOYEE VALUES (19, 'RON WINTERTON', DATE '1977-09-27', 2500.00, 'LG_LAW', 11, 5, DATE '2018-02-23',2);
INSERT INTO EMPLOYEE VALUES (20, 'NITIN CHESTNUT', DATE '1995-01-18', 2800.00, 'CS_REP', 13, 6, DATE '2014-10-25',2);
INSERT INTO EMPLOYEE VALUES (21, 'JILLIAN KYND', DATE '1980-10-15', 2840.00, 'AC_ACCOUNT', 2, 2, DATE '2015-05-11',2);
INSERT INTO EMPLOYEE VALUES (22, 'TIM KIBBEL', DATE '1980-05-20', 2240.00, 'MK_REP', 1, 1, DATE '2014-07-28',2);
INSERT INTO EMPLOYEE VALUES (23, 'ETHELIN COMINI', DATE '1982-06-16', 3380.00, 'IT_DEV', 3, 3, DATE '2017-10-02',2);
INSERT INTO EMPLOYEE VALUES (24, 'JASE HANDLEY', DATE '1975-10-08', 1870.00, 'LG_LAW',11, 5, DATE '2017-08-17',3);
COMMIT;

SELECT E.EMP_NAME, L.STATE
FROM EMPLOYEE E
JOIN LOCATIONS L
ON E.LOCATION_ID = L.LOCATION_ID;

SELECT E.EMP_NAME AS NAME, D.DEPT_NAME AS DEPARTMENT, CONCAT(L.CITY, CONCAT(', ',L.STATE)) AS LOCATION
FROM EMPLOYEE E
JOIN LOCATIONS L
ON E.LOCATION_ID = L.LOCATION_ID
JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;
----------------------------------------
CREATE VIEW DEPARTMENT_SPENDING AS
SELECT D.DEPT_NAME, SUM(E.MONTHLY_SALARY) AS TOTAL
FROM DEPARTMENT D
JOIN EMPLOYEE E
ON E.DEPT_ID = D.DEPT_ID
GROUP BY D.DEPT_NAME;

SELECT *
FROM DEPARTMENT_SPENDING;

UPDATE EMPLOYEE
SET MONTHLY_SALARY = 2200
WHERE EMP_ID = 6;

COMMIT;

-------------------------------------
-- WORKING WITH FUNCTIONS
-------------------------------------
-- HELLO WORLD FUNCTION
SET SERVEROUTPUT ON;

BEGIN 
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;
/

CREATE OR REPLACE FUNCTION SAY_HI
RETURN VARCHAR2
IS
BEGIN 
    RETURN 'HELLO WORLD FROM SQL DEVELOPER!!!';
END;
/

BEGIN 
    DBMS_OUTPUT.PUT_LINE(SAY_HI());
END;
/

CREATE OR REPLACE FUNCTION RETURN_NAME
RETURN VARCHAR2
IS
BEGIN 
    RETURN 'JOHN SMITH';
END;
/

SELECT *
FROM EMPLOYEE
WHERE EMP_NAME = RETURN_NAME();

RETURN_NAME();

SELECT RETURN_NAME();

SELECT RETURN_NAME() FROM DUAL;

SELECT 5 AS MY_NUM FROM DUAL;

DROP FUNCTION SAY_HI;

-- CREATE A FUNCTION WHICH TAKES A SINGLE NUMERIC INPUT AND RETURNS THE SQUARED VALUE OF THAT NUMBER
CREATE OR REPLACE FUNCTION SQUARE(X IN NUMBER)
RETURN NUMBER
IS
BEGIN
    RETURN X*X;
END;
/

DECLARE 
    N NUMBER:=5;
BEGIN
    DBMS_OUTPUT.PUT_LINE(SQUARE(N));
END;
/

SELECT 5 AS MY_NUM, SQUARE(5) AS MY_NUM_SQUARED FROM DUAL;

SELECT SQUARE(MONTHLY_SALARY)
FROM EMPLOYEE
WHERE EMP_ID=10;

-- DECLARING ADDITIONAL VALUES TO BE USED IN OUR FUNCTION
CREATE OR REPLACE FUNCTION SQUARE(X IN NUMBER)
RETURN NUMBER
IS
--ANY OTHER VARIABLES
Y NUMBER;
BEGIN
    Y := X*X;
    RETURN Y;
END;
/

-- FIND MAX BETWEEN TWO NUMERIC VARIABLES
CREATE OR REPLACE FUNCTION FIND_MAX(X NUMBER, Y NUMBER)
RETURN NUMBER
IS
Z NUMBER;
BEGIN 
    IF X>Y THEN
    Z := X;
    ELSE 
    Z := Y;
    END IF;
    RETURN Z;
END;
/

DECLARE 
    FIRST_NUM NUMBER;
    SECOND_NUM NUMBER;
    MAX_NUM NUMBER;
BEGIN 
    FIRST_NUM := 54;
    SECOND_NUM := 32;
    MAX_NUM := FIND_MAX(FIRST_NUM, SECOND_NUM);
    DBMS_OUTPUT.PUT_LINE('MAX: '||MAX_NUM);
END;
/

CREATE OR REPLACE FUNCTION APPLY_TAX(PRE_TAX IN NUMBER)
RETURN NUMBER
IS
POST_TAX NUMBER;
BEGIN 
    POST_TAX := (.80)*PRE_TAX;
    RETURN POST_TAX;
END;
/

SELECT EMP_NAME, MONTHLY_SALARY AS PRETAX, APPLY_TAX(MONTHLY_SALARY) AS POSTTAX
FROM EMPLOYEE;

CREATE OR REPLACE FUNCTION APPLY_TAX(PRE_TAX IN NUMBER)
RETURN NUMBER
IS
POST_TAX NUMBER;
BEGIN 
    IF 10000<PRE_TAX THEN
        POST_TAX := (.50)*PRE_TAX;
    ELSIF 3000<PRE_TAX THEN
        POST_TAX := (.71)*PRE_TAX;
    ELSIF 2000<PRE_TAX THEN
        POST_TAX := (.75)*PRE_TAX;
    ELSE 
        POST_TAX := (.78)*PRE_TAX;
    END IF;
    RETURN POST_TAX;
END;
/

-------------------------------------
-- CREATING STORED PROCEDURES
-------------------------------------
CREATE OR REPLACE PROCEDURE SAY_HI_PROCEDURE
IS
BEGIN 
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;
/

BEGIN
    SAY_HI_PROCEDURE();
END;
/

-- CREATE A PROCEDURE WHICH HAS AN OUTPUT PARAMETER OF A CURSOR
-- A CURSOR IS A POINTER TO A CONTEXT AREA, WHICH IS ESSENTIALLY A RESULT SET
-- IN THIS CASE OUR PROCEDURE WILL BE SAVING THE RESULT OF A QUERY ON OUR EMPLOYEE TABLE INTO OUR CURSOR
-- CURSORS ARE OFTEN USED TO STORE AND PROCESS QUERIED DATA
CREATE OR REPLACE PROCEDURE GET_ALL_EMPLOYEES(S OUT SYS_REFCURSOR)
IS
BEGIN 
    OPEN S FOR
    SELECT EMP_ID, EMP_NAME FROM EMPLOYEE ORDER BY EMP_ID;
END;
/

DECLARE
    SVAR SYS_REFCURSOR;
    TEMP_ID EMPLOYEE.EMP_ID%TYPE;
    TEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN 
    GET_ALL_EMPLOYEES(SVAR);
    LOOP
        FETCH SVAR INTO TEMP_ID, TEMP_NAME;
        EXIT WHEN SVAR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(TEMP_ID||' IS CURRENT ID, '||TEMP_NAME||' IS CURRENT NAME');
    END LOOP;
    CLOSE SVAR;
END;
/


CREATE OR REPLACE PROCEDURE GET_FROM_DEPARTMENT(S OUT SYS_REFCURSOR, DEPT IN VARCHAR)
IS
BEGIN 
    OPEN S FOR
        SELECT EMP_ID, EMP_NAME 
        FROM EMPLOYEE 
        WHERE DEPT_ID = 
            (SELECT DEPT_ID
            FROM DEPARTMENT
            WHERE DEPT_NAME = DEPT);
END;
/

DECLARE
    SVAR SYS_REFCURSOR;
    TEMP_ID EMPLOYEE.EMP_ID%TYPE;
    TEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN 
    GET_FROM_DEPARTMENT(SVAR,'MARKETING');
    LOOP
        FETCH SVAR INTO TEMP_ID, TEMP_NAME;
        EXIT WHEN SVAR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(TEMP_ID||' IS CURRENT ID, '||TEMP_NAME||' IS CURRENT NAME');
    END LOOP;
    CLOSE SVAR;
END;
/



--UPDATE DEPARTMENT
--SET MONTHLY_BUDGET = MONTHLY_BUDGET + INCREASE_INPUT
--WHERE DEPT_ID = DEPT_INPUT

-- CREATE A PROCEDURE WHICH INCREASES THE BUDGET OF THE DEPARTMENT
CREATE OR REPLACE PROCEDURE INCREASE_BUDGET(DEPT IN DEPARTMENT.DEPT_ID%TYPE, VAL IN DEPARTMENT.MONTHLY_BUDGET%TYPE)
IS
BEGIN
    UPDATE DEPARTMENT
    SET MONTHLY_BUDGET = MONTHLY_BUDGET + VAL
    WHERE DEPT_ID = DEPT;
END;
/

BEGIN 
    INCREASE_BUDGET(1, 8000);
    INCREASE_BUDGET(2, 5000);
    INCREASE_BUDGET(3, 11000);
    INCREASE_BUDGET(5, 16000);
    INCREASE_BUDGET(6, 10000);
    COMMIT;
END;
/

SELECT D.DEPT_NAME DEPARTMENT, D.MONTHLY_BUDGET BUDGET, SUM(E.MONTHLY_SALARY) "BUDGET USED"
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID
GROUP BY D.DEPT_NAME, D.MONTHLY_BUDGET;

BEGIN 
    INCREASE_BUDGET(2, 1500);
    COMMIT;
END;
/


-- CREATE A STORED PROCEDURE WHICH ALLOWS US TO GIVE AN EMPLOYEE A RAISE
-- BUT ONLY IF THEIR DEPARTMENT HAS THE BUDGET ALLOWED FOR THEIR RAISE AMOUNT 
CREATE OR REPLACE PROCEDURE GIVE_RAISE(INPUT_ID EMPLOYEE.EMP_ID%TYPE, RAISE_AMOUNT EMPLOYEE.MONTHLY_SALARY%TYPE)
IS 
    DEPT_BUDGET DEPARTMENT.MONTHLY_BUDGET%TYPE;
    BUDGET_USED DEPARTMENT.MONTHLY_BUDGET%TYPE;
    EMPLOYEE_NAME EMPLOYEE.EMP_NAME%TYPE;
    CURRENT_SALARY EMPLOYEE.MONTHLY_SALARY%TYPE;
BEGIN
    -- GET THE DEPARTMENT BUDGET 
    SELECT MONTHLY_BUDGET INTO DEPT_BUDGET
    FROM DEPARTMENT
    WHERE DEPT_ID = 
        (SELECT DEPT_ID
        FROM EMPLOYEE
        WHERE EMP_ID = INPUT_ID);
    --DBMS_OUTPUT.PUT_LINE(DEPT_BUDGET);
        
    -- GET THE AGGREGATED SUM OF THE DEPARTMENT'S SALARY 
    SELECT SUM(MONTHLY_SALARY) INTO BUDGET_USED
    FROM EMPLOYEE
    WHERE DEPT_ID = 
        (SELECT DEPT_ID
        FROM EMPLOYEE
        WHERE EMP_ID = INPUT_ID);
    --DBMS_OUTPUT.PUT_LINE(BUDGET_USED);    

    -- ASSIGN VARIABLES FOR THE EMPLOYEE'S NAME AND SALARY
    SELECT EMP_NAME, MONTHLY_SALARY INTO EMPLOYEE_NAME, CURRENT_SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = INPUT_ID;
    -- DBMS_OUTPUT.PUT_LINE('NAME: '||EMPLOYEE_NAME||', SALARY: '||CURRENT_SALARY );   

    -- COMPARE THESE VALUES WITH THE RAISE_AMOUNT
    -- DETERMINE IF THE EMPLOYEE IS ELIGABLE FOR SAID RAISE
    IF((BUDGET_USED+RAISE_AMOUNT)>DEPT_BUDGET) THEN
        DBMS_OUTPUT.PUT_LINE('INSUFFICIENT DEPARTMENT FUNDS. MONTHLY SALARY FOR '||EMPLOYEE_NAME||' REMAINS $'||CURRENT_SALARY);
    ELSE 
        UPDATE EMPLOYEE
        SET MONTHLY_SALARY = MONTHLY_SALARY+RAISE_AMOUNT
        WHERE EMP_ID = INPUT_ID;
        DBMS_OUTPUT.PUT_LINE('RAISE SUCCESSFULLY INCREASED BY '||RAISE_AMOUNT||'. NEW MONTLY SALARY FOR '||EMPLOYEE_NAME||' IS '||(CURRENT_SALARY+RAISE_AMOUNT));
    END IF;
END;
/

BEGIN
    GIVE_RAISE(15, 1000);
END;
/
SELECT * FROM LOCATIONS;
