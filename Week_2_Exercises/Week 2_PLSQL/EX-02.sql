SET SERVEROUTPUT ON;

SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM Loans;
SELECT * FROM Employees;

--Scenario 1: Handle Exceptions During Fund Transfers Between Accounts
CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
) IS
    v_from_balance NUMBER;
    v_to_balance NUMBER;
BEGIN
    -- Check if the 'from' account exists
    SELECT Balance INTO v_from_balance FROM Accounts WHERE AccountID = p_from_account FOR UPDATE;
    
    -- Check if the 'to' account exists
    SELECT Balance INTO v_to_balance FROM Accounts WHERE AccountID = p_to_account FOR UPDATE;
    
    -- Check if there are sufficient funds
    IF v_from_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in the "from" account.');
    END IF;
    
    -- Perform the fund transfer
    UPDATE Accounts SET Balance = Balance - p_amount WHERE AccountID = p_from_account;
    UPDATE Accounts SET Balance = Balance + p_amount WHERE AccountID = p_to_account;
    
    -- Commit the transaction
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

-- Test SafeTransferFunds
BEGIN
    SafeTransferFunds(2, 1, 500);
END;
/

SELECT * FROM Customers;

--Scenario 2: Manage Errors When Updating Employee Salaries
CREATE OR REPLACE PROCEDURE UpdateSalary(
    p_employee_id IN NUMBER,
    p_percentage IN NUMBER
) IS
BEGIN
    -- Update the employee salary
    UPDATE Employees
    SET Salary = Salary * (1 + p_percentage / 100)
    WHERE EmployeeID = p_employee_id;
    
    -- Check if the update was successful
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Employee ID does not exist.');
    END IF;
    
    -- Commit the transaction
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Salary updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Test UpdateSalary
BEGIN
    UpdateSalary(1, 10); -- Increase salary of employee with ID 1 by 10%
END;
/

SELECT * FROM Employees;

--Scenario 3: Ensure Data Integrity When Adding a New Customer
CREATE OR REPLACE PROCEDURE AddNewCustomer(
    p_customer_id IN NUMBER,
    p_name IN VARCHAR2,
    p_dob IN DATE,
    p_balance IN NUMBER,
    p_IsVIP IN VARCHAR2
) IS
BEGIN
    -- Attempt to insert the new customer
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, Isvip)
    VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE, p_IsVIP);
    
    -- Commit the transaction
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Customer added successfully.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Customer with this ID already exists.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Test AddNewCustomer
BEGIN
    AddNewCustomer(8, 'Subarna Paul', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 30000,'YES');
END;
/

SELECT * FROM Customers;