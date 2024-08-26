SET SERVEROUTPUT ON;

SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM Loans;
SELECT * FROM Employees;

--Scenario 1: Processing Monthly Interest for Savings Accounts
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
    -- Loop through all savings accounts and update their balance
    FOR rec IN (SELECT AccountID, Balance FROM Accounts WHERE AccountType = 'Savings' FOR UPDATE) LOOP
        UPDATE Accounts
        SET Balance = Balance + (Balance * 0.01), LastModified = SYSDATE
        WHERE AccountID = rec.AccountID;
    END LOOP;
    -- Commit the changes
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Monthly interest processed for all savings accounts.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
    ProcessMonthlyInterest;
END;
/

SELECT * FROM Accounts;

--Scenario 2: Updating Employee Bonus Based on Performance
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
) IS
BEGIN
    -- Update the salary of employees in the given department by adding the bonus percentage
    UPDATE Employees
    SET Salary = Salary + (Salary * p_bonus_percentage / 100), HireDate = SYSDATE
    WHERE Department = p_department;

    -- Commit the changes
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Employee bonuses updated for department: ' || p_department);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
    UpdateEmployeeBonus('IT', 10); -- Example: Add a 10% bonus to the salaries of employees in the 'IT' department
END;
/

SELECT * FROM Employees;

--Scenario 3: Transferring Funds Between Customer Accounts
CREATE OR REPLACE PROCEDURE TransferFunds(
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
) IS
    v_from_balance NUMBER;
BEGIN
    -- Lock the accounts to prevent concurrent updates
    SELECT Balance INTO v_from_balance FROM Accounts WHERE AccountID = p_from_account FOR UPDATE;
    SELECT Balance INTO v_from_balance FROM Accounts WHERE AccountID = p_to_account FOR UPDATE;

    -- Check if the source account has sufficient balance
    IF v_from_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in the "from" account.');
    END IF;

    -- Update the balances of the source and destination accounts
    UPDATE Accounts
    SET Balance = Balance - p_amount, LastModified = SYSDATE
    WHERE AccountID = p_from_account;

    UPDATE Accounts
    SET Balance = Balance + p_amount, LastModified = SYSDATE
    WHERE AccountID = p_to_account;

    -- Commit the changes
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Transfer successful.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Account does not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
    TransferFunds(2, 1, 500); -- Example: Transfer 500 from account 2 to account 1
END;
/

SELECT * FROM Accounts;