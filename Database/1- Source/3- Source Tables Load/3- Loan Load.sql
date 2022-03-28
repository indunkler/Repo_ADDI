USE [DB_SOURCE]

TRUNCATE TABLE dbo.loan_Status
GO
 
-- import the file
BULK INSERT dbo.loan_Status
FROM 'C:\ADDI\loan_Status.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO