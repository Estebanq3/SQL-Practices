use [B96157]


--Pregunta 15 
-- Comandos –-
set implicit_transactions off;
set transaction isolation level
repeatable read;
begin transaction t5;
Select avg(Nota) from Lleva;

Select avg(Nota) from Lleva;
commit transaction t5;