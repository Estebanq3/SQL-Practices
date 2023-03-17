use [B96157]

-- Comandos –-
set implicit_transactions off;
begin transaction t8;
Insert into Lleva(CedEstudiante, SiglaCurso, NumGrupo, Semestre, Anyo, Nota)
values('333', 'CI-103', 1, 1,2020, 85);commit transaction t8;