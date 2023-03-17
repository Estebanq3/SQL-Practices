use [B96157]


--Pregunta 15
--Comandos –-
set implicit_transactions off;
begin transaction t6;
Insert into Lleva(CedEstudiante, SiglaCurso,NumGrupo, Semestre, Anyo, Nota)
SELECT *values('666', 'CI-104', 1, 1,2020, 97);
commit transaction t6;
