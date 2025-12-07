/*
File: EC_IT143_W6_4_Performance_Analysis.sql
Author: Charles Adinyira
Purpose: Queries that generate missing index recommendations + create indexes safely
*/

/* ---------------------------------------------------------
Query 1 – Join Sales.Customer with Person.Person and filter
on unindexed column FirstName
-----------------------------------------------------------*/

-- Run query to trigger missing index suggestion
SELECT c.CustomerID, p.FirstName, p.LastName
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
WHERE p.FirstName = 'Robert';
GO

-- Create the recommended index if it doesn't already exist
IF NOT EXISTS (
    SELECT name 
    FROM sys.indexes 
    WHERE name = 'IX_Person_FirstName' 
      AND object_id = OBJECT_ID('Person.Person')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Person_FirstName
    ON Person.Person (FirstName);
END
GO

-- Rerun the query to check performance improvement
SELECT c.CustomerID, p.FirstName, p.LastName
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
WHERE p.FirstName = 'Robert';
GO

/* ---------------------------------------------------------
Query 2 – Filter Person.Person on LastName (unindexed)
-----------------------------------------------------------*/

-- Run query to trigger missing index suggestion
SELECT *
FROM Person.Person
WHERE LastName = 'Miller';
GO

-- Create the recommended index if it doesn't already exist
IF NOT EXISTS (
    SELECT name 
    FROM sys.indexes 
    WHERE name = 'IX_Person_LastName' 
      AND object_id = OBJECT_ID('Person.Person')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Person_LastName
    ON Person.Person (LastName);
END
GO

-- Rerun the query to check performance improvement
SELECT *
FROM Person.Person
WHERE LastName = 'Miller';
GO
