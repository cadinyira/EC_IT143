/* =========================================================
   EC_IT143_W3.4_CA
   AdventureWorks — Create Answers
   Author: Charles Adinyira
   Date: 2025-11-20
   Estimated Runtime: < 1 second per query
   Description:
     This script contains eight user questions translated into
     SQL statements using the AdventureWorks sample database.
=========================================================== */

/* ---------------------------------------------------------
   Learning Resources Used
   1. StackOverflow – How to Ask a Good Question
   2. StackOverflow – How to Write a Good Answer
   3. CCL – Use 6 Active Listening Skills & Techniques
   4. Microsoft Docs – System Information Schema Views
   5. LearnSQL – SQL Formatting Standards
----------------------------------------------------------- */



/************************************************************
   SECTION 1 — BUSINESS USER QUESTIONS (MARGINAL COMPLEXITY)
************************************************************/

/* Q1 — Author: Student A
   Question:
   “List 10 customers with their first and last names.”
*/
SELECT TOP (10)
       FirstName,
       LastName
FROM Person.Person
ORDER BY FirstName;


/* Q2 — Author: Student B
   Question:
   “List all products that are currently being sold,
    including their list price.”
*/
SELECT ProductID,
       Name,
       ListPrice
FROM Production.Product
WHERE SellEndDate IS NULL
ORDER BY Name;



/************************************************************
   SECTION 2 — BUSINESS USER QUESTIONS (MODERATE COMPLEXITY)
************************************************************/

/* Q3 — Author: Student C
   Question:
   “Which salespeople completed sales in the year 2013?”
*/
SELECT DISTINCT
       p.FirstName,
       p.LastName
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesPerson sp
       ON soh.SalesPersonID = sp.BusinessEntityID
JOIN Person.Person p
       ON p.BusinessEntityID = sp.BusinessEntityID
WHERE YEAR(soh.OrderDate) = 2013;


/* Q4 — Author: Student D
   Question:
   “List all products with their category and subcategory.”
*/
SELECT p.Name              AS ProductName,
       ps.Name             AS Subcategory,
       pc.Name             AS Category
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
       ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
       ON ps.ProductCategoryID = pc.ProductCategoryID
ORDER BY Category, Subcategory, ProductName;



/************************************************************
   SECTION 3 — BUSINESS USER QUESTIONS (INCREASED COMPLEXITY)
************************************************************/

/* Q5 — Author: Student E
   Question:
   “Show total sales amount for each salesperson.”
*/
SELECT sp.BusinessEntityID,
       p.FirstName,
       p.LastName,
       SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesPerson sp
       ON soh.SalesPersonID = sp.BusinessEntityID
JOIN Person.Person p
       ON p.BusinessEntityID = sp.BusinessEntityID
GROUP BY sp.BusinessEntityID,
         p.FirstName,
         p.LastName
ORDER BY TotalSales DESC;


/* Q6 — Author: Student F
   Question:
   “Which 5 products have the highest total sales quantity?”
*/
SELECT TOP (5)
       p.Name             AS ProductName,
       SUM(sod.OrderQty) AS TotalUnitsSold
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p
       ON sod.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalUnitsSold DESC;



/************************************************************
   SECTION 4 — METADATA QUESTIONS
   Using INFORMATION_SCHEMA Views
************************************************************/

/* Q7 — Author: Student G
   Question:
   “List all tables in the AdventureWorks database.”
*/
SELECT TABLE_SCHEMA,
       TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
ORDER BY TABLE_SCHEMA,
         TABLE_NAME;


/* Q8 — Author: Student H
   Question:
   “List all columns in the SalesOrderHeader table,
    including their data type and nullability.”
*/
SELECT COLUMN_NAME,
       DATA_TYPE,
       IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SalesOrderHeader'
ORDER BY COLUMN_NAME;
