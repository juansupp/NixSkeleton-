use mastodonx
go 
--MODULO MOVIMIENTOS

create table software(
	id_software int primary key identity,
	_software varchar(200),
	descripcion varchar(max)
)

go

create table entrega  (
	id_entrega int primary key identity,
	n_entrega int default null, 
	fecha date default getdate(),	
)

go

create table sub_orden(
	id_sub_orden  int primary key identity,
	fk_id_software int foreign key references software (id_software),
	fk_id_activo int foreign key references activo (id_activo)
)

go 

/*
	TIPOS DE HISTORIAL 

	1. Al cambiar la placa de seguridad = PS
	2. Al cambiar la placa de inventario = PI
	3. Al hacer una modificaciones en las especificaciones del activo  = ME
	4. Al realizar un ticket  = NT
	5. Al realizar una entrega = NE
	6. Al realizar un retiro = NR
	7. Al modificar el software (en el alistamiento) = NS
	8. Al realizar un asignamiento de contacto = AC

*/
create table hoja_vida (
	id_hoja_vida int primary key identity,
	_key varchar(20),
	tipo char(2),
	texto varchar(max) default null,
	fecha date default getdate(),
	hora time(0) default convert(time(0),getdate()),
	fk_id_activo int foreign key references activo (id_activo)
)

go

--select  convert(time(0),getdate())

/*TABLA SEMI TEMPORAL PARA ADJUNTAR LOS ACTUVIS QUE SE ESTAN ALISTANDO PARA PODER LLEVARLOS A LA ENTREGA */

create table alistamiento(
	_activo int 
)