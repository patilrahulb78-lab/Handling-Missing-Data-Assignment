CREATE DATABASE Missing_data;
use Missing_data;
CREATE TABLE Sales(
	Customer_ID int,
    Name VARCHAR (50),
    City VARCHAR(20),
    Monthly_Sales INT,
    Income INT,
    Region VARCHAR(20)
);
describe Sales;
INSERT INTO Sales VALUES (Customer_ID, Name, City, Monthly_Sales, Income, Region),
		(101,'Rahul Meheta','Mumbai',12000,65000,'West'),
        (102,'Anjali Rao','Bengaluru',NULL,NULL,'South'),
        (103,'Suresh Iyer','Chennai',15000,72000,'South'),
        (104,'Neha Singh','Dehli',NULL,NULL,'South'),
        (105,'Amit Verma','Pune',18000,58000,NULL),
        (106,'Karan Shah','Ahmedabad',NULL,61000,'West'),
        (107,'Pooja Das','Kolkata',14000,NULL,'East'),
        (108,'Riya Kapoor','Jaipur',16000,69000,'North');
        SELECT * FROM Sales;
        /* Q8. Listwise Deletion Remove all rows where Region is missing.
		Tasks:
		Identify affected rows
		Show the dataset after deletion
		Mention how many records were lost*/
Select * from sales;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Sales WHERE Region IS NULL;
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM Sales;
/* Q9. Imputation 
Handle missing values in Monthly_Sales using:
Forward Fill
Tasks:
Apply forward fill
Show before vs after values
Explain why forward fill is suitable here*/
SELECT 
    Customer_ID, 
    Name, 
    Monthly_Sales AS Before_Value,
    COALESCE(Monthly_Sales, (
        SELECT S2.Monthly_Sales 
        FROM Sales S2 
        WHERE S2.Customer_ID < S1.Customer_ID 
          AND S2.Monthly_Sales IS NOT NULL 
        ORDER BY S2.Customer_ID DESC 
        LIMIT 1
    )) AS After_Value,
    CASE 
        WHEN Monthly_Sales IS NOT NULL THEN 'Original'
        ELSE 'Carried Forward'
    END AS Source_of_Value;
/* Q10. Flagging Missing Data Create a flag column for missing Income.
Tasks:
Create Income_Missing_Flag (0 = present, 1 = missing)
Show updated dataset
Count how many customers have missing income */
SELECT 
    Customer_ID, 
    Name, 
    Income,
    CASE 
        WHEN Income IS NULL THEN 1 
        ELSE 0 
    END AS Income_Missing_Flag
FROM Sales;
SELECT COUNT(*) AS Missing_Income_Count
FROM Sales
WHERE Income IS NULL;

        
        