use [B96157]

--Esteban Quesada Quesada B96157
--Sofia Caastillo Campos B91750

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
	NumHoras tinyint
)


CREATE TABLE Grupo(
	SiglaCurso varchar(15) NOT NULL FOREIGN KEY REFERENCES Curso(Sigla) ON DELETE NO ACTION,
	NumGrupo tinyint NOT NULL,
	Semestre tinyint NOT NULL,
	Anyo int NOT NULL,
	CedProf char(8) NOT NULL FOREIGN KEY REFERENCES Profesor(Cedula) ON UPDATE CASCADE,
	Carga tinyint DEFAULT(0),
	CedAsist char(8) FOREIGN KEY REFERENCES Asistente(Cedula),
	PRIMARY KEY(SiglaCurso,NumGrupo,Semestre,Anyo)
)


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





