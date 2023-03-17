﻿use BD_Universidad

-- a.Recupere el nombre, los apellidos, el número de oficina y la fecha de nombramiento de todos los profesores
Select NombreP,Apellido1, Apellido2, Oficina, FechaNomb
From Profesor

--b. Recupere la cédula y el nombre completo de los estudiantes que han llevado el curso ‘ART2’. Recupere también la nota que obtuvieron en dicho curso
Select Carne,NombreP,Apellido1,Apellido2,Lleva.Nota
From Estudiante,Lleva
Where Estudiante.Cedula = Lleva.CedEstudiante AND Lleva.SiglaCurso = 'ART2'

--c. Recupere el número de carné y el nombre de los estudiantes que tienen notas entre 60 y 80 en cualquier curso, sin que salgan registros repetidos.
Select Distinct Carne,NombreP,Apellido1,Apellido2,Nota 
From Estudiante,Lleva
Where Estudiante.Cedula = Lleva.CedEstudiante AND Lleva.Nota BETWEEN 61 AND 79

--d. Recupere la sigla de los cursos que tienen como requisito al curso ‘CI1312’
Select Requiere_De.SiglaCursoRequeridor
From Curso,Requiere_De
Where Curso.Sigla = Requiere_De.SiglaCursoRequisito AND Requiere_De.SiglaCursoRequisito = 'CI1312'

--e. Recupere la nota máxima, la nota mínima y el promedio de notas obtenidas en el curso ‘CI1221’. Esto debe hacerse en una misma consulta. Dele nombre a las columnas del resultado mediante alias.
From Lleva
Where SiglaCurso = 'CI1221'

--f. Recupere el nombre de las Escuelas y el nombre de todas sus Carreras, ordenadas por nombre de Escuela y luego por nombre de Carrera.
Select Distinct Escuela.Nombre AS NombreEscuela, Carrera.Nombre AS Carrera
From Escuela,Carrera
Where Escuela.Codigo = Carrera.CodEscuela

--g. Recupere la cantidad de profesores que trabajan en la Escuela de Computación e Informática. Suponga que no conoce el código de esta escuela, solo su nombre.
Select Count(CodEscuela)
From Escuela,Trabaja_en
Where Trabaja_en.CodEscuela = Escuela.Codigo AND Escuela.Nombre Like '%Computación%'

--esta no evaluar, es una prueba
Select Distinct Profesor.NombreP, Escuela.Nombre
From Escuela,Profesor,Trabaja_en
Where Trabaja_en.CedProf = Profesor.Cedula AND Escuela.Nombre = 'Escuela de Computación e Informática'

--h. Recupere la cédula de los estudiantes que no están empadronados en ninguna carrera.
From ESTUDIANTE
Except
Select CedEstudiante
From EMPADRONADO_EN
FROM Grupo
FULL OUTER JOIN Asistente
ON Grupo.CedAsist = Asistente.Cedula
From Estudiante
Where Estudiante.Apellido1 Like '%a';

--j2. 
Select Estudiante.NombreP, Estudiante.Apellido1, Estudiante.Apellido2
From Estudiante
Where Estudiante.Apellido1 Like '%a' Or Estudiante.NombreP Like 'M%';

--j3. 
Select Estudiante.NombreP, Estudiante.Apellido1, Estudiante.Apellido2
From Estudiante
Where Estudiante.Apellido1 Like 'M%a';

--k. Recupere el nombre de los estudiantes cuyo nombre tiene exactamente 6 caracteres.
Select Estudiante.NombreP
From Estudiante
Where Len(NombreP) = 6

--l. Liste el nombre completo de los profesores y de los estudiantes de género masculino (el resultado debe salir en una sola lista consolidada). 
Select Distinct Profesor.NombreP, Profesor.Apellido1, Profesor.Apellido2 from Profesor
Where Profesor.Sexo = 'm'
Union
Select Distinct Estudiante.NombreP, Estudiante.Apellido1,Estudiante.Apellido2
From Estudiante
Where Estudiante.Sexo = 'm'

--m. Recupere el carné y nombre completo de los estudiantes que no tienen número de teléfono (o no se tiene registrado en la base de datos).
Select Estudiante.NombreP, Estudiante.Apellido1, Estudiante.Apellido2
From Estudiante
Where Estudiante.Teléfono is NULL