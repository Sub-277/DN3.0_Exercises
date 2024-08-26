SET SERVEROUTPUT ON;

SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM Loans;
SELECT * FROM Employees;

-- Scenario 1: Automatically update the last modified date when a customer's record is updated.
CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    :NEW.LastModified := SYSDATE;
END;
/

SELECT TRIGGER_NAME, STATUS
FROM USER_TRIGGERS
WHERE TRIGGER_NAME = 'UPDATECUSTOMERLASTMODIFIED';

UPDATE Customers
SET Name = 'Johnathan Doe'
WHERE CustomerID = 1;

SELECT * FROM Customers;

-- Scenario 2: Maintain an audit log for all transactions.
CREATE TABLE AuditLog (
    AuditID NUMBER PRIMARY KEY,
    TransactionID NUMBER,
    ActionDate DATE,
    ActionType VARCHAR2(20)
);

CREATE SEQUENCE AuditLog_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (AuditID, TransactionID, ActionDate, ActionType)
    VALUES (AuditLog_SEQ.NEXTVAL, :NEW.TransactionID, SYSDATE, 'INSERT');
END;
/

SELECT SEQUENCE_NAME
FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'AUDITLOG_SEQ';

SELECT TRIGGER_NAME, STATUS
FROM USER_TRIGGERS
WHERE TRIGGER_NAME = 'LOGTRANSACTION';

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (8, 1, SYSDATE, 250, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (9, 5, SYSDATE, 4500, 'Withdrawal');

SELECT * FROM AuditLog;
SELECT * FROM Transactions;

-- Scenario 3: Enforce business rules on deposits and withdrawals.
CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
DECLARE
    v_balance NUMBER;
BEGIN
    -- Get the current balance for the account
    SELECT Balance INTO v_balance FROM Accounts WHERE AccountID = :NEW.AccountID;
    
    -- Check the rules based on the transaction type
    IF :NEW.TransactionType = 'Withdrawal' THEN
        IF v_balance < :NEW.Amount THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds for withdrawal.');
        END IF;
    ELSIF :NEW.TransactionType = 'Deposit' THEN
        IF :NEW.Amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Deposit amount must be positive.');
        END IF;
    ELSE
        RAISE_APPLICATION_ERROR(-20003, 'Invalid transaction type.');
    END IF;
END;
/

SELECT TRIGGER_NAME, STATUS
FROM USER_TRIGGERS
WHERE TRIGGER_NAME = 'CHECKTRANSACTIONRULES';

-- Test Case 1: Valid Withdrawal
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (10, 3, SYSDATE, 100, 'Withdrawal');

SELECT * FROM Transactions;

-- Test Case 2: Withdrawal Exceeding Balance
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (11, 1, SYSDATE, 2000, 'Withdrawal');

-- Test Case 3: Valid Deposit
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (11, 2, SYSDATE, 500, 'Deposit');

SELECT * FROM Transactions;

-- Test Case 4: Invalid Deposit
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (13, 2, SYSDATE, -50, 'Deposit');





