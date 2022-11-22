SELECT C.name AS Customers
  FROM Customers C
 LEFT JOIN Orders O ON O.customerID = C.id
WHERE O.customerId IS NULL;