-- Lab 1: SQL Queries for Chapters 2-6 from the textbook
-- Textbook: "Database Management Systems" by Pindaro E. Demertzoglou 
-- Available at: https://digitalcommons.newhaven.edu/economics-books/2/
-- Name: Aristotle Malichetty

-- Chapter 2: SELECTING SETS AND SUBSETS OF DATA

-- 1. Retrieve all columns and rows from the customer table
SELECT *
FROM Customers

-- 2. Retrieve field names of the Orders table for documentation purposes
SELECT *
FROM Customers
WHERE 0=1

-- 3. Create a customer list for mailing labels with specific address-related fields
SELECT Lastname, Firstname, Address, City, State, Zip
FROM Customers

-- 4. Create a report of customers in Boston
SELECT *
FROM Customers
WHERE city = 'Boston'

-- 5. Create a list of suppliers from NY state, excluding the state field
SELECT Companyname, Contactname
FROM suppliers
WHERE state = 'NY'

-- 6. Change column titles using aliases for better readability
SELECT CompanyName AS Company, ContactName AS [Supplier Contact]
FROM suppliers

-- 7. Generate a personalized letter to customers
SELECT 'Dear' + ' ' + 
firstname + ' ' + 
'We would like you to know that our full product catalog is on sale in the city of' + ' ' + 
city + ' ' + 
'Please visit our website for details' As CustomerLetter
FROM customers

-- 8. Sort a customer list by last name
SELECT LastName, FirstName, Address, City, State, Zip
FROM Customers
ORDER BY LastName

-- 9. Select all customers except those in Boston and sort by last name
SELECT *
FROM Customers
WHERE city <> 'Boston'
ORDER BY lastname

-- 10. Calculate the number of customers in states (excluding NY) with more than ten customers
SELECT State, Count(CustomerID) As NumberOfCustomers
FROM Customers
WHERE State <> 'NY'
GROUP BY State
HAVING Count(CustomerID) >10
ORDER BY Count(CustomerID) DESC


-- Chapter 3: INSERTING, MOVING AND APPENDING DATA

-- 11. Create a historical table for customers
CREATE TABLE Customer2 (
[CustomerID] int identity (1,1) Primary key not null,
[LastName] nvarchar(50),
[FirstName] nvarchar(50),
[Address] nvarchar(100),
[City] nvarchar(50)
)
-- 12. Append all customer records to the historical table
INSERT INTO Customer2 (firstname, lastname, address, city)
SELECT firstname, lastname, address, city
FROM Customers

-- 13. Append NY customer records to the historical table
INSERT INTO Customer2 (firstname, lastname, address, city)
SELECT firstname, lastname, address, city
FROM customers
WHERE State = 'NY'

-- 14. Create a backup copy of the products table
SELECT *
INTO Products_Backup
FROM Products

-- 15. Create a subset table of products from specific suppliers
SELECT ProductName, UnitsInStock, UnitsOnOrder
INTO Products_Subset
FROM Products
WHERE SupplierID IN (1,2,3,4)

-- 16. Create a joined table of customers, orders, and products for NY customers
SELECT
customers.lastname,
customers.firstName,
Orders.OrderDate,
JoinOrdersProducts.UnitPrice,
JoinOrdersProducts.Quantity
INTO TempCustomersOrders
FROM
(customers
INNER JOIN Orders ON customers.CustomerID = Orders.CustomerID)
INNER JOIN JoinOrdersProducts ON Orders.OrderID = JoinOrdersProducts.OrderID
WHERE customers.State='NY'

-- 17. Create an empty table with the same structure as Products
SELECT * INTO Products1
FROM Products
WHERE 1=2

-- 18. Create a table with part of the Products table structure
SELECT ProductID, ProductName, QuantityPerUnit, ProductPrice INTO Products2
FROM Products
WHERE 1=2

-- 19. Retrieve user tables in the database
SELECT Name, Type
FROM SysObjects
WHERE Type = 'U'

-- 20. Retrieve system tables in the database
SELECT Name, Type
FROM SysObjects
WHERE Type = 'S'


-- Chapter 4: FILTERING DATA - THE OR AND AND OPERATORS

-- 21. Create a quick report with customers in New York or Houston
SELECT *
FROM customers
WHERE city = 'New York' OR city = 'Houston'

-- 22. Produce a report of customers from four cities
SELECT lastname, firstname, city, state
FROM customers
WHERE city IN ('Albany', 'Denver', 'Houston', 'Phoenix')
ORDER BY lastname ASC

-- 23. Create an inventory report listing product quantities for units in stock and units on order
SELECT productname, unitsinstock, unitsonorder
FROM products
WHERE UnitsInStock > 40 OR UnitsOnOrder > 10

-- 24. Create an inventory report using UNION instead of OR operators
SELECT productname, unitsinstock, unitsonorder
FROM products
WHERE UnitsInStock > 40
UNION
SELECT productname, unitsinstock, unitsonorder
FROM products
WHERE UnitsOnOrder > 10

-- 25. Produce a report of customers from a specific state and a specific city
SELECT lastname, firstname, city, state
FROM customers
WHERE state = 'NY' AND city = 'Albany'

-- 26. Produce a report of customers from one state and two cities
SELECT lastname, firstname, city, state
FROM customers
WHERE (state = 'NY' AND city = 'Albany') OR (state = 'NY' AND city = 'New York')
ORDER BY lastname


-- Chapter 5: SORTING RECORDS THE ORDER BY CLAUSE

-- 27. Sorting ascending on one column
SELECT FirstName, LastName, Address, City, Zip, State
FROM Customers
ORDER BY lastname ASC

-- 28. Sorting descending on one column
SELECT FirstName, LastName, Address, City, Zip, State
FROM Customers
ORDER BY lastname DESC

-- 29. Sorting on multiple columns
SELECT city, lastname, firstname
FROM Customers
ORDER BY city, lastname ASC

-- 30. Use the ORDER BY clause to sort on multiple columns but with different sorting direction for each column
SELECT city, lastname, firstname
FROM Customers
ORDER BY city ASC, lastname DESC

-- 31. Use the ORDER BY clause with null values
SELECT lastname, firstname
FROM Customers
ORDER BY firstname

-- 32. Use the ORDER BY clause with numbers
SELECT productname, unitsinstock
FROM products
ORDER BY unitsinstock DESC

-- 33. The ORDER BY clause with dates
SELECT ProductName, ProductPrice, DateEnteredInventory
FROM Products
ORDER BY DateEnteredInventory DESC

-- 34. TIP: Combine the ORDER BY and TOP clauses to control the result set
SELECT TOP 7 unitsinstock, productname
FROM products
ORDER BY unitsinstock DESC

-- 35. Pay attention to the behavior of the TOP clause when combined with ORDER BY
SELECT TOP 10 unitsinstock, productname
FROM products
ORDER BY unitsinstock DESC

-- 36. Determine your own sort order using the CASE function
SELECT FirstName, LastName, City, State
FROM Customers
WHERE STATE in ('NY','CA','TX')
ORDER BY
CASE State
When 'NY' THEN 1
When 'CA' THEN 2
When 'TX' THEN 3
Else 4
End

-- Chapter 6: FILTERING DATA WITH WILDCARD CHARACTERS

-- 37. Create a list of customers whose last name starts with D
SELECT FirstName, LastName, Address, City, State, Zip
FROM customers
WHERE lastname LIKE 'D%'

-- 38. Create a customer list using _ and % to create intricate search patterns
SELECT FirstName, LastName, Address, City, State, Zip
FROM customers
WHERE lastname LIKE 'Da_e%'

-- 39. Create a customer list using [0-9] to create search patterns
SELECT FirstName, LastName, Address, City, State, Zip
FROM customers
WHERE zip LIKE '12[0-9][0-9][0-9]'

-- 40. Create a customer list using multi-character search patterns
SELECT FirstName, LastName, Address, City, State, Zip
FROM customers
WHERE lastname LIKE 'C[ru]%'

-- 41. Create a customer list using specific characters as exclusion search patterns
SELECT FirstName, LastName, Address, City, State, Zip
FROM customers
WHERE lastname LIKE '[^abcde]%'
ORDER BY lastname

-- 42. Create a customer list using sets of characters as exclusion ranges
SELECT FirstName, LastName, Address, City, State, Zip
FROM customers
WHERE lastname LIKE '[^a-p]%'
ORDER BY lastname

-- 43. Create a customer list using sets of characters as inclusion ranges
SELECT FirstName, LastName, Address, City, State, Zip
FROM customers
WHERE lastname LIKE '[a-p]%'
ORDER BY lastname
