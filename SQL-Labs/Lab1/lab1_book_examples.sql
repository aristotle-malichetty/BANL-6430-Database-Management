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
