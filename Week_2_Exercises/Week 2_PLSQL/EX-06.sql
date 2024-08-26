SET SERVEROUTPUT ON;

SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM Loans;
SELECT * FROM Employees;

-- Scenario 1: Generate monthly statements for all customers.
DECLARE
    CURSOR GenerateMonthlyStatements IS
        SELECT c.CustomerID, c.Name, t.TransactionDate, t.Amount, t.TransactionType
        FROM Customers c
        JOIN Accounts a ON c.CustomerID = a.CustomerID
        JOIN Transactions t ON a.AccountID = t.AccountID
        WHERE EXTRACT(MONTH FROM t.TransactionDate) = EXTRACT(MONTH FROM SYSDATE)
          AND EXTRACT(YEAR FROM t.TransactionDate) = EXTRACT(YEAR FROM SYSDATE)
        ORDER BY c.CustomerID, t.TransactionDate;
    
    v_CustomerID Customers.CustomerID%TYPE;
    v_Name Customers.Name%TYPE;
    v_TransactionDate Transactions.TransactionDate%TYPE;
    v_Amount Transactions.Amount%TYPE;
    v_TransactionType Transactions.TransactionType%TYPE;
BEGIN
    FOR rec IN GenerateMonthlyStatements LOOP
        v_CustomerID := rec.CustomerID;
        v_Name := rec.Name;
        v_TransactionDate := rec.TransactionDate;
        v_Amount := rec.Amount;
        v_TransactionType := rec.TransactionType;

        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_CustomerID || ', Name: ' || v_Name);
        DBMS_OUTPUT.PUT_LINE('Date: ' || v_TransactionDate || ', Amount: ' || v_Amount || ', Type: ' || v_TransactionType);
        DBMS_OUTPUT.PUT_LINE('------------------------------');
    END LOOP;
END;
/


-- Scenario 2: Apply annual fee to all accounts.
DECLARE
    CURSOR ApplyAnnualFee IS
        SELECT AccountID, Balance
        FROM Accounts;
    
    v_AccountID Accounts.AccountID%TYPE;
    v_Balance Accounts.Balance%TYPE;
    v_AnnualFee NUMBER := 50; -- Define your annual fee amount here
BEGIN
    FOR rec IN ApplyAnnualFee LOOP
        v_AccountID := rec.AccountID;
        v_Balance := rec.Balance;

        -- Deduct the annual fee
        UPDATE Accounts
        SET Balance = v_Balance - v_AnnualFee
        WHERE AccountID = v_AccountID;

        DBMS_OUTPUT.PUT_LINE('Account ID: ' || v_AccountID || ' - Fee Applied. New Balance: ' || (v_Balance - v_AnnualFee));
    END LOOP;
END;
/

-- Scenario 3: Update the interest rate for all loans based on a new policy
DECLARE
    CURSOR UpdateLoanInterestRates IS
        SELECT LoanID, LoanAmount, InterestRate
        FROM Loans;
    
    v_LoanID Loans.LoanID%TYPE;
    v_LoanAmount Loans.LoanAmount%TYPE;
    v_InterestRate Loans.InterestRate%TYPE;
    v_NewInterestRate NUMBER;
BEGIN
    FOR rec IN UpdateLoanInterestRates LOOP
        v_LoanID := rec.LoanID;
        v_LoanAmount := rec.LoanAmount;
        v_InterestRate := rec.InterestRate;

        -- Define new interest rate policy
        IF v_LoanAmount < 5000 THEN
            v_NewInterestRate := v_InterestRate + 0.5;
        ELSIF v_LoanAmount BETWEEN 5000 AND 10000 THEN
            v_NewInterestRate := v_InterestRate + 0.3;
        ELSE
            v_NewInterestRate := v_InterestRate + 0.1;
        END IF;

        -- Update the loan interest rate
        UPDATE Loans
        SET InterestRate = v_NewInterestRate
        WHERE LoanID = v_LoanID;

        DBMS_OUTPUT.PUT_LINE('Loan ID: ' || v_LoanID || ' - Updated Interest Rate: ' || v_NewInterestRate);
    END LOOP;
END;
/
