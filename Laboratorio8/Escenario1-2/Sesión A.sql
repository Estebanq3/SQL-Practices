use [B91750]


---Ejercicio #4

set implicit_transactions off; 
set transaction isolation level 
read uncommitted; 
 
begin transaction t1; 
PRINT @@TRANCOUNT 
 
Select avg(Nota) from Lleva; 

---Ejercicio #6
Select avg(Nota) from Lleva;

---Ejercicio #8
Select avg(Nota) from Lleva; 
 
Commit transaction t1; 

---Ejercicio #10
set implicit_transactions off; 
set transaction isolation level 
read committed; 
 
begin transaction t3; 
Select avg(Nota) from Lleva;

---Ejercicio #12
Select max(Nota) from Lleva;

--Ejercicio #14

Commit transaction t3;