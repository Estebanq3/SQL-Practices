use [B96157]
--Estudiantes: Esteban Quesada Quesada B96157 y Angie Sofia Castillo Campos B91750

--3--
--Se utiliza el disparado INSTEAD OF debido que necesitamos que el disparador se ejcute antes
--del evento que se eliminen los registros de alguna de las tablas. 
--El disparador After no se debe usar porque para efectos de este ejercicio no deseamos que se 
--realicen cambios mediante el delete normal, si no que se realicen mediante el borrado en cascada. 
GO
	CREATE TRIGGER delete_cascade
	ON Carrera INSTEAD OF DELETE
	AS 
	BEGIN
		DECLARE @cod VARCHAR(15)

		SELECT @cod = d.Codigo
		FROM deleted d;

		DELETE FROM Empadronado_En
		WHERE CodCarrera = @cod;

		DELETE FROM Carrera
		WHERE Codigo = @cod;

	END;
GO

SELECT *
FROM Carrera

SELECT *
FROM Empadronado_En

--3.i--
DELETE FROM Carrera WHERE Carrera.Codigo LIKE '1313'

--3.ii--
DELETE FROM Carrera WHERE Carrera.Codigo LIKE '1010'

SELECT *
FROM Carrera

SELECT *
FROM Empadronado_En


--4. Ejercicio de disyunción: Es decir, que asegure que una persona sólo exista en una de las tablas Profesor o Estudiante,
--pero no en ambas.

--4. Disparador para estudiante
GO
CREATE TRIGGER INSERT_WITHOUT_VIOLATE_DISJUNCTION
ON Estudiante
INSTEAD OF INSERT
AS
BEGIN
DECLARE @count INT, @cedula CHAR(8);
SET @cedula = (SELECT Cedula FROM inserted);
IF(NOT EXISTS(SELECT Cedula FROM Profesor WHERE Cedula = @cedula))
	INSERT INTO Estudiante(Cedula,Email,NombreP,Apellido1, Apellido2, Sexo, FechaNacimiento, Direccion, Telefono, Carne,Estado)
	SELECT Cedula, Email, NombreP, Apellido1, Apellido2, Sexo, FechaNacimiento, Direccion, Telefono, Carne, Estado FROM inserted
END;
GO

--4. Disparador para profesor
GO
CREATE TRIGGER INSERT_WITHOUT_VIOLATE_DISJUNCTION2
ON Profesor
INSTEAD OF INSERT
AS
BEGIN
DECLARE @count INT, @cedula CHAR(8);
SET @cedula = (SELECT Cedula FROM inserted);
IF(NOT EXISTS(SELECT Cedula FROM Estudiante WHERE Cedula = @cedula))
	INSERT INTO Profesor(Cedula,Email,NombreP,Apellido1, Apellido2, Sexo, FechaNacimiento, Direccion, Telefono, Categoria,FechaNomb, Titulo, Oficina)
	SELECT Cedula,Email,NombreP,Apellido1, Apellido2, Sexo, FechaNacimiento, Direccion, Telefono, Categoria,FechaNomb, Titulo, Oficina FROM inserted
END;
GO


--4. Pruebas del ejercicio de disyunción
SELECT *
FROM Estudiante
SELECT *
FROM Profesor


--Insertar tabla a Estudiante
INSERT INTO Estudiante(Cedula, Email, NombreP, Apellido1, Apellido2, Sexo, FechaNacimiento, Direccion, Telefono, Carne, Estado)
VALUES ('111', '555@xd', 'Federico', 'Tinoco', 'Martinez', 'M', '2000-09-21', '250 metros sur', '8888', '555444', 'Soltero')

--Insertar tabla a Profesor
INSERT INTO Profesor(Cedula, Email, NombreP, Apellido1, Apellido2, Sexo, FechaNacimiento, Direccion, Telefono, Categoria, FechaNomb, Titulo, Oficina)
VALUES ('333', '420@xd', 'Lacy', 'Mora', 'Flor', 'F', '1960-10-11', '300 metros sur', '1212', 'Interino', '2013-08-14', 'Doctorado', 11)

