SET SERVEROUTPUT ON;

SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM Loans;
SELECT * FROM Employees;

-- Scenario 1: Calculate the age of customers for eligibility checks.
CREATE OR REPLACE FUNCTION CalculateAge(p_dob DATE) RETURN NUMBER IS
    v_age NUMBER;
BEGIN
    v_age := FLOOR((SYSDATE - p_dob) / 365.25);
    RETURN v_age;
END CalculateAge;
/

DECLARE
    v_age NUMBER;
BEGIN
    FOR rec IN (SELECT CustomerID, Name, DOB FROM Customers) LOOP
        v_age := CalculateAge(rec.DOB);
        DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.CustomerID || ' - ' || rec.Name || ', Age: ' || v_age);
    END LOOP;
END;
/

-- Scenario 2: The bank needs to compute the monthly installment for a loan.
CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment(
    p_loan_amount NUMBER,
    p_interest_rate NUMBER,
    p_duration_years NUMBER
) RETURN NUMBER IS
    v_monthly_rate NUMBER;
    v_monthly_installment NUMBER;
    v_total_months NUMBER;
BEGIN
    v_monthly_rate := p_interest_rate / 100 / 12;
    v_total_months := p_duration_years * 12;
    
    v_monthly_installment := (p_loan_amount * v_monthly_rate) / 
                             (1 - POWER((1 + v_monthly_rate), -v_total_months));
    
    RETURN v_monthly_installment;
END CalculateMonthlyInstallment;
/

DECLARE
    v_monthly_installment NUMBER;
    v_duration_years NUMBER;
BEGIN
    FOR rec IN (SELECT LoanID, LoanAmount, InterestRate, StartDate, EndDate FROM Loans) LOOP
        v_duration_years := (rec.EndDate - rec.StartDate) / 365.25;
        v_monthly_installment := CalculateMonthlyInstallment(rec.LoanAmount, rec.InterestRate, v_duration_years);
        DBMS_OUTPUT.PUT_LINE('LoanID: ' || rec.LoanID || ' - Monthly Installment: ' || ROUND(v_monthly_installment, 2));
    END LOOP;
END;
/

-- Scenario 3: Check if a customer has sufficient balance before making a transaction.
CREATE OR REPLACE FUNCTION HasSufficientBalance(
    p_account_id IN NUMBER,
    p_amount IN NUMBER
) RETURN BOOLEAN IS
    v_balance NUMBER;
BEGIN
    -- Fetch the balance for the given account ID
    SELECT Balance INTO v_balance 
    FROM Accounts 
    WHERE AccountID = p_account_id;

    -- Check if the balance is sufficient
    IF v_balance >= p_amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
    WHEN OTHERS THEN
        RETURN FALSE;
END HasSufficientBalance;
/

DECLARE
    TYPE AccountArray IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    account_ids AccountArray;
    amounts AccountArray;
    v_result BOOLEAN;
BEGIN
    -- Populate the arrays with test data
    account_ids(1) := 1;
    amounts(1) := 500;
    
    account_ids(2) := 2;
    amounts(2) := 2000;
    
    account_ids(3) := 3;
    amounts(3) := 1500;
    
    account_ids(4) := 4;
    amounts(4) := 3000;
    
    account_ids(5) := 5;
    amounts(5) := 3500;
    
    account_ids(6) := 6;
    amounts(6) := 5000;
    
    account_ids(7) := 7;
    amounts(7) := 7500;
    
    -- Iterate through the arrays and call the function
    FOR i IN 1..account_ids.COUNT LOOP
        v_result := HasSufficientBalance(account_ids(i), amounts(i));
        DBMS_OUTPUT.PUT_LINE('AccountID: ' || account_ids(i) || ', Amount: ' || amounts(i) || ', Has Sufficient Balance: ' || CASE WHEN v_result THEN 'TRUE' ELSE 'FALSE' END);
    END LOOP;
END;
/