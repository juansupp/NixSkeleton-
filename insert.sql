use mastodonx
--Servicio (Alistamiento * movimiento)
	insert into servicio values ('Alistamiento')  --1
----Origen
	insert into origen values (1,'Telefonico')
	insert into origen values (2,'Correo')
	insert into origen values (3,'Solicitud interna')
----Rol
	insert into rol values (1,'Admin') --1
	insert into rol values (2,'Creator') --2
	insert into rol values (3,'Tech') --3
----Usuario	
	insert into usuario values('González Rivera','Juan Sebastián','3197053513','juang@suppliesdc.com','123',1)
	insert into usuario values('Prueba','Juan Creador','3157053513','juangc@suppliesdc.com','123',2)
	insert into usuario values('Prueba','Juan Tecnico','3127053513','juangt@suppliesdc.com','123',3)
----Cliente
	insert into cliente values ('Supplies','SAS',null,null)  --1
	insert into cliente values ('Blindex','Bogotá','Av 45 #54- 22','2210882') --2
----Area
	insert into area values ('Bogotá',1) --1 FK = 1
	insert into area values ('Bogotá',2) --2 FK = 2
----Contacto NIX ROBOT 
	insert into contacto values ('nix robot','nixrobot@suppliesdec.com',1) --1
--Encuesta 
----Pregunta
	insert into pregunta values('¿El servicio se atendió dentro de los tiempos establecidos?',1)
	insert into pregunta values('¿Qué tan buena fue la atención prestada?',1)
	insert into pregunta values('¿Se resolvió satisfactoriamente el servicio?',1)
------Respuesta 1
		insert into respuesta values ('Si',1)
		insert into respuesta values ('No',1)
------Respusta 2
		insert into respuesta values ('Mala',2)
		insert into respuesta values ('Buena',2)
		insert into respuesta values ('Excelente',2)
------Respuesta 3
		insert into respuesta values ('Si',3)
		insert into respuesta values ('No',3)

		
		