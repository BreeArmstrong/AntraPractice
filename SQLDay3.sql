-- In SQL Server, assuming you can find the result by using both joins and subqueries, which one would you prefer to use and why?
-- There are very uniqque and special cases in which a correlated subquery and it would be more performant than a Join, but most of the time joins will be better perfomant than subqueries, thus making it good practice to use it instead of subqueries.

--	What is CTE and when to use it?
-- CTE stands for Common table Expression and it can call itself recursively. This makes it useful for putting in an initial parameter like a special case that can be referred to later to then call recursively until it is finished. An example would be the heirarchy of managers and employess. A CEO reports to no one but the people below have someone who is their manager and must report to. The CEO makes for a great initialization case to then enter into the recursive rule after. 

-- 	What are Table Variables? What is their scope and where are they created in SQL Server?
-- Table variables are a variable with a type of table. Their scope is the current batch. They are stored within the temporary table database but have no name like Temp Tables do -- the name instead is just a string of numbers rather than the local temp and global temp tables.

-- 	What is the difference between DELETE and TRUNCATE? Which one will have better performance and why?
-- Delete you can roll back the data after using however Truncate you cannot. That being said, Truncate is faster because Delete removes data one row at a time and Truncate can just deallocate the data in one fell swoop.

-- 	What is Identity column? How does DELETE and TRUNCATE affect it?
-- Identity column is a column that auto increments given the first number. When deleteing and creating a new record it picks up where it left off (Instead of a new 1 index the index will now be 2). With Truncate, it resets to the initial value, so instead of being 2 or 3 it will be 1.

-- 	What is difference between “delete from table_name” and “truncate table table_name”?
-- Truncate you can't specify any condition for but delete, when you do specify a condition, it removes it in one specific location. 

USE Northwind
GO

-- ⦁	List all cities that have both Employees and Customers.
	SELECT DISTINCT c.City
	FROM Customers c
	INNER JOIN Employees e ON c.City = e.City

--     	List all cities that have Customers but no Employee.
-- 	Use sub-query
	SELECT DISTINCT c.City
	FROM Customers c
	WHERE City NOT IN
    (
        SELECT City FROM Employees
    )
-- 	Do not use sub-query
    SELECT DISTINCT c.City
	FROM Customers c
	INNER JOIN Employees e ON c.City <> e.City

    -- 	List all products and their total order quantities throughout all orders.

    SELECT ProductName, Quantity
    FROM Products p
	INNER JOIN [Order Details] o ON p.ProductID = o.ProductID

    -- 	List all Customer Cities and total products ordered by that city.
    SELECT City, SUM(Quantity) AS TotalProducts
	FROM Customers c
	INNER JOIN Orders o ON c.CustomerID = o.CustomerID
		INNER JOIN [Order Details] d ON o.OrderID = d.OrderID
	Group By City

--     	List all Customer Cities that have at least two customers.
-- 	Use union
	SELECT City
	FROM Customers
	UNION
	SELECT ShipCity
	FROM Orders
	GROUP BY ShipCity
	HAVING COUNT(CustomerID) >= 2


-- 	Use sub-query and no union
	SELECT City
	FROM Customers
	WHERE City IN
	(
		SELECT ShipCity
		FROM Orders
		GROUP BY ShipCity
		HAVING COUNT(CustomerID) >= 2
	)

-- 	List all Customer Cities that have ordered at least two different kinds of products.
    SELECT ShipCity
    FROM Orders
    WHERE OrderID IN
    (
        SELECT OrderID
        FROM [Order Details]
        GROUP BY OrderID
        HAVING COUNT(DISTINCT ProductID) >= 2
    )
    GROUP BY ShipCity

-- 	List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.
    SELECT ContactName AS 'Customer Name', c.City AS 'Customer City', o.ShipCity AS 'Shipped To'
    FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
    WHERE c.City != o.ShipCity

-- 	List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
    SELECT TOP 5 Products, AVG(Price), City
    FROM Customer c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
        INNER JOIN [Order Details] d ON o.OrderID = d.OrderID
        