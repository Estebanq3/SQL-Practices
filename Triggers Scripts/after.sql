create database inventario;
GO
use inventario;
GO
create table productos
(
id_Cod int identity primary key,
cod_prod varchar(4) not null,
nombre varchar(50)not null,
existencia int not null,
)
GO

Create table historial
(fecha date,
descripcion varchar(100), 
usuario varchar(20))
GO

create table ventas
(cod_prod varchar(4),
precio money,
cantidad int
)
GO

insert into productos values('A001','MEMORIA USB 32GB',175);
insert into productos values('A002','DISCO DURO 2TB',15);
insert into productos values('A003','AIRE COMPRIMIDO',250);
insert into productos values('A004','ESPUMA LIMPIADORA',300);
insert into productos values('A005','FUNDA MONITOR',500);
insert into productos values('A006','FUNDA TECLADO',700);
insert into productos values('A007','SILLA ERGONÓMICA',11);
insert into productos values('A008','ALFOMBRILLA PARA SILLA',25);
insert into productos values('A009','LÁMPARA ESCRITORIO',7);
insert into productos values('A010','MONITOR LED 18 PULGADAS',45);
insert into productos values('A011','LIBRERO',20);
go

select * from historial
select * from productos 
go

alter trigger TR_ProductoInsertado
on productos for insert
as
set nocount on
declare @cod_prod varchar(4)
select @cod_prod = cod_prod from inserted 
insert into historial values(getdate(), @cod_prod, 'registro insertado', system_user)
go


create trigger TR_ProductoEliminado
on productos for delete
as
set nocount on
declare @cod_prod varchar(4)
select @cod_prod = cod_prod from deleted  
insert into historial values(getdate(), @cod_prod, 'registro eliminado', system_user)
go

select * from historial 
select * from productos 
go

delete from productos  where cod_prod = 'A003'
GO

create trigger TR_ProductoActualizado
on productos for update	
as
set nocount on
declare @cod_prod varchar(4)
select @cod_prod = cod_prod from inserted   
insert into historial values(getdate(), @cod_prod, 'registro actualizado', system_user)
go


select * from historial
select * from productos 
go

update productos set existencia =180 where cod_prod = 'A001'
go

select * from ventas
select * from productos 
go



create trigger TR_Ventas
on ventas for insert
AS
update productos set productos.existencia = productos.existencia - inserted.cantidad 
from inserted inner join productos 
on productos.cod_prod = inserted.cod_prod
go
  
insert into ventas values('A001', 30, 2) 

-- aquí voy
go

sp_helptrigger ventas