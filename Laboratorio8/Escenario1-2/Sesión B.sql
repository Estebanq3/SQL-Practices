use [B91750]

---Ejercicio #5
set implicit_transactions off; 
 
begin transaction t2; 
PRINT @@TRANCOUNT 
Select * from sys.sysprocesses 
where open_tran = 1; 
Update Lleva                 
set Nota = Nota*(0.8)                
where Nota is not null;

---Ejercicio #7
rollback transaction t2;

---Ejercicio #11
set implicit_transactions off; 
 
begin transaction t4; 
Update Lleva                 
set Nota = Nota*(0.8)                
where Nota is not null;

--Ejercicio #13
Select * from sys.sysprocesses 
where open_tran = 1 
 
commit transaction t4;

