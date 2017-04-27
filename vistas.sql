
go
use mastodonx
go 



create  view full_usuario 
as
select *, usuario.nombre + '  ' + usuario.apellido _usuario  from usuario 
		inner join rol on rol.id_rol = usuario.fk_id_rol
		

go


create view full_cliente
as
select distinct _empresa + ' ' +  _sede nombre, id_cliente from cliente


go


create view full_activo 
as
select * from activo 
inner join tipo_activo on tipo_activo.id_tipo_activo = activo.fk_id_tipo_activo
inner join modelo on modelo.id_modelo = activo.fk_id_modelo
inner join marca on marca.id_marca = modelo.fk_id_marca
inner join contacto on contacto.id_contacto = activo.fk_id_contacto
inner join area on area.id_area = contacto.fk_id_area
inner join cliente  on cliente.id_cliente = area.fk_id_cliente

go


create view lastTicket 
as
select top(1) N_Ticket from ticket order by N_Ticket desc


go


create  view full_ticket
as
select 
	ticket.id_ticket id_full_ticket,
	ticket.id_ticket,  
	ticket.N_ticket,

	cliente.id_cliente cliente,
	cliente._empresa + ' ' + cliente._sede cliente_nombre,

	tecnico.apellido + ' ' + tecnico.nombre tecnico_nombre,
	tecnico.id_usuario tecnico,
	
	contacto._contacto, ---usuario final = contacto
	servicio._servicio + ' de ' +  _tipo_activo titulo,
	creador.apellido + ' ' + creador.nombre creador,
	documentacion.fecha,
	documentacion.hora,
	ticket.estado,
	servicio._servicio,
	servicio.id_servicio servicio ,
	tipo
from ticket
inner join servicio on servicio.id_servicio = ticket.fk_id_servicio
inner join usuario tecnico on tecnico.id_usuario = ticket.fk_id_tecnico 
inner join usuario creador on creador.id_usuario = ticket.fk_id_creador
inner join documentacion on documentacion.fk_id_ticket = ticket.id_ticket
inner join activo on activo.id_activo =  ticket.fk_id_activo
inner join contacto on contacto.id_contacto = activo.fk_id_contacto
inner join area on area.id_area = contacto.fk_id_area
inner join cliente on cliente.id_cliente = area.fk_id_cliente
inner join tipo_activo on tipo_activo.id_tipo_activo = activo.fk_id_tipo_activo
-- ii tipo

--select * from full_ticket where fecha <= '2017-01-31' and fecha >= '2017-01-25'
 --select * from  full_ticket where  fecha between  '31/01/2017' and '31/01/2017' and 1= 1

 go


 create view full_out_ticket 
as
select  id_ticket,
		N_Ticket,
        estado,
        fecha,
        hora,
        servicio._servicio servicio,
        contacto._contacto usuario_final,
		cliente._empresa + ' ' + cliente._sede cliente, 
		area.nombre area,
		direccion,
		telefono,
		contacto.correo,
		_tipo_activo activo,
		serial,
		marca._marca marca,
		modelo._modelo modelo,
		inventario,
		seguridad ,
	tipo

from ticket
inner join servicio on servicio.id_servicio = ticket.fk_id_servicio
inner join documentacion on documentacion.fk_id_ticket = ticket.id_ticket
inner join activo on activo.id_activo =  ticket.fk_id_activo
inner join contacto on contacto.id_contacto = activo.fk_id_contacto
inner join area on area.id_area = activo.fk_id_contacto
inner join cliente on cliente.id_cliente = area.fk_id_cliente
inner join tipo_activo on tipo_activo.id_tipo_activo = activo.fk_id_tipo_activo
inner join modelo on modelo.id_modelo = activo.fk_id_modelo
inner join marca on marca.id_marca = modelo.fk_id_marca

go 


create view f_ticket 
as
select * from ticket
inner join documentacion on documentacion.fk_id_ticket = ticket.id_ticket
where estado = 'F' and tipo = 'II'

-----for fix



go

alter view tecnicos
as
select 
	usuario.apellido + ' ' + usuario.nombre nombre,
	usuario.id_usuario
from usuario where rol like '%tec%'






go



 go 

 alter view full_pregunta
 as
 select * from respuesta 
	inner join pregunta on pregunta.id_pregunta =respuesta.fk_id_pregunta

go


alter view full_images 
as 
select ticket.id_ticket,imagen.data_image, documentacion.id_documentacion from ticket
inner join documentacion on documentacion.fk_id_ticket = ticket.id_ticket
inner join imagen on imagen.fk_id_documentacion = documentacion.id_documentacion


go 




go



go
--select * from ticket

/*select * from ticket
select count(*) from ticket

select * from ticket order by id_ticket offset 0 rows fetch next 10 Rows Only

select count(id_ticket)  from ticket
select * from ticket  where 1=1 order  by id_ticket offset 0 rows fetch next 10 Rows Only*/



