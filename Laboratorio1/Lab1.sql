use BD_Universidad

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

--e. Recupere la nota máxima, la nota mínima y el promedio de notas obtenidas en el curso ‘CI1221’. Esto debe hacerse en una misma consulta. Dele nombre a las columnas del resultado mediante alias.Select MAX(Nota) AS NotaMaxima, MIN(Nota) AS NotaMinima, AVG(Nota) AS AVG
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

--h. Recupere la cédula de los estudiantes que no están empadronados en ninguna carrera.Select Cedula
From ESTUDIANTE
Except
Select CedEstudiante
From EMPADRONADO_EN-- i. Recupere la sigla, el número de grupo, el semestre y el año de todos los grupos, su asistente (indique solo la cédula del asistente) y la cantidad de horas que el asistente tiene asignadas al grupo. --Si un grupo no tiene asistente, de igual forma debe salir en el resultado de la consulta (con el asistente y las horas de asistencia en NULL). ¿Qué tipo de join es necesario usar aquí y por qué?--El Outer Join--Justificación:--El FULL OUTER JOIN es útil en este caso porque devuelve todos los registros cuando hay una coincidencia en los registros de la tabla izquierda (tabla1) o --derecha (tabla2), de esta forma las coincidencias entre el asistente y un determinado grupo serán tomandas en cuenta también. --De esta forma el full outer join retorna toda la información seleccionada de los grupos y NumHoras de asistente,  y si un --grupo no tiene asistente, mostrará null en el campo de CedAsist y NumHoras.SELECT Grupo.SiglaCurso, Grupo.NumGrupo, Grupo.Semestre, Grupo.Anno, Grupo.CedAsist, Asistente.NumHoras
FROM Grupo
FULL OUTER JOIN Asistente
ON Grupo.CedAsist = Asistente.Cedula--j1. Recupere el nombre de los estudiantes cuyo primer apellido termina en ‘a’. ¿Cómo cambiaría la consulta para incluir también a los estudiantes cuyo nombre inicia con ‘M’? ¿Cómo cambiaría la consulta para que solo recupere los estudiantes cuyo primer apellido inicia con ‘M’ y termina con ‘a’?Select Estudiante.NombreP, Estudiante.Apellido1, Estudiante.Apellido2
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