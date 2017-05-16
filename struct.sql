
create database mastodonx
go
use mastodonx
--LOGIN
	go
	create table rol (
		id_rol  int primary key ,
		_rol varchar(50)
	) 
	go
	create table usuario (
		id_usuario int primary key identity(1,1),
		apellido varchar(100),
		nombre varchar(100),
		telefono varchar(20),
		correo varchar(100),
		pass varchar(100),
		fk_id_rol int foreign key references rol (id_rol) 
	)
--CLIENTE
	go
	create table cliente (
		id_cliente int primary key identity (1,1),
		_empresa varchar(300),
		_sede varchar(300),
		direccion varchar(100),
		telefono varchar(20)
	)
	go
	create table area (
		id_area int primary key identity(1,1),
		_area varchar(100),
		fk_id_cliente int foreign key references cliente (id_cliente)

	)
	go
	create table contacto (
		id_contacto int primary key identity,
		_contacto varchar(150),
		correo varchar(100),
		fk_id_area int foreign key references area (id_area)
	) 
--ACTIVO 
	go
	create table tipo_activo (
		id_tipo_activo int primary key identity,
		_tipo_activo varchar(200),
		descripcion varchar(max)
	)

	go
	create table caracteristica (
		id_caracteristica int primary key identity,
		_caracteristica varchar(100),
		fk_id_tipo_activo int foreign key references tipo_activo, 
	)
	go

	create table caracteristica_valor (
		id_caracteristica_valor int primary key identity,
		_valor varchar(100),
		fk_id_caracteristica int foreign key references caracteristica (id_caracteristica)
	)
	go
	create table marca(
		id_marca int primary key identity,
		_marca varchar(100)
	)
	go 
	create table modelo(
		id_modelo int primary key identity,
		_modelo varchar(100),
		fk_id_marca int foreign key references marca (id_marca)  
	)
	go 
	create table activo(
		id_activo int primary key identity(1,1),
		serial varchar(50),
		inventario varchar(20),
		seguridad varchar(20),
		ciclo tinyint, 
		fk_id_tipo_activo int foreign key references tipo_activo (id_tipo_activo) ,
		fk_id_modelo int foreign key references modelo (id_modelo),
		fk_id_contacto int foreign key references contacto (id_contacto)
	)
	go
	create table caracteristica_activo (
		id_caracteristica_activo int primary key identity,
		fk_id_caracteristica_valor int foreign key references caracteristica_valor(id_caracteristica_valor),
		fk_id_activo int foreign key references activo (id_activo)
	)
--TICKET 
	go
	create table servicio (
		id_servicio int primary key identity,
		_servicio varchar(100)
	)
	go
	create table origen(
		id_origen int primary key,
		_origen varchar(50)
	)
	go
	--alter table ticket drop column origen
	create table ticket (
		id_ticket int primary key identity(1,1),
		N_Ticket int , 
		estado char(1),
		cierre char(1),  -- x by default  defecto
		fk_id_tecnico int foreign key references usuario (id_usuario),
		fk_id_creador int foreign key references usuario (id_usuario),
		fk_id_activo int foreign key references activo (id_activo),
		fk_id_servicio int foreign key references servicio (id_servicio),
		fk_id_origen int foreign key references origen (id_origen)
	)
	go 
	create table documentacion (
		id_documentacion int primary key identity(1,1),
		fecha date,
		hora time(0),
		texto varchar(max),
		tipo char(2),
		persona varchar(200),
		fk_id_ticket int foreign key references ticket (id_ticket)
	)  
	go
	create table alerta (
		id_alerta int primary key  identity,
		fecha date,
		fk_id_ticket int foreign key references ticket (id_ticket)
	) 
	go
	--alter table imagen drop column url_image
	create table imagen (
		id_imagen int primary key identity(1,1),
		data_image varchar(max),
		fk_id_documentacion int foreign key references documentacion (id_documentacion)
	) 
--ENCUESTA
	go
	create table pregunta (
		id_pregunta int primary key identity(1,1),
		pregunta varchar(300),
		estado bit default 1
	)
	go

	create table respuesta (
		id_respuesta int primary key identity,
		respuesta varchar(200),
		fk_id_pregunta int foreign key references pregunta (id_pregunta)
	)

	go

	create table encuesta (
		id_encuesta int primary key identity,
		fk_id_respuesta int foreign key references respuesta (id_respuesta),
		fk_id_ticket int foreign key references ticket (id_ticket)
	)
--
	go
	/*create table _version (
		id_version int primary key identity,
		desde date default getdate(),
		hasta  date default null,
		descripcion varchar(max),
		fk_id_activo int foreign key references activo(id_activo)
	)
	go
	create table sub_version(
		id_sub_version int primary key identity,
		_key varchar(100),
		_value varchar(100),
		fk_id_version int foreign key references _version (id_version)
	)*/
--MOVIMIENTOS DE INVENTARIO (ROOT)
	go
	create table software(
		id_software int primary key identity,
		_software varchar(200),
		descripcion varchar(max)
	)
	go
	create table entrega  (
		id_entrega int primary key identity,
		n_entrega varchar(15) default null,  -- var
		fecha date default getdate(),	
	)
	go
	create table retiro (
		id_retiro int primary key identity,
		n_retiro varchar(15) default null,
		fecha date default getdate()
	)
	go
	--alter table sub_entrega add  estado bit
	--alter table sub_entrega add observacion varchar(max)
	create table sub_entrega (
		id_sub_entrega  int primary key identity,
		estado bit default 0, -- 0 = sub entrega recien creada(casa) 1 = sube entrega entregada(inferno) 
		text_entrega varchar(max) default null,
		text_retiro varchar(max) default null,
		fk_id_activo int foreign key references activo (id_activo),
		fk_id_entrega int foreign key references entrega (id_entrega),
		fk_id_retiro int foreign key references retiro(id_retiro)
	)
	go
	--Conexion sub-entrega - software IMPORTANTE
	create table licencia (
		id_licencia int primary key identity,
		fk_id_software int foreign key references software (id_software),
		fk_id_sub_entrega int foreign key references sub_entrega (id_sub_entrega) on delete cascade 
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

