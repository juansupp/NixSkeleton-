use mastodonx
--Servicio (Alistamiento * movimiento)
	insert into servicio values ('Alistamiento')  --1
----Rol
	insert into rol values ('Admin') --1
	insert into rol values ('Creator') --2
	insert into rol values ('Tech') --3
----Usuario	
	insert into usuario values('Gonz�lez Rivera','Juan Sebasti�n','3197053513','juang@suppliesdc.com','123',1)
	insert into usuario values('Prueba','Juan Creador','3157053513','juangc@suppliesdc.com','123',2)
	insert into usuario values('Prueba','Juan Tecnico','3127053513','juangt@suppliesdc.com','123',3)
----Cliente
	insert into cliente values ('Supplies','SAS',null,null)  --1
	insert into cliente values ('Blindex','Bogot�','Av 45 #54- 22','2210882') --2
----Area
	insert into area values ('Bogot�',1) --1 FK = 1
	insert into area values ('Bogot�',2) --2 FK = 2
----Contacto NIX ROBOT 
	insert into contacto values ('nix robot','nixrobot@suppliesdec.com',1) --1
--Encuesta 
----Pregunta
	insert into pregunta values('�El servicio se atendi� dentro de los tiempos establecidos?',1)
	insert into pregunta values('�Qu� tan buena fue la atenci�n prestada?',1)
	insert into pregunta values('�Se resolvi� satisfactoriamente el servicio?',1)
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

		