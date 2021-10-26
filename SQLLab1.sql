USE AdventureWorks2019
GO

-- Write a SELECT statement that lists the customers along with their ID numbers. Include the last names, first names, and company names.
	SELECT p.FirstName, p.LastName, s.Name AS CompanyName, c.CustomerID
	FROM Person.BusinessEntityContact b
		 JOIN Person.Person p
			ON b.BusinessEntityID = p.BusinessEntityID
		 JOIN Sales.Customer c
			ON b.PersonID = c.PersonID
		 JOIN Sales.Store s
			ON p.BusinessEntityID = s.BusinessEntityID

-- Write a SELECT statement that lists the name, product number, and color of each product

	SELECT p.Name, p.ProductNumber, p.Color
	FROM Production.Product p

-- Write a SELECT statement that lists the customer ID numbers and sales order ID numbers from the SalesLT.SalesOrderHeader table

	SELECT o.CustomerID, o.SalesOrderID
	FROM Sales.SalesOrderHeader o

-- Write a query that displays all the employees listed in the HumanResources.Employee table who have the job title Research and Development Engineer. Display the business entity ID number, the login ID, and the title for each one

	SELECT p.FirstName, p.LastName, e.JobTitle AS JobTitle
	FROM HumanResources.Employee e
		INNER JOIN Person.Person p
			ON e.BusinessEntityID = p.BusinessEntityID
	WHERE [JobTitle] = 'Research and Development Engineer'


-- Write a query that displays all the names in Person.Person with the middle name J. Display the first, last, and middle names along with the ID numbers

	SELECT FirstName, MiddleName, LastName, BusinessEntityID
	FROM Person.Person
	WHERE [MiddleName] LIKE 'J'

-- Write a query displaying all the columns of the Production.ProductCostHistory table from the rows that were modified on June 17, 2003.
-- Please Note, there is no Data before 2012 Or for the month of June 

	SELECT ProductID, StartDate, EndDate, StandardCost, ModifiedDate
	FROM Production.ProductCostHistory
	WHERE ModifiedDate IN ('2013-06-17')

-- Write a query that displays all the rows from the Person.Person table where the rows were modified after December 29, 2000. Display the business entity ID number, the name columns, and the modified date.
	SELECT BusinessEntityID, FirstName, LastName, ModifiedDate
	FROM Person.Person
	WHERE ModifiedDate > '2000-12-29'
	ORDER BY [ModifiedDate]

-- Rewrite the last query so that the rows that were not modified on December 29, 2000, are displayed
	
	SELECT BusinessEntityID, FirstName, LastName, ModifiedDate
	FROM Person.Person
	WHERE ModifiedDate <> '2000-12-29'


-- Write a query that displays all the rows from the Person.Person table where the rows were modified during December 2000.
	SELECT BusinessEntityID, FirstName, LastName, ModifiedDate
	FROM Person.Person
	WHERE ModifiedDate BETWEEN '2000-12-01' AND '2000-12-31'

-- Write a query that displays the product ID and name for each product from the Production.Product table with the name starting with Chain.
	SELECT ProductID, Name
	FROM Production.Product
	WHERE Name LIKE 'Chain%'

-- Write a query that displays the products with helmet in the name
	SELECT ProductID, Name
	FROM Production.Product
	WHERE Name LIKE '%helmet%'

-- Change the last query so that the products without helmet in the name are displayed
	SELECT ProductID, Name
	FROM Production.Product
	WHERE Name NOT LIKE '%helmet%'

-- Write a query that displays the business entity ID number, first name, middle name, and last name from the Person.Person table for only those rows that have E or B stored in the middle name column
	SELECT BusinessEntityID, FirstName, MiddleName, LastName
	FROM Person.Person
	WHERE MiddleName LIKE '[E,B]'

-- Explain the difference between the following two queries: 
-- SELECT FirstName FROM Person.Person WHERE LastName LIKE 'Ja%es'; 
-- SELECT FirstName FROM Person.Person WHERE LastName LIKE 'Ja_es
-- The First Query will return something like Jaramies where the name starts with Ja and ends with es, the second one is looking for anything in one specific character slot like James.

-- Write a query displaying the order ID, order date, and total due from the Sales.SalesOrderHeadertable. Retrieve only those rows where the order was placed during the month of September 2001 and the total due exceeded $1,000.
	SELECT SalesOrderID, OrderDate, TotalDue
	FROM Sales.SalesOrderHeader
	WHERE OrderDate BETWEEN '2001-09-01' AND '2001-09-30' AND TotalDue > 1000

-- Write a query displaying the sales orders where the total due exceeds $1,000. Retrieve only those rows where the salesperson ID is 279 or the territory ID is 6
	SELECT SalesOrderID, OrderDate, TotalDue, SalesPersonID, TerritoryID
	FROM Sales.SalesOrderHeader
	WHERE TotalDue > 1000 AND SalesPersonID = 279 OR TerritoryID = 6


-- Write a query displaying the sales orders where the total due exceeds $1,000. Retrieve only those rows where the salesperson ID is 279 or the territory ID is 6 or 4.
	SELECT SalesOrderID, OrderDate, TotalDue, SalesPersonID, TerritoryID
	FROM Sales.SalesOrderHeader
	WHERE TotalDue > 1000 AND SalesPersonID = 279 OR TerritoryID = 6 OR TerritoryID = 4

-- Write a query displaying the ProductID, Name, and Color columns from rows in the Production.Product table. Display only those rows where no color has been assigned
	SELECT ProductID, Name, Color
	FROM Production.Product
	WHERE Color IS NULL

-- Write a query displaying the ProductID, Name, and Color columns from rows in the Production.Product table. Display only those rows in which the color is not blue
	SELECT ProductID, Name, Color
	FROM Production.Product
	WHERE Color NOT IN ('blue')

-- Write a query displaying ProductID, Name, Style, Size, and Color from the Production.Producttable. Include only those rows where at least one of the Style, Size, or Color columns contains  a value
	SELECT ProductID, Name, Style, Size, Color
	FROM Production.Product
	WHERE Style IS NOT NULL OR Size IS NOT NULL OR Color IS NOT NULL

-- Write a query using the Production.ProductReview table. Find all the rows that have the word socks in the Comments column. Return the ProductID and Comments columns.
	SELECT ProductID, Comments
	FROM Production.ProductReview
	WHERE Comments LIKE ('%socks%')

-- Write a query using the Production.Document table. Find all the rows that have the word reflector in any column that is indexed with Full-Text Search. Display the Title and FileName columns
	SELECT Title, FileName
	FROM Production.Document
	WHERE FileName LIKE ('%reflector%') OR Title LIKE ('%reflector%')

-- Change the previous query so that the rows containing seat are not returned in the results.
-- SELECT Title, FileName FROM Production.Document WHERE CONTAINS(*,'reflector AND NOT seat')

-- Write a query that returns the business entity ID and name columns from the Person.Persontable. Sort the results by LastName, FirstName, and MiddleName
	SELECT BusinessEntityID, FirstName, MiddleName, LastName
	FROM Person.Person
	ORDER BY LastName, FirstName, MiddleName

-- Write a query that displays in the “AddressLine1 (City PostalCode)” format from the Person.Address table
-- SELECT AddressLine1 + ' (' + City + ' ' + PostalCode + ')' FROM Person.Address;

-- Write a query using the Production.Product table displaying the product ID, color, and name columns. If the color column contains a NULL value, replace the color with No Color.
-- SELECT ProductID, ISNULL(Color,'No Color') AS Color, Name FROM Production.Product;

-- Write a query using the Production.Product table displaying a description with the “ProductID: Name” format
-- SELECT CAST(ProductID AS VARCHAR) + ': ' + Name AS IDName FROM Production.Product;  

-- Write a query using the Sales.SpecialOffer table. Display the difference between the MinQty and MaxQty columns along with the SpecialOfferID and Description columns.
-- SELECT SpecialOfferID, Description, MaxQty - MinQty AS Diff FROM Sales.SpecialOffer;

-- Write a query using the Sales.SpecialOffer table. Multiply the MinQty column by the DiscountPctcolumn. Include the SpecialOfferID and Description columns in the results
-- SELECT SpecialOfferID, Description, MinQty * DiscountPct AS Discount FROM Sales.SpecialOffer;

-- Write a query using the Sales.SpecialOffer table that multiplies the MaxQty column by the DiscountPCT column. If the MaxQty value is null, replace it with the value 10. Include the SpecialOfferID and Description columns in the results.
-- SELECT SpecialOfferID, Description, ISNULL(MaxQty,10) * DiscountPct AS Discount FROM Sales.SpecialOffer;

-- Write a query that displays the first 10 characters of the AddressLine1 column in the Person.Address table.
-- SELECT LEFT(AddressLine1,10) AS Address10 FROM Person.Address;

-- Write a query that displays characters 10 to 15 of the AddressLine1 column in the Person.Addresstable.
-- SELECT SUBSTRING(AddressLine1,10,6) AS Address10to15 FROM Person.Address;

-- Write a query displaying the first name and last name from the Person.Person table all in uppercase
-- SELECT UPPER(FirstName) AS FirstName, UPPER(LastName) AS LastName FROM Person.Person;

-- The product number in the Production.Product contains a hyphen (-). Write a query that uses the SUBSTRING function and the CHARINDEX function to display the characters in the product number following the hyphen. Note: there is also a second hyphen in many of the rows; ignore the second hyphen for this question.
-- --Step 1
-- SELECT ProductNumber, CHARINDEX('-',ProductNumber) FROM Production.Product;
-- --Step 2
-- SELECT ProductNumber, SUBSTRING(ProductNumber,CHARINDEX('-',ProductNumber)+1,25) AS ProdNumber FROM Production.Product;

-- Write a query that calculates the number of days between the date an order was placed and the date that it was shipped using the Sales.SalesOrderHeader table. Include the SalesOrderID, OrderDate, and ShipDate columns.
-- SELECT SalesOrderID, OrderDate, ShipDate,  DATEDIFF(d,OrderDate,ShipDate) AS NumberOfDays FROM Sales.SalesOrderHeader;

-- Write a query that displays only the date, not the time, for the order date and ship date in the Sales.SalesOrderHeader table
-- SELECT CONVERT(VARCHAR,OrderDate,1) AS OrderDate,  CONVERT(VARCHAR, ShipDate,1) AS ShipDate FROM Sales.SalesOrderHeader;

-- Write a query that adds six months to each order date in the Sales.SalesOrderHeader table. Include the SalesOrderID and OrderDate columns.
-- SELECT SalesOrderID, OrderDate, DATEADD(m,6,OrderDate) Plus6Months FROM Sales.SalesOrderHeader;

-- Write a query that displays the year of each order date and the numeric month of each order date in separate columns in the results. Include the SalesOrderID and OrderDate columns.
-- SELECT SalesOrderID, OrderDate, DATEPART(yyyy,OrderDate) AS OrderYear,
-- DATEPART(m,OrderDate) AS OrderMonth FROM Sales.SalesOrderHeader;

-- Change the above query to display the month name instead.
-- SELECT SalesOrderID, OrderDate, DATEPART(yyyy,OrderDate) AS OrderYear,
--  DATENAME(m,OrderDate) AS OrderMonth FROM Sales.SalesOrderHeader;

-- Write a query using the Sales.SalesOrderHeader table that displays the SubTotal rounded to two decimal places. Include the SalesOrderID column in the results.
-- SELECT SalesOrderID, ROUND(SubTotal,2) AS SubTotal FROM Sales.SalesOrderHeader;

-- Modify the previous query so that the SubTotal is rounded to the nearest dollar but still displays two zeros to the right of the decimal place
-- SELECT SalesOrderID, ROUND(SubTotal,0) AS SubTotal FROM Sales.SalesOrderHeader;

-- Write a statement that generates a random number between 1 and 10 each time it is run.
-- SELECT SQRT(SalesOrderID) AS OrderSQRT FROM Sales.SalesOrderHeader;

-- Write a query using the HumanResources.Employee table to display the BusinessEntityID column.Display “Even” when the BusinessEntityID value is an even number or “Odd” when it is odd.
-- SELECT BusinessEntityID,
--  CASE BusinessEntityID % 2 WHEN 0 THEN 'Even' ELSE 'Odd' END
-- FROM HumanResources.Employee;
-- Write a query using the Sales.SalesOrderDetail table to display a value (“Under 10” or “10–19” or “20–29” or “30–39” or “40 and over”) based on the OrderQty value. Include the SalesOrderID and OrderQty columns in the results.
-- SELECT SalesOrderID, OrderQty,
--  CASE WHEN OrderQty BETWEEN 0 AND 9 THEN 'Under 10'
--  WHEN OrderQty BETWEEN 10 AND 19 THEN '10-19'
--  WHEN OrderQty BETWEEN 20 AND 29 THEN '20-29'
--  WHEN OrderQty BETWEEN 30 AND 39 THEN '30-39'
--  ELSE '40 and over' end AS range
-- FROM Sales.SalesOrderDetail;

-- Write a query using the Sales.SalesOrderHeader table to display the orders placed during 2001 by using a function. Include the SalesOrderID and OrderDate columns in the results.
-- SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader WHERE YEAR(OrderDate) = 2001;

-- Write a query using the Sales.SalesOrderHeader table listing the sales in order of the month the order was placed and then the year the order was placed. Include the SalesOrderID and OrderDatecolumns in the results.
-- SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader ORDER BY MONTH(OrderDate), YEAR(OrderDate);

-- Write a query that displays the PersonType and the name columns from the Person.Person table. Sort the results so that rows with a PersonType of IN, SP, or SC sort by LastName. The other rows should sort by FirstName
-- SELECT PersonType, FirstName, MiddleName, LastName
-- FROM Person.Person
-- ORDER BY CASE WHEN PersonType IN ('IN','SP','SC') THEN LastName
--  ELSE FirstName END;