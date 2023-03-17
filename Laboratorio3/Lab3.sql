use [BD_Universidad]

--1. Recupere el nombre y primer apellido de los asistentes, y el nombre de los cursos que han asistido. Si un asistente ha asistido varias veces un mismo curso, el curso sólo debe aparecer una vez en el resultado.
SELECT DISTINCT Estudiante.NombreP,Estudiante.Apellido1, Curso.Nombre
FROM Estudiante JOIN  Asistente
ON Estudiante.Cedula = Asistente.Cedula  JOIN  Grupo
ON Asistente.Cedula = Grupo.CedAsist JOIN Curso
ON Grupo.SiglaCurso = Curso.Sigla


--2. Para el estudiante llamado “Gabriel Sánchez”, liste el expediente académico (incluyendo sigla del curso, número de grupo, semestre, año y nota) de los cursos que ha matriculado, y el nivel del plan de estudios en el que está cada uno de los cursos aprobados. El listado debe ordenarse por nivel del plan de estudios, y luego por sigla.
SELECT DISTINCT Estudiante.NombreP, Estudiante.Cedula, Curso.Sigla, Grupo.NumGrupo, Lleva.Anno, Lleva.Nota, Pertenece_a.NivelPlanEstudios, Grupo.Semestre
FROM Estudiante JOIN  Lleva
ON Estudiante.Cedula = Lleva.CedEstudiante JOIN Curso
ON Curso.Sigla = Lleva.SiglaCurso JOIN Grupo
ON Grupo.NumGrupo = Lleva.NumGrupo  AND Grupo.Semestre = Lleva.Semestre  JOIN Pertenece_a
ON Pertenece_a.SiglaCurso = Curso.Sigla
WHERE Estudiante.NombreP = 'Gabriel' AND Estudiante.Apellido1 = 'Sánchez'
ORDER BY Pertenece_a.NivelPlanEstudios, Curso.Sigla

--3. Recupere la cantidad de profesores por grado académico (título). Ordene el resultado por cantidad de profesores, de mayor a menor.
SELECT Profesor.Titulo, COUNT(Profesor.Cedula) AS Cantidad
FROM Profesor
GROUP BY Profesor.Titulo 

--4. Calcule el promedio de notas de cada estudiante. El reporte debe listar la cédula del estudiante en la primera columna y su promedio en la segunda columna, ordenado por cédula
SELECT Estudiante.Cedula, AVG(Lleva.Nota) AS Promedio 
  FROM Estudiante
  JOIN Lleva 
  ON Estudiante.Cedula = Lleva.CedEstudiante
 GROUP BY Estudiante.Cedula
 ORDER BY Estudiante.Cedula

--5. Para cada proyecto de investigación, obtenga el total de carga asignada al proyecto (la suma de la carga de cada uno de sus participantes).
SELECT Investigacion.NumProy, SUM(Participa_en.Carga) AS Carga
  FROM Investigacion
  JOIN Participa_en 
  ON  Investigacion.NumProy = Participa_en.NumProy
 GROUP BY Investigacion.NumProy

 --6. Para aquellos cursos que pertenecen a más de 2 carreras, recupere la sigla del curso y la cantidad de carreras que tienen ese curso en su plan de estudios.
 SELECT Curso.Sigla,COUNT(Pertenece_a.CodCarrera) AS Carreras
  FROM Curso
  JOIN Pertenece_a
  ON  Curso.Sigla = Pertenece_a.SiglaCurso JOIN Carrera
  ON Carrera.Codigo = Pertenece_a.CodCarrera
 GROUP BY Curso.Sigla
 HAVING COUNT(Carrera.Codigo) > 2

--7. Para todas las facultades, recupere el nombre de la facultad y la cantidad de carreras que posee. Si hay facultades que no poseen escuelas o carreras, deben salir en el listado con cero en la cantidad de carreras. Ordene descendentemente por cantidad de carreras (de la facultad que tiene más carreras la que tiene menos).
 SELECT Facultad.Nombre, COUNT(Carrera.Codigo) AS NumeroCarreras
  FROM Facultad
  FULL OUTER JOIN Escuela
  ON  Facultad.Codigo = Escuela.CodFacultad FULL OUTER JOIN Carrera
  ON Escuela.Codigo = Carrera.CodEscuela
 GROUP BY Facultad.Nombre
 ORDER BY NumeroCarreras DESC

--8. Liste la cantidad de estudiantes matriculados en cada grupo de cursos de computación (sigla  inicia con el prefijo “CI”). Se debe mostrar el número de grupo, la sigla de curso, el semestre y 
--el año de cada grupo, además de la cantidad de estudiantes matriculados en él. Si hay grupos 
--que no tienen estudiantes matriculados, deben salir en el listado con cero en la cantidad de 
--estudiantes. Ordene por año, luego por semestre, y finalmente por sigla y grupo

SELECT Grupo.NumGrupo, Grupo.SiglaCurso, Grupo.Semestre, Grupo.Anno, COUNT(cedEstudiante) AS cantidad_Estudiantes
FROM Lleva
FULL OUTER JOIN Grupo
ON Lleva.SiglaCurso = Grupo.SiglaCurso and Lleva.NumGrupo = Grupo.NumGrupo and Lleva.Semestre = Grupo.Semestre  and Lleva.Anno = Grupo.Anno 
GROUP BY Grupo.NumGrupo, Grupo.SiglaCurso, Grupo.Semestre, Grupo.Anno
HAVING Grupo.SiglaCurso like 'CI%'
ORDER BY Anno, Semestre, SiglaCurso, NumGrupo

 --9.Liste los grupos (identificados por sigla de curso, número de grupo, semestre y año) donde la 
--nota mínima obtenida por los estudiantes fue mayor o igual a 70 (es decir, todos los estudiantes 
--aprobaron). Muestre también la nota mínima, máxima, y promedio de cada grupo en el
--resultado. Ordene el resultado descendentemente por el promedio de notas del grupo

 SELECT DISTINCT Grupo.SiglaCurso, Grupo.NumGrupo, Lleva.Semestre, Grupo.Anno,  MIN(Lleva.Nota) AS NotaMinima, MAX(Lleva.Nota) AS NotaMaxima, AVG(Lleva.Nota) AS NotaPromedio
 FROM Grupo
 FULL OUTER JOIN Lleva
 ON  Grupo.SiglaCurso = Lleva.SiglaCurso AND Grupo.NumGrupo = Lleva.NumGrupo AND Grupo.Semestre = Lleva.Semestre  AND Grupo.Anno = Lleva.Anno
 GROUP BY Grupo.SiglaCurso, Lleva.SiglaCurso, Grupo.NumGrupo, Lleva.NumGrupo, Grupo.Semestre, Lleva.Semestre, Grupo.Anno, Lleva.Anno
 HAVING MIN(Lleva.Nota) >= 70
 ORDER BY NotaPromedio DESC

 