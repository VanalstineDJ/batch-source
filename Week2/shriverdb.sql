CREATE TABLE INVOICE(
    I_ID NUMBER(5) PRIMARY KEY,
    P_DATE DATE,
    C_ID NUMBER(5),
    AMOUNT NUMBER(5,2)
    );
CREATE TABLE CUSTOMER(
    C_ID NUMBER(5) PRIMARY KEY,
    C_NAME VARCHAR2(20),
    C_EMAIL VARCHAR2(26)
);
ALTER TABLE INVOICE
ADD FOREIGN KEY (C_ID) REFERENCES CUSTOMER(C_ID);
INSERT INTO CUSTOMER VALUES(1,'JOHN SMITH','IAMTHEEGGMAN@GMAIL.COM');
INSERT INTO CUSTOMER VALUES(2,'JOHN COOPER','EGGMAN@GMAIL.COM');
INSERT INTO CUSTOMER VALUES(3,'JOHN WRIGHT','IAMEGG@GMAIL.COM');
INSERT INTO CUSTOMER VALUES(4,'JOHN LOCKHEART','THEEGGMAN@GMAIL.COM');
INSERT INTO CUSTOMER VALUES(5,'JOHN JONES','THEEGG@GMAIL.COM');
INSERT INTO INVOICE VALUES(1,DATE '2018-12-12',1,280);
INSERT INTO INVOICE VALUES(2,DATE '2018-12-13',2,290);
INSERT INTO INVOICE VALUES(3,DATE '2018-12-14',3,300);
INSERT INTO INVOICE VALUES(4,DATE '2018-12-15',4,310);
INSERT INTO INVOICE VALUES(5,DATE '2019-01-16',5,320);
INSERT INTO INVOICE VALUES(6,DATE '2019-01-22',1,330);
INSERT INTO INVOICE VALUES(7,DATE '2019-01-26',2,440);
INSERT INTO INVOICE VALUES(8,DATE '2019-01-27',3,550);
INSERT INTO INVOICE VALUES(9,DATE '2019-02-25',4,660);
INSERT INTO INVOICE VALUES(10,DATE '2019-02-26',5,880);
SELECT * FROM INVOICE WHERE P_DATE= TRUNC(CURRENT_DATE);
