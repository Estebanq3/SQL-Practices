use [B96157]
--Estudiantes: Esteban Quesada Quesada B96157 y Angie Sofia Castillo Campos B91750

--2
GO
CREATE TRIGGER delete_cascade
ON Carrera INSTEAD OF DELETE
AS
BEGIN
	DECLARE @cod VARCHAR(15)

	DECLARE c CURSOR FOR
		SELECT Codigo
		FROM deleted d;

	OPEN c;

	FETCH NEXT FROM c INTO @cod
	WHILE @@FETCH_STATUS = 0 BEGIN
		DELETE FROM Empadronado_En
		WHERE CodCarrera = @cod;

		DELETE FROM Carrera
		WHERE Codigo = @cod;

		FETCH NEXT FROM c INTO @cod
	END
	CLOSE c;
	DEALLOCATE c; 
END;
GO

DELETE FROM Carrera
WHERE Nombre LIKE '%m%' OR Nombre LIKE '%M%'

SELECT *
FROM Carrera

SELECT *
FROM Empadronado_En

--3
CREATE VIEW NombramientoAsistentes AS
SELECT CedAsist, Semestre, Anyo, COUNT(CedAsist) AS NumGrupos
FROM Grupo
GROUP BY Semestre, Anyo, CedAsist

SELECT * FROM NombramientoAsistentes
SELECT * FROM Curso
SELECT * FROM Grupo



--4.
SELECT * FROM NombramientoAsistentes
SELECT * FROM Grupo

GO
CREATE TRIGGER ControlAsistentes
ON Grupo INSTEAD OF UPDATE
AS
BEGIN
    DECLARE @cedula CHAR (9), @siglaCurso varchar(10), @grupo int, @semestre int,@anyo int,@profesor char(9),@cargaGrupo int
    DECLARE @carga int

    DECLARE c CURSOR  FOR
        SELECT CedAsist, SiglaCurso, NumGrupo, Semestre, Anyo, CedProf, Carga
        FROM inserted;

    OPEN c;

    FETCH NEXT FROM c INTO @cedula, @siglaCurso,@grupo, @semestre,@anyo,@profesor,@cargaGrupo
    WHILE  @@FETCH_STATUS = 0 BEGIN
         SET @carga = (SELECT NumGrupos FROM NombramientoAsistentes WHERE CedAsist= @cedula AND Semestre = @semestre AND Anyo = @anyo);
         if(@carga < 3 or @carga is null)
            UPDATE Grupo
            SET CedAsist = @cedula
            WHERE SiglaCurso = @siglaCurso AND NumGrupo = @grupo AND Semestre = @semestre AND Anyo = @anyo AND CedProf = @profesor and Carga = @cargaGrupo

        FETCH NEXT FROM c INTO  @cedula, @siglaCurso,@grupo, @semestre,@anyo,@profesor,@cargaGrupo
    END
    CLOSE c;
    DEALLOCATE c;

END;
GO

--i.
UPDATE Grupo
SET CedAsist = '666'
WHERE SiglaCurso = 'CI-102' AND NumGrupo = 1  AND Semestre = 1 AND Anyo = 2020 AND CedProf = 111 AND Carga = 4;

--ii.
UPDATE Grupo
SET CedAsist = '666'
WHERE SiglaCurso = 'CI-103' AND NumGrupo = 1  AND Semestre = 1 AND Anyo = 2020 AND CedProf = 111 AND Carga = 4;
 
 --iii.
UPDATE Grupo
SET CedAsist = '666'
WHERE SiglaCurso = 'CI-101'

UPDATE Grupo
SET CedAsist = '666'
WHERE SiglaCurso = 'CI-102' OR SiglaCurso = 'CI-103'


