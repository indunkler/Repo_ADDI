USE [DB_SOURCE]

TRUNCATE TABLE dbo.master
GO
 
-- import the file
BULK INSERT dbo.master
FROM 'C:\ADDI\master-table.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO