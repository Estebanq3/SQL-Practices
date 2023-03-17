use BD_Universidad

--[50 pts.] Para aquellas escuelas que tienen más de una carrera, liste el nombre de la escuela
--y la cantidad de carreras que tiene. No contemple carreras creadas antes de 1980. El
--resultado debe listar el nombre de la escuela y la cantidad de carreras creadas desde 1980.

SELECT DISTINCT Escuela.Nombre, COUNT(Escuela.Codigo) AS NumCarreras
FROM Escuela 
JOIN Carrera
ON Escuela.Codigo = Carrera.CodEscuela
WHERE Carrera.AnnoCreacion > '1980'
GROUP BY Escuela.Nombre
HAVING COUNT(Escuela.Codigo) > 1


SELECT e.Nombre, Count(c.CodEscuela) as CantidadCarreras
FROM Escuela as e JOIN Carrera as c on e.Codigo = c.CodEscuela
WHERE c.AnnoCreacion >= '1980-01-01'
GROUP BY e.Nombre
HAVING Count(c.CodEscuela) > 1