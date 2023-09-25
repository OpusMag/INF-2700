-- write settings and queries here and run
-- sqlite3 inf2700_orders.sqlite3 < assignment1_queries.sql
-- to perform the queries
-- for example:

.mode column
.header on

SELECT DISTINCT productName, productVendor
FROM   Products
LIMIT  6;

SELECT *
FROM Customers
WHERE country = 'Norway';

SELECT PR.productName, PL.productLine, PR.productScale 
FROM Products PR NATURAL JOIN ProductLines PL
WHERE PL.productLine = 'Classic Cars';

SELECT OE.orderNumber, OE.requiredDate, PR.productName, OD.quantityOrdered, PR.quantityInStock, OE.status
FROM Orders OE NATURAL JOIN OrderDetails OD NATURAL JOIN Products PR
WHERE OE.status = 'In Process';

SELECT CU.customerNumber, CU.customerName, CU.creditLimit, 
    SUM(OD.quantityOrdered * OD.priceEach) AS totalPrice, 
    PA.amount AS totalPayment, 
    SUM(OD.quantityOrdered * OD.priceEach) - PA.amount AS difference
FROM Customers CU 
INNER JOIN Orders OE ON CU.customerNumber = OE.customerNumber
INNER JOIN OrderDetails OD ON OE.orderNumber = OD.orderNumber
INNER JOIN Products PR ON OD.productCode = PR.productCode
INNER JOIN Payments PA ON OE.customerNumber = PA.customerNumber
GROUP BY CU.customerNumber, CU.customerName, CU.creditLimit
HAVING difference > CU.creditLimit;

WITH customer219Products AS (
    SELECT PR.productCode
    FROM Customers CU
    INNER JOIN Orders OE ON CU.customerNumber = OE.customerNumber
    INNER JOIN OrderDetails OD ON OE.orderNumber = OD.orderNumber
    INNER JOIN Products PR ON OD.productCode = PR.productCode
    WHERE CU.customerNumber = '219'
    GROUP BY PR.productCode
),
customersOrderedProducts AS (
    SELECT CU.customerNumber, PR.productCode
    FROM Customers CU
    INNER JOIN Orders OE ON CU.customerNumber = OE.customerNumber
    INNER JOIN OrderDetails OD ON OE.orderNumber = OD.orderNumber
    INNER JOIN Products PR ON OD.productCode = PR.productCode
    INNER JOIN customer219Products CP ON PR.productCode = PR.productCode
    GROUP BY CU.customerNumber, PR.productCode
),
customersOrderedAllProducts AS (
    SELECT CU.customerNumber
    FROM customersOrderedProducts OP
    INNER JOIN customer219Products CP ON OP.productCode = CP.productCode
    INNER JOIN Customers CU ON OP.customerNumber = CU.customerNumber
    GROUP BY CU.customerNumber
    HAVING COUNT(DISTINCT OP.productCode) = (SELECT COUNT(*) FROM customer219Products)
)
SELECT *
FROM Customers
WHERE customerNumber IN (SELECT customerNumber FROM customersOrderedAllProducts);
