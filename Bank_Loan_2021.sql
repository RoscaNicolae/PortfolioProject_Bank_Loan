SELECT * From bank_loan_data

SELECT COUNT(id) as Total_Loan_Applications From bank_loan_data

SELECT COUNT(id) as MTD_Total_Loan_Applications From bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
-- ---------------------------------------------------------------------------

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
-- ----------------------------------------------------------------------------

SELECT SUM(total_payment) AS MTD_Total_Amount_Received FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT SUM(total_payment) AS PMTD_Total_Amount_Received FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
-- ----------------------------------------------------------------------------

SELECT ROUND(AVG(int_rate),4) * 100 AS PMTD_Avg_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
-- ----------------------------------------------------------------------------

SELECT AVG(dti) * 100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT AVG(dti) * 100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
-- ----------------------------------------------------------------------------

SELECT loan_status FROM bank_loan_data

SELECT CONCAT(
        (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) 
		/ 
		COUNT(id),
        '%' ) AS Good_loan_percentage
FROM bank_loan_data;
-- Good loan in %

SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
-- Number of application loan

SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
-- Total sum of good loans

SELECT SUM(total_payment) AS Good_Loan_Recieved_Amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
-- Total sum of good Loan Recieved amount

SELECT CONCAT(
        (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) 
		/ 
		COUNT(id),
        '%' ) AS Bad_loan_percentage
FROM bank_loan_data;
-- Bad loan in %

SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off' 
-- Number of application loan

SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Charged Off' 
-- Total sum of bad loans

SELECT SUM(total_payment) AS Bad_Loan_Recieved_Amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'
-- Total sum of bad Loan Recieved amount

SELECT [loan_status],
	COUNT(id) AS Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	AVG(int_rate*100) AS Interest_rate,
	AVG(dti*100) AS DTI
FROM 
	bank_loan_data
GROUP BY 
	[loan_status]


SELECT [loan_status],
	SUM(total_payment) AS MTD_Total_Amount_Received,
	SUM(loan_amount) AS MTD_Total_Funded_Amount,
	Concat(100 - ((SUM(loan_amount)/SUM(total_payment))*100),'%') as Procentege
FROM 
	bank_loan_data
WHERE 
	MONTH(issue_date) = 12
GROUP BY 
	[loan_status]
With rollup

-- -------------------------------------------------------------------------------

SELECT 
	MONTH(issue_date) AS Month_Number,
	DATENAME(MONTH,issue_date) AS Month_Name,
	COUNT(id) AS Total_Loan_applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date),DATENAME(MONTH,issue_date)
ORDER BY MONTH(issue_date)
-- Monthly Trends By Issue Date

SELECT 
	address_state,
	COUNT(id) AS Total_Loan_applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC

-- Regional Analysis by State

SELECT 
	term,
	COUNT(id) AS Total_Loan_applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term
-- Loan Term Analysis by State

SELECT 
	emp_length,
	COUNT(id) AS Total_Loan_applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY COUNT(id) DESC
--  Employee Length Analysis

SELECT 
	purpose,
	COUNT(id) AS Total_Loan_applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC
 --Loan Purpose Breakdown

SELECT 
	home_ownership,
	COUNT(id) AS Total_Loan_applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC
--Home Ownership Analysis 