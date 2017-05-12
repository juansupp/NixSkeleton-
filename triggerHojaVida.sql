--- TRIGGERS PARA HOJA DE VIDA DE ACTIVO 

use mastodonx

go 
/*
create table hoja_vida (
		id_hoja_vida int primary key identity,
		_key varchar(20),
		tipo char(2),
		texto varchar(max) default null,
		fecha date default getdate(),
		hora time(0) default convert(time(0),getdate()),
		fk_id_activo int foreign key references activo (id_activo)
	)
	/*
		TIPOS DE HISTORIAL 

		0. Al registrar por primera vez el activo 
		1. Al cambiar la placa de seguridad = PS                                   -- update or insert activo
		2. Al cambiar la placa de inventario = PI									--update or insert activo 
		3. Al hacer una modificaciones en las especificaciones del activo  = ME     --update or insert caracteristica_activo
		4. Al realizar un ticket  = NT                                              --insert ticket
		5. Al realizar una entrega = NE												--update sub entrega (fk)
		6. Al realizar un retiro = NR												--insert retiro
		7. Al modificar el licencia (en el alistamiento) = NS						--insert licencia (por cada una)
		8. Al realizar un asignamiento de contacto = AC								--

	*/*/



create trigger trgLicencia on licencia
after insert 
as
begin
	

	declare  
		@id_activo int, 
		@id_licencia int, 
		@software varchar(200)

	select
		@id_activo = se.fk_id_activo,
		@id_licencia = i.id_licencia,
		@software = s._software
	  from inserted i
		inner join software s on s.id_software = i.fk_id_software
		inner join sub_entrega se on se.id_sub_entrega = i.fk_id_sub_entrega 
		


	insert into hoja_vida 
			(_key,tipo,texto,fk_id_activo) 
	values 
		(@id_licencia,'NE','Se ha agregado el software  '+ @software ,@id_activo)
end

go

create trigger trgEntrega on sub_entrega
after update 
as
begin
	 
	 --ENTREGA
	if update (fk_id_entrega)
	begin
		
		declare 
			@id_activo int , 
			@id_entrega int, 
			@n_entrega varchar(15) 

		select 
			@id_activo = i.fk_id_activo,
			@id_entrega = e.id_entrega,
			@n_entrega = e.n_entrega  
		from inserted i 
			inner join entrega e on e.id_entrega = i.fk_id_entrega

		insert into hoja_vida 
			(_key,tipo,texto,fk_id_activo) 
		values 
			(@id_entrega,'NE','Se ha ligado la entrega nº ' + @n_entrega,@id_activo)
	end

	--RETIRO 

	if update (fk_id_retiro)
	begin
		
		declare 
			@id_activo2 int , 
			@id_retiro int, 
			@n_entrega2 varchar(15) 

		select 
			@id_activo2 = i.fk_id_activo,
			@id_retiro = r.id_retiro,
			@n_entrega = r.n_retiro
		from inserted i 
			inner join retiro r on r.id_retiro = i.fk_id_entrega

		insert into hoja_vida 
			(_key,tipo,texto,fk_id_activo) 
		values 
			(@id_retiro,'NE','se ha realizado una entrega ' + @n_entrega2   ,@id_activo2)
	end
	
end

go

create trigger trgTicket on ticket 
after update
as
begin
	if update (fk_id_activo)
	begin 
		declare @id_ticket int, @id_activo int, @n_ticket int
		select 
			@id_ticket = inserted.id_ticket,  
			@id_activo = inserted.fk_id_activo ,
			@n_ticket = inserted.n_ticket
		from inserted

		insert into hoja_vida 
			(_key,tipo,texto,fk_id_activo) 
			values 
			(@id_ticket,'NT','Se ha creado el ticket nº  ' + @n_ticket   ,@id_activo)
	end
end

go

create trigger trgCarActivo  on caracteristica_activo
after update, insert 
as
begin 

	declare 
		@id_activo int,  --
		@valor varchar(100), 
		@caracteristica varchar(100),
		@id_caracteristica_activo int --

	select 
		@id_caracteristica_activo =  i.id_caracteristica_activo,
		@id_activo = i.fk_id_activo,
		@caracteristica = c._caracteristica,
		@valor = cv._valor
	from inserted i 
	inner join caracteristica_valor cv on cv.id_caracteristica_valor = i.fk_id_caracteristica_valor
	inner join caracteristica c on c.id_caracteristica = cv.fk_id_caracteristica
		
	insert into hoja_vida 
		(_key,tipo,texto,fk_id_activo) 
	values 
		(@id_caracteristica_activo,'ME','Se han modificado la/el '+ @caracteristica + ' a ' + @valor ,@id_activo)
		

	--ME
end
	
go

--Cade vez que se modifica el activo
create trigger trgActivo ON  activo
AFTER UPDATE, INSERT
AS  
begin
	SET NOCOUNT ON;

	
	--Si se modificó la placa de seguridad
	IF UPDATE (seguridad)
	begin 
		--variables para guardar la seguridad modificada y el activo
		declare @seguridad varchar(20), @id_activo int  
		--se guardan las variables
		select 
			@seguridad = inserted.seguridad,
			@id_activo = inserted.id_activo  
		from inserted
		--se agrega a la hoja de vida 
		insert into hoja_vida 
			(_key,tipo,texto,fk_id_activo) 
			values 
			(@seguridad,'PS','Se ha modificado la placa de seguridad',@id_activo)
	end	


	-- si se modificó la placa de inventario

	IF UPDATE (inventario)
	begin 
		--variables para guardar la invnetario modificada y el activo
		declare @inventario varchar(20), @id_activo2 int  
		--se guardan las variables
		select 
			@inventario = inserted.inventario,
			@id_activo2 = inserted.id_activo  
		from inserted
		--se agrega a la hoja de vida 
		insert into hoja_vida 
			(_key,tipo,texto,fk_id_activo) 
			values 
			(@inventario,'PI','Se ha modificado la placa de inventario',@id_activo2)
	end	

	 
end