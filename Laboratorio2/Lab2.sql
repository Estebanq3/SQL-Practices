use [B96157]

--Varchar vs Char
--Varchar se adapta la cantidad de caracteres recibidos mientras que el char rellena con espacios en blanco los caracteres de sobra
--Tipos de Int:
-- bigint -2^63 a (2^63) -1
--int -2^31 a (2^31) -1
--smallint -2^15 a (2^15) -1
--tinyint 0 a 255

CREATE TABLE Estudiante (
	Cedula char(8) NOT NULL PRIMARY KEY,
	Email varchar(50),
	NombreP varchar(50),
	Apellido1 varchar(50),
	Apellido2 varchar(50),
	Sexo char(1),
	FechaNacimiento Date,
	Direccion varchar(100),
	Telefono char(8),
	Carne varchar(10),
	Estado varchar(8)
)

CREATE TABLE Profesor(
	Cedula char(8) NOT NULL PRIMARY KEY,
	Email varchar(50),
	NombreP varchar(50),
	Apellido1 varchar(50),
	Apellido2 varchar(50),
	Sexo char(1),
	FechaNacimiento Date,
	Direccion varchar(100),
	Telefono char(8),
	Categoria varchar(20),
	FechaNomb date,
	Titulo varchar(15),
	Oficina tinyint
)

CREATE TABLE Asistente(
	Cedula char(8) FOREIGN KEY REFERENCES Estudiante(Cedula),
	NumHoras tinyint,
	PRIMARY KEY(Cedula)
)

CREATE TABLE Curso(
	Sigla varchar(15) NOT NULL PRIMARY KEY,
	Nombre varchar(30),
	Creditos tinyint
)

CREATE TABLE Grupo(
	SiglaCurso varchar(15) NOT NULL FOREIGN KEY REFERENCES Curso(Sigla) ON DELETE NO ACTION,
	NumGrupo tinyint NOT NULL,
	Semestre tinyint NOT NULL,
	Anyo int NOT NULL,
	CedProf char(8) NOT NULL FOREIGN KEY REFERENCES Profesor(Cedula),
	Carga tinyint DEFAULT(0),
	CedAsist char(8) FOREIGN KEY REFERENCES Asistente(Cedula),
	PRIMARY KEY(SiglaCurso,NumGrupo,Semestre,Anyo)
)

SELECT * FROM Grupo



CREATE TABLE Lleva(
	CedEstudiante char(8) NOT NULL FOREIGN KEY REFERENCES Estudiante(Cedula),
	SiglaCurso varchar(15) NOT NULL,
	NumGrupo tinyint NOT NULL,
	Semestre tinyint NOT NULL,
	Anyo int NOT NULL,
	Nota tinyint CHECK(Nota >= 0 AND Nota <= 100),
	FOREIGN KEY(SiglaCurso, NumGrupo, Semestre, Anyo) REFERENCES Grupo(SiglaCurso, NumGrupo, Semestre, Anyo),
	PRIMARY KEY(CedEstudiante,SiglaCurso,NumGrupo, Semestre, Anyo)
)

CREATE TABLE Carrera(
	Codigo varchar(15) NOT NULL PRIMARY KEY,
	Nombre varchar(50),
	AnyoCreacion int,
)

CREATE TABLE Empadronado_En(
	CedEstudiante char(8) NOT NULL FOREIGN KEY REFERENCES Estudiante(Cedula) ON DELETE CASCADE,
	CodCarrera varchar(15) NOT NULL FOREIGN KEY REFERENCES Carrera(Codigo),
	PRIMARY KEY(CedEstudiante,CodCarrera),
	FechaIngreso date,
	FechaGraduacion date
)

CREATE TABLE Pertenece_a(
	SiglaCurso varchar(15) NOT NULL FOREIGN KEY REFERENCES Curso(Sigla),
	CodCarrera varchar(15) NOT NULL FOREIGN KEY REFERENCES Carrera(Codigo),
	NivelPlanEstudios tinyint,
	PRIMARY KEY(SiglaCurso,CodCarrera)
)

---------------------------------------------------------------------------------------------------

--Insertar dos tablas a Estudiante
INSERT INTO Estudiante(Cedula, Email, NombreP, Apellido1, Apellido2, Sexo, FechaNacimiento, Direccion, Telefono, Carne, Estado)
VALUES (666, '666@xd', 'Panchita', 'Espinoza', 'Martinez', 'F', '2000-09-21', '250 metros norte', '32434', '666777', 'Mal')

INSERT INTO Estudiante(Cedula, Email, NombreP, Apellido1, Apellido2, Sexo, FechaNacimiento, Direccion, Telefono, Carne, Estado)
VALUES (333, '333@xd', 'Panchito', 'Espinoza', 'Martinez', 'F', '2000-09-21', '250 metros norte', '32434', '666777', 'Mal')

INSERT INTO Estudiante(Cedula, Email, NombreP, Apellido1, Apellido2, Sexo, FechaNacimiento, Direccion, Telefono, Carne, Estado)
VALUES (555, '555@xd', 'Federico', 'Tinoco', 'Martinez', 'M', '2000-09-21', '250 metros sur', '8888', '555444', 'Soltero')

--Insertar dos tablas a Profesor
INSERT INTO Profesor(Cedula, Email, NombreP, Apellido1, Apellido2, Sexo, FechaNacimiento, Direccion, Telefono, Categoria, FechaNomb, Titulo, Oficina)
VALUES (999, '420@xd', 'Lacy', 'Mora', 'Flor', 'F', '1960-10-11', '300 metros sur', '1212', 'Interino', '2013-08-14', 'Doctorado', 11)

INSERT INTO Profesor(Cedula, Email, NombreP, Apellido1, Apellido2, Sexo, FechaNacimiento, Direccion, Telefono, Categoria, FechaNomb, Titulo, Oficina)
VALUES (555, '635@xd', 'Ecci', 'Toso', 'Mora', 'M', '1999-10-11', '300 metros oeste', '8584', 'Propietario', '2013-08-14', 'Doctorado', 12)

--Insertar dos tablas a Asistente
INSERT INTO Asistente(Cedula, NumHoras)
VALUES (666, 4)

INSERT INTO Asistente(Cedula, NumHoras)
VALUES (333, 8)

--Insertar dos tablas a Asistente
INSERT INTO Curso(Sigla, Nombre, Creditos)
VALUES ('CI-101', 'Bases', 4)

INSERT INTO Curso(Sigla, Nombre, Creditos)
VALUES ('CI-102', 'Inge', 4)

INSERT INTO Curso(Sigla, Nombre, Creditos)
VALUES ('CI-103', 'Desempenyo', 4)

INSERT INTO Curso(Sigla, Nombre, Creditos)
VALUES ('CI-104', 'Ingles', 4)

--Insertar dos tablas a Grupo
INSERT INTO Grupo(SiglaCurso, NumGrupo, Semestre, Anyo, CedProf, Carga, CedAsist)
VALUES ('CI-101', 1, 1, 2020, 555, 4, 666)

INSERT INTO Grupo(SiglaCurso, NumGrupo, Semestre, Anyo, CedProf, Carga, CedAsist)
VALUES ('CI-102', 1, 1, 2020, 111, 4, 333)

INSERT INTO Grupo(SiglaCurso, NumGrupo, Semestre, Anyo, CedProf, Carga, CedAsist)
VALUES ('CI-103', 1, 1, 2020, 111, 4, 333)

INSERT INTO Grupo(SiglaCurso, NumGrupo, Semestre, Anyo, CedProf, Carga, CedAsist)
VALUES ('CI-104', 1, 1, 2020, 555, 4, 666)


SELECT * FROM Grupo 
SELECT * FROM Lleva
SELECT * FROM Profesor

--Insertar dos tablas a Lleva
INSERT INTO Lleva(CedEstudiante, SiglaCurso, NumGrupo, Semestre, Anyo, Nota)
VALUES (666, 'CI-101', 1, 1, 2020, 45)

INSERT INTO Lleva(CedEstudiante, SiglaCurso, NumGrupo, Semestre, Anyo, Nota)
VALUES (333, 'CI-101', 1, 1, 2020, 97)

--Insertar dos tablas a Carrera
INSERT INTO Carrera(Codigo, Nombre, AnyoCreacion)
VALUES (1010, 'Informatica', 1989)

INSERT INTO Carrera(Codigo, Nombre, AnyoCreacion)
VALUES (1212, 'Medicina', 1940)

--Insertar dos tablas a Empadronado_En
INSERT INTO Empadronado_En(CedEstudiante, CodCarrera, FechaIngreso, FechaGraduacion)
VALUES (666, 1010, '1989-07-23', '2000-12-4')

INSERT INTO Empadronado_En(CedEstudiante, CodCarrera, FechaIngreso, FechaGraduacion)
VALUES (333, 1212, '1955-03-01', '1958-12-4')

INSERT INTO Empadronado_En(CedEstudiante, CodCarrera, FechaIngreso, FechaGraduacion)
VALUES (555, 1212, '1955-04-01', '1958-11-4')

--Insertar dos tablas a Pertenece_a
INSERT INTO Pertenece_a(SiglaCurso, CodCarrera, NivelPlanEstudios)
VALUES ('CI-101', 1010, 10)

INSERT INTO Pertenece_a(SiglaCurso, CodCarrera, NivelPlanEstudios)
VALUES ('CI-101', 1212, 12)



--Parte 5
--ON DELETE CASCADE
--Empadronado_en y Estudiante 

--a
SELECT Estudiante.*
FROM Estudiante

--b
SELECT Empadronado_En.*
FROM Empadronado_En

--c y d
DELETE FROM Estudiante
WHERE Estudiante.Cedula = '555'

--ON UPDATE CASCADE
--Grupo y Profesor
--a
SELECT Profesor.*
FROM Profesor
--b
SELECT Grupo.*
FROM Grupo
--c y d
UPDATE Profesor 
SET Profesor.Cedula = '111'
WHERE Profesor.Cedula = '999'

--ON DELETE NO ACTION
--Grupo y Curso 

--a
SELECT Curso.*
FROM Curso

--b
SELECT Grupo.*
FROM Grupo

--c y d 
DELETE FROM Curso WHERE Sigla = '666'



