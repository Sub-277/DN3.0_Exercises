SET SERVEROUTPUT ON;

--Scenario 1: Applying a Discount to Loan Interest Rates for Customers Above 60 Years Old
DECLARE
    v_customer_age NUMBER;
    v_new_interest_rate NUMBER;
BEGIN
    FOR customer_rec IN (SELECT CustomerID, DOB FROM Customers) LOOP
        v_customer_age := TRUNC(MONTHS_BETWEEN(SYSDATE, customer_rec.DOB) / 12);
        
        IF v_customer_age > 60 THEN
            FOR loan_rec IN (SELECT LoanID, InterestRate FROM Loans WHERE CustomerID = customer_rec.CustomerID) LOOP
                v_new_interest_rate := loan_rec.InterestRate - 1;
                
                UPDATE Loans
                SET InterestRate = v_new_interest_rate
                WHERE LoanID = loan_rec.LoanID;
            END LOOP;
        END IF;
    END LOOP;
    
    COMMIT;
END;
/

SELECT * FROM Loans;

--Scenario 2: Promoting Customers to VIP Status Based on Their Balance
ALTER TABLE Customers ADD IsVIP VARCHAR2(3);

DECLARE
BEGIN
    FOR customer_rec IN (SELECT CustomerID, Balance FROM Customers) LOOP
        IF customer_rec.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'YES'
            WHERE CustomerID = customer_rec.CustomerID;
        ELSE
            UPDATE Customers
            SET IsVIP = 'NO'
            WHERE CustomerID = customer_rec.CustomerID;
        END IF;
    END LOOP;

    COMMIT;
END;
/

SELECT * FROM Customers;

--Scenario 3: Sending Reminders for Loans Due in the Next 30 Days
DECLARE
    v_due_date Loans.EndDate%TYPE;
    v_customer_name Customers.Name%TYPE;
BEGIN
    FOR loan_rec IN (
        SELECT LoanID, CustomerID, EndDate 
        FROM Loans 
        WHERE EndDate BETWEEN SYSDATE AND SYSDATE + 30
    ) LOOP
        SELECT Name INTO v_customer_name 
        FROM Customers 
        WHERE CustomerID = loan_rec.CustomerID;
        
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan ' || loan_rec.LoanID || ' for customer ' || v_customer_name || ' is due on ' || TO_CHAR(loan_rec.EndDate, 'YYYY-MM-DD'));
    END LOOP;
END;
/

