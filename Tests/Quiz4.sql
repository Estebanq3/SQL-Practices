use [B96157]

--Integrantes:
--Sofia Castillo Campos B91750
--Esteban Quesada Quesada B96157

--2.
GO
CREATE TRIGGER Delete_Set_Null
ON Asistente INSTEAD OF Delete
AS
BEGIN
    DECLARE @ced CHAR (9)

    DECLARE e CURSOR  FOR
        SELECT Cedula
        FROM deleted;

    OPEN e;

    FETCH NEXT FROM e INTO @ced
    WHILE  @@FETCH_STATUS = 0 BEGIN
        UPDATE Grupo
        SET CedAsist = NULL
        WHERE CedAsist = @ced;

        DELETE FROM  Asistente
        WHERE Cedula = @ced

        FETCH NEXT FROM e INTO  @ced
    END
    CLOSE e;
    DEALLOCATE e;

END;
GO

DELETE FROM Asistente
WHERE Cedula LIKE '333'

SELECT *
FROM Asistente

SELECT * 
FROM Grupo


-- 1.
GO
    CREATE PROCEDURE CantDocentesPorCarrera(@Umbral int, @Anyo int) AS
    BEGIN
        SELECT DISTINCT Carrera.Nombre AS Carrera, 
		COUNT(DISTINCT Profesor.Cedula) AS NumeroDocentes
        FROM Carrera JOIN Pertenece_a 
		ON Carrera.Codigo = Pertenece_a.CodCarrera
        JOIN Grupo 
		ON Grupo.SiglaCurso = Pertenece_a.SiglaCurso
        JOIN Profesor 
		ON Profesor.Cedula = Grupo.CedProf
        GROUP BY Carrera.Nombre, Grupo.Anyo
        HAVING (COUNT(Profesor.Cedula) > @Umbral) AND (Grupo.Anyo = @Anyo)
		ORDER BY  NumeroDocentes DESC
    END
GO

EXEC CantDocentesPorCarrera @Umbral = 0, @Anyo = 2020


