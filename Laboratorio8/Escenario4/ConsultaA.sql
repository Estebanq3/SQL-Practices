use [B96157]

-- Comandos –-
set implicit_transactions off;
set transaction isolation level
serializable;
begin transaction t7;
Select avg(Nota) from Lleva;

Select avg(Nota) from Lleva;
commit transaction t7;

