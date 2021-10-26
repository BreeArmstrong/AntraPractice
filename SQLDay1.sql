USE AdventureWorks2019
GO

-- 1. Query that retrievs Product ID, Name, Color, & List Price from Production.Product Table w/out a filter

	SELECT ProductID, Name, Color, ListPrice
	FROM Production.Product

-- 2. Query that retrievs Product ID, Name, Color, & List Price from Production.Product Table that excludes ListPrice is 0

    SELECT ProductID, Name, Color, ListPrice
	FROM Production.Product
    WHERE [ListPrice] != '0'

-- 3. Query that retrievs Product ID, Name, Color, & List Price from Production.Product Table that the rows are null for the Colors column

    SELECT ProductID, Name, Color, ListPrice
    FROM Production.Product
    WHERE [Color] IS NULL

 -- 4. Query that retrievs Product ID, Name, Color, & List Price from Production.Product Table that excludes the rows are null for the Colors column
	SELECT ProductID, Name, Color, ListPrice
    FROM Production.Product
    WHERE [Color] IS NOT NULL

-- 5. Query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.
    SELECT ProductID, Name, Color, ListPrice
    FROM Production.Product
    WHERE [Color] IS NOT NULL AND [ListPrice] > '0'

-- 6. Query that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color.
    SELECT Name + ' ' + Color AS Name_Color
    FROM Production.Product
    WHERE [Color] IS NOT NULL

-- 7. Query query that generates the following result set  from Production.Product: Name And Color
    SELECT 'NAME: ' + Name + ' -- COLOR: ' + Color AS 'Name And Color'
    FROM Production.Product
    WHERE [Color] IS NOT NULL

-- 8. Query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
    SELECT ProductID, Name, Color
    FROM Production.Product
    WHERE [ProductID] BETWEEN 400 AND 500

-- 9. Query to retrieve the to the columns  ProductID, Name and color from the Production.Product table restricted to the colors black and blue
    SELECT ProductID, Name, Color
    FROM Production.Product
    WHERE [Color] IN ('Black', 'Blue')

-- 10. Query to get a result set on products that begins with the letter S. 
    SELECT ProductID, Name, Color
    FROM Production.Product
    WHERE [Name] LIKE 'S%'

-- 11. Query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
    SELECT Name, ListPrice
    FROM Production.Product
	WHERE [Name] LIKE 'S%'
    ORDER BY [Name]


-- 12. Query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S'
    SELECT Name, ListPrice
    FROM Production.Product
	WHERE [Name] LIKE 'S%' OR [Name] LIKE 'A%'
    ORDER BY [Name]

-- 13. Query to retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.
    SELECT Name, ListPrice
    FROM Production.Product
	WHERE [Name] LIKE 'Spo[^k]%'
    ORDER BY [Name]

-- 14. Query that retrieves unique colors from the table Production.Product. Order the results  in descending  manner
    SELECT DISTINCT Color
    FROM Production.Product
    ORDER BY [Color] DESC

-- 15. Query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. Format and sort so the result set accordingly to the following. We do not want any rows that are NULL.in any of the two columns in the result.
    SELECT DISTINCT ProductSubcategoryID, Color
    FROM Production.Product
    WHERE [ProductSubcategoryID] IS NOT NULL AND [Color] IS NOT NULL