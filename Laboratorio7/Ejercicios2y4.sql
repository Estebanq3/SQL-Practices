use [LabOpt_06]

--Ejercicio 2

--parte a
SELECT *
FROM dbo.SalesOrderHeader
WHERE TotalDue BETWEEN 500 AND 40000;

--parte b correr plan de ejecución

--parte c decir que operadores fisicos se utilizaron

--parte d
CREATE NONCLUSTERED INDEX TotalDueIndex
ON  dbo.SalesOrderHeader(TotalDue);

--parte f
SELECT TotalDue
FROM dbo.SalesOrderHeader
WHERE TotalDue BETWEEN 500 AND 40000;

--parte g revisando el plan de ejecución después de realizar el cambio

--parte h
SELECT SalesOrderID, TotalDue
FROM dbo.SalesOrderHeader
WHERE TotalDue BETWEEN 500 AND 40000;

--parte j
CREATE NONCLUSTERED INDEX TotalDueIndexFixed
ON  dbo.SalesOrderHeader(TotalDue)
INCLUDE(SalesOrderId);

--parte k
SELECT TotalDue
FROM dbo.SalesOrderHeader
WHERE TotalDue BETWEEN 500 AND 40000;

--i
SELECT SalesOrderID, TotalDue
FROM dbo.SalesOrderHeader
WHERE ABS(TotalDue) BETWEEN 500 AND 40000;

--n
SELECT SalesOrderID, TotalDue
FROM dbo.SalesOrderHeader
WHERE TotalDue BETWEEN 500 AND 40000;
SELECT SalesOrderID, TotalDue
FROM dbo.SalesOrderHeader
WHERE ABS(TotalDue) BETWEEN 500 AND 40000;

--p
Drop Index TotalDueIndexFixed On dbo.SalesOrderHeader


--Ejercicio 4

--a
SELECT SalesOrderID, SalesPersonID, ShipDate
FROM dbo.SalesOrderHeader
WHERE SalesPersonID IN
	(SELECT BusinessEntityID
	FROM dbo.SalesPerson
	WHERE TerritoryID > 5)
 AND ShipDate > '2014-01-01' --bSELECT SalesOrderID, SalesPersonID, ShipDate
FROM dbo.SalesOrderHeader soh INNER JOIN dbo.SalesPerson sp
ON ((soh.SalesPersonID = sp.BusinessEntityID AND sp.TerritoryID > 5) AND soh.ShipDate > '2014-01-01')

--e
CREATE NONCLUSTERED INDEX FirstIndex
ON  dbo.SalesOrderHeader(SalesOrderID)
INCLUDE([ShipDate],[SalesPersonID])

CREATE NONCLUSTERED INDEX SecondIndex
ON  dbo.SalesOrderHeader(ShipDate)
INCLUDE([SalesOrderID],[SalesPersonID])


--f
SELECT SalesOrderID, SalesPersonID, ShipDate
FROM dbo.SalesOrderHeader soh INNER JOIN dbo.SalesPerson sp
ON ((soh.SalesPersonID = sp.BusinessEntityID AND sp.TerritoryID > 5) AND soh.ShipDate > '2014-01-01')


