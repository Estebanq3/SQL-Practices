use inventario 
go
create table tienda1
(n_envio int,
cod_prod varchar(4),
nombre varchar(100),
Cantidad int)
go

create table tienda2
(n_envio int,
cod_prod varchar(4),
nombre varchar(100),
Cantidad int)
go

create table tienda3
(n_envio int,
cod_prod varchar(4),
nombre varchar(100),
Cantidad int)
go

select * from tienda1 
select * from tienda2 
select * from tienda3 
go


create view tiendas
as
select n_envio, cod_prod, nombre, cantidad, 'tienda1' as destino from tienda1  
union all
select n_envio, cod_prod, nombre, cantidad, 'tienda2' as destino from tienda2  
union all
select n_envio, cod_prod, nombre, cantidad, 'tienda3' as destino from tienda3 
go

 select * from tiendas 
 go

create trigger TR_Destinos
on tiendas instead of insert
as
set nocount on
insert into tienda1 
select n_envio, cod_prod, nombre, cantidad from inserted where destino='tienda1'
insert into tienda2 
select n_envio, cod_prod, nombre, cantidad from inserted where destino='tienda2'
insert into tienda3 
select n_envio, cod_prod, nombre, cantidad from inserted where destino='tienda3' 
go

insert into tiendas values(1, '1001', 'MOUSE OPTICO', 500, 'tienda1')
GO


select * from tienda1
select * from tienda2
select * from tienda3 
go

insert into tiendas values(2, '1002', 'Monitor LED 17 pulgaas', 35, 'tienda3')
insert into tiendas values(2, '1003', 'CABLE HDMI', 50, 'tienda3')
insert into tiendas values(2, '1004', 'AIRE COMPRIMIDO', 45, 'tienda3')
insert into tiendas values(2, '1005', 'PASTA TERMICA', 23, 'tienda3')
go

insert into tiendas values(3, '1006', 'TECLADO P/TABLET', 100, 'tienda1')
insert into tiendas values(4, '1007', 'FUNDA TECLADO', 230, 'tienda2')
insert into tiendas values(5, '1008', 'MEMORIA MICRO SD 16GB', 700, 'tienda3')
go

select * from tiendas 