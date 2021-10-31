-- Answer following questions
-- What is a result set?
-- A result set is a set of results returned from a query

-- What is the difference between Union and Union All?
-- Union Removes duplicates and automatically sorts the first column in ASC order where as Union All can be used in a recursive cte but doesn't sort and doesn't remove duplicates.

-- What are the other Set Operators SQL Server has?
-- We haven't covered this yet, but the other two are Intersect and Minus

-- What is the difference between Union and Join?
-- Union needs the same number of columns to combine at least 2 tables where as join adds in data based on a matching criteria like ID or Name.

-- What is the difference between INNER JOIN and FULL JOIN?
-- Inner join returns data that is similar between the the left and right, Full Join returns all data from the left and right

-- What is difference between left join and outer join
-- Left join takes all data from the left data and common from the right where as Outer Join takes everything from both except the common data.

-- What is cross join?
-- Cross join takes data from both and mixes them. So if you have 2 drinks and 2 snacks you will get 2 columns with 4 rows, drink a with snacks a and b and drink 2 with snacks a and b. 

-- What is the difference between WHERE clause and HAVING clause?
-- Having clauses can only be used in Select statements and only applies to aggregated groups. Where applies to individual rows and can be used in Select, update, and delete.

-- Can there be multiple group by columns?
-- Yes, you can group by two or more columns. If you are using an Aggregate function you need to include them in Group By.

USE AdventureWorks2019
GO
-- Write queries for following scenarios:
-- How many products can you find in the Production.Product table?
    SELECT COUNT(*) AS Products
	FROM Production.Product
    -- Returns 504 Products

-- Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
	SELECT COUNT(ProductSubcategoryID)
	FROM Production.Product

-- How many Products reside in each SubCategory? Write a query to display the results with the following titles.
    SELECT DISTINCT ProductSubcategoryID, COUNT(ProductID) AS CountedProducts
	FROM Production.Product
	GROUP BY ProductSubcategoryID

-- How many products that do not have a product subcategory. 
 	-- 209 are returning as Null

	
-- Write a query to list the sum of products quantity in the Production.ProductInventory table.
	SELECT ProductID, SUM(ProductID) AS TheSum
	FROM Production.ProductInventory

-- Write a query to list the sum of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.
	SELECT ProductID,  SUM(ProductID) AS TheSum
	FROM Production.ProductInventory
	WHERE LocationID = 40
	GROUP BY ProductID
	HAVING SUM(ProductID) < 100

-- Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100
	SELECT Shelf, ProductID,  SUM(ProductID) AS TheSum
	FROM Production.ProductInventory
	WHERE LocationID = 40
	GROUP BY ProductID, Shelf
	HAVING SUM(ProductID) < 100

-- Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table.
	SELECT ProductID, AVG(ProductID) AS TheAvg
	FROM Production.ProductInventory
	WHERE LocationID = 10
	GROUP BY ProductID

-- Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory
	SELECT ProductID, Shelf, AVG(ProductID) AS TheAvg
	FROM Production.ProductInventory
	WHERE LocationID = 10
	GROUP BY ProductID, Shelf

-- Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory
	SELECT ProductID, Shelf, AVG(ProductID) AS TheAvg
	FROM Production.ProductInventory
	WHERE LocationID = 10 AND Shelf NOT LIKE ('N/A')
	GROUP BY ProductID, Shelf

-- List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.
	SELECT Color, Class, COUNT(*) AS TheCount, AVG(ListPrice) AS AvgPrice
	FROM Production.Product
	WHERE Color IS NOT NULL AND Class IS NOT NULL
	GROUP BY Color, Class

-- 	Joins:
--   Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following. 
	SELECT c.CountryRegionCode AS Country, s.StateProvinceCode AS Province
	FROM Person.CountryRegion c
	INNER JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode

-- Write a query that lists the country and province names from person.CountryRegion and person.StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.
	SELECT c.CountryRegionCode AS Country, s.StateProvinceCode AS Province
	FROM Person.CountryRegion c
	INNER JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode
	WHERE c.CountryRegionCode IN ('CA') OR c.CountryRegionCode IN ('DE')

	-- Using Northwnd Database: (Use aliases for all the Joins)
USE Northwind
GO
-- List all Products that has been sold at least once in last 25 years.
	SELECT d.ProductID AS Product, o.OrderDate AS "Order Date"
	FROM dbo.[Order Details] d
	INNER JOIN dbo.Orders o ON d.OrderID = o.OrderID
	GROUP BY [OrderDate], ProductID
	HAVING YEAR([OrderDate]) BETWEEN (2021 - 25) AND 2021
-- List top 5 locations (Zip Code) where the products sold most.

-- List top 5 locations (Zip Code) where the products sold most in last 25 years.

--  List all city names and number of customers in that city. 
    
-- List city names which have more than 2 customers, and number of customers in that city 

-- List the names of customers who placed orders after 1/1/98 with order date.

-- List the names of all customers with most recent order dates 

-- Display the names of all customers  along with the  count of products they bought 

-- Display the customer ids who bought more than 100 Products with count of products.

-- List all of the possible ways that suppliers can ship their products. Display the results as below
