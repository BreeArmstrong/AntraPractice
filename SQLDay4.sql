-- Answer following questions
-- What is View? What are the benefits of using views?
-- A view is a virtual table that is often used to give just the most important information to customers or end users in general.

-- Can data be modified through views?
-- Yes, but it doesn't modify the view, it modifies the actual table you are pulling data from.

-- What is stored procedure and what are the benefits of using it?
-- Stored procedures are prepared sql queries that can be stored and re-ran again. This is useful to help fight against the security issues of the view (sql injection)

-- What is the difference between view and stored procedure?
-- A view is a virtual table where as a stored procedure is a set of direction (query) that can be reused. The Stored procedure can be used in a view 

-- What is the difference between stored procedure and functions?
-- Stored procedures may or may not have input and output, they are used for DML procedures and the can call a function. A function must have input and output parameters, they are mainly used for calculations/ dealing with the data and they cannot call a stored procedure.

-- Can stored procedure return multiple result sets?
-- Yes.

-- Can stored procedure be executed as part of SELECT Statement? Why?
-- Yes, but only if it returns a result set, otherwise you should use Exec.

-- What is Trigger? What types of Triggers are there?
-- A trigger is a special kind of Stored procedure that triggers based on an event happening. They can do DML, DDL, and logon.

-- What is the difference between Trigger and Stored Procedure?
-- A Trigger, triggers automatically whereas a stored procedure must be called. Though it should be noted a trigger is a special kind of stored procedure.

-- Queries:
    USE Northwind
    GO
--     Create a view named “view_product_order_[your_last_name]”, list all products and total ordered quantity for that product
	-- CREATE View View_product_order_Armstrong
	-- AS 
	-- SELECT ProductName, d.Quantity
	-- FROM Products p
	-- INNER JOIN [Order Details] d ON p.ProductID = d.ProductID
	-- END

	-- SELECT * FROM View_product_order_Armstrong

--     Create a stored procedure “sp_product_order_quantity_[your_last_name]” that accept product id as an input and total quantities of order as output parameter.
	CREATE PROC sp_product_order_quantity_Armstrong @Product int, @Total int OUTPUT
	AS 
	SELECT p.ProductName, d.Quantity
	FROM Products p
	INNER JOIN [Order Details] d ON p.ProductID = d.ProductID
	WHERE p.ProductID = @Product AND Quantity = @Total
	GO


-- Create a stored procedure “sp_product_order_city_[your_last_name]” that accept product name as an input and top 5 cities that ordered most that product combined with the total quantity of that product ordered from that city as output.
	CREATE PROC sp_product_order_city_Armstrong @Product varchar(50), @City varchar(20) OUTPUT
	AS 
	SELECT TOP 5 o.ShipCity, p.ProductName, d.Quantity
	FROM Products p
	INNER JOIN [Order Details] d ON p.ProductID = d.ProductID
	INNER JOIN Orders o ON o.OrderID = d.OrderID
	WHERE p.ProductName = @Product AND o.ShipCity = @City
    ORDER BY o.ShipCity DESC
	GO

-- Create 2 new tables “people_your_last_name” “city_your_last_name”. City table has two records: {Id:1, City: Seattle}, {Id:2, City: Green Bay}. People has three records: {id:1, Name: Aaron Rodgers, City: 2}, {id:2, Name: Russell Wilson, City:1}, {Id: 3, Name: Jody Nelson, City:2}. Remove city of Seattle. If there was anyone from Seattle, put them into a new city “Madison”. Create a view “Packers_your_name” lists all people from Green Bay. If any error occurred, no changes should be made to DB. (after test) Drop both tables and view.
-- CREATE TABLE people_Armstrong (id int, Name varchar(20), City Varchar(20))
-- CREATE TABLE city_Armstrong (Id int, City varchar(20))

-- INSERT INTO city_Armstrong (Id, City)
-- VALUES (1, 'Seattle'), (2, 'Green Bay')

-- INSERT INTO people_Armstrong (id, Name, City)
-- VALUES (1, 'Aaron Rodgers', 2), (2, 'Russell Wilson', 1), (3, 'Jody Nelson', 2)

-- SELECT * FROM city_Armstrong
-- SELECT * FROM people_Armstrong

-- DELETE FROM city_Armstrong WHERE City = 'Seattle'

-- INSERT INTO city_Armstrong
--  Values (1,'Madison')

-- CREATE VIEW Packers_Armstrong
-- AS
-- SELECT p.Name, c.City
-- FROM people_Armstrong p
-- INNER JOIN city_Armstrong c ON p.city = c.Id
-- END

-- DROP TABLE city_Armstrong 
-- DROP TABLE people_Armstrong
-- DROP VIEW Packers_Armstrong

--  Create a stored procedure “sp_birthday_employees_[you_last_name]” that creates a new table “birthday_employees_your_last_name” and fill it with all employees that have a birthday on Feb. (Make a screen shot) drop the table. Employee table should not be affected.


-- CREATE PROC sp_birthday_employees_Armstrong
-- AS 
-- BEGIN 
-- CREATE TABLE birthday_employees_Armstrong (FirstName Varchar(20), LastName varchar(20))
-- INSERT INTO birthday_employees_Armstrong (FirstName, LastName)
-- 	SELECT FirstName, MONTH(BirthDate) AS 'Month'
-- 	FROM Employees
-- 	WHERE MONTH(BirthDate) = 2
-- END

-- EXEC sp_birthday_employees_Armstrong

-- SELECT * FROM birthday_employees_Armstrong

-- DROP PROC sp_birthday_employees_Armstrong

	SELECT FirstName, MONTH(BirthDate) AS 'Month'
	FROM Employees
    
-- How do you make sure two tables have the same data?
-- You can select all from table one minus select all from table 2, if nothing is returned then the data is exactly the same.
-- 7.
	-- SELECT FirstName + ' ' + LastName + ' ' + MiddleName + '.' AS 'Full Name'
	-- FROM Employees
