-- this is a comment
/* this is a multiline comment */

-----------------------------------
-- USING DDL TO CREATE OUR TABLES
-----------------------------------

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

-- SELECT EMP_NAME, DEPT_ID
-- FROM EMPLOYEE
-- WHERE MANAGER_ID = NULL;

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

SELECT EMP_ID, EMP_NAME, BIRTHDAY, MANAGER_ID, DEPT_ID
INTO EMPLOYEE2
FROM EMPLOYEE;



