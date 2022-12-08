--Script para crear la base de datos Club Nautico 
--Con las tablas Patron, Emails_Patron, Telefonos_Patron, Socio, Emails_Socio, Telefonos_Socio, Salida, Barco
--Materia FBD 
--Fecha de creacion 29/10/19
--Autor: Jos� Misael Adame Sandoval 18131209
--Fecha de ultima actualizacion 25/11/19
--Lugar: Torreon Coahuila 

--Crear la Base de Datos 
create database Club_Nautico 
Go
--Poner en uso Base de Datos 
use Club_Nautico
Go

--Crear la tabla Patron
create table Patron
(
Numero_Licencia varchar(10),
Nombres varchar(40),
Apellido_Paterno varchar(20),
Apellido_Materno varchar(20),
Sexo char,
CURP varchar(18),
Estado_Civil varchar(15),
Calle varchar(30),
Colonia varchar(30),
Ciudad varchar(30),
Estado varchar(15),
Fecha_Nacimiento date,
NSS varchar(11),
primary key(Numero_Licencia)
)
Go
--Crear tabla Emails_Patron
create table Emails_Patron 
(
Numero_Licencia varchar(10),
Email varchar(45),
primary key(Email)
)
Go
--Crear tabla Telefonos_Patron
create table Telefonos_Patron
(
Numero_Licencia varchar(10),
Telefono varchar(10),
primary key(Telefono)
)
Go
--Crear tabla Socio
create table Socio
(
ID_Socio varchar(10),
Nombres varchar(40),
Apellido_Paterno varchar(20),
Apellido_Materno varchar(20),
Sexo char,
CURP varchar(18),
Estado_Civil varchar(15),
Calle varchar(30),
Colonia varchar(30),
Ciudad varchar(30),
Estado varchar(15),
Fecha_Nacimiento date,
Pago_Anual money,
primary key(ID_Socio)
)
Go
--Crear tabla Emails_Socio
create table Emails_Socio 
(
ID_Socio varchar(10),
Email varchar(45),
primary key(Email)
)
Go
--Crear tabla Telefonos_Socio
create table Telefonos_Socio
(
ID_Socio varchar(10),
Telefono varchar(10),
primary key(Telefono)
)
Go
--Crear tabla Salida
create table Salida
(
Numero_Licencia varchar(10),
Numero_Matricula varchar(10),
Destino varchar(20),
Fecha_Hora datetime,
primary key(Numero_Licencia, Numero_Matricula)
)
Go
--Crear tabla Barco
create table Barco
(
Numero_Matricula varchar(10),
Nombre varchar(15),
Numero_Amarre varchar(4),
Cuota money,
ID_Socio varchar(10),
Numero_Licencia varchar(10),
primary key(Numero_Matricula, Numero_Licencia)
)
Go

--Crear constraint para referenciar el ID_Socio de la tabla Socio en la tabla Emails_Socio
Alter table Emails_Socio
add constraint chck_id_socio_emails_soc
foreign key(ID_Socio)
references Socio(ID_Socio)
Go
--Crear constraint para referenciar el ID_Socio de la tabla Socio en la tabla Telefonos_Socio
Alter table Telefonos_Socio
add constraint chck_id_socio_tels_soc
foreign key(ID_Socio)
references Socio(ID_Socio)
Go
--Crear constraint para referenciar el Numero_Licencia de la tabla Patron en la tabla Emails_Patron
Alter table Emails_Patron
add constraint chck_num_licencia_emails_pat
foreign key(Numero_Licencia)
references Patron(Numero_Licencia)
Go
--Crear constraint para referenciar el Numero_Licencia de la tabla Patron en la tabla Telefonos_Patron
Alter table Telefonos_Patron
add constraint chck_num_licencia_tels_pat
foreign key(Numero_Licencia)
references Patron(Numero_Licencia)
Go
--Crear constraint para referenciar el ID_socio de la tabla Socio en la tabla Barco
Alter table Barco
add constraint chck_id_socio_barco 
foreign key (ID_Socio)
references Socio (ID_Socio)
Go
--Crear constraint para referenciar el Numero_Licencia de la tabla Patron en la tabla Barco
Alter table Barco 
add constraint chck_num_licencia_barco
foreign key (Numero_Licencia) 
references Patron (Numero_Licencia)
Go
--Crear constraints para validar el Sexo en las tablas Patron y Socio
Alter table Patron
add constraint chck_sexo_patron
check (Sexo in ('F', 'M')) 
Go
Alter table Socio
add constraint chck_sexo_socio
check (Sexo in ('F', 'M'))
Go
--Crear constraints para validar el Estado_Civil en las tablas Patron y Socio
Alter table Patron
add constraint chck_edo_civil_patron
check (Estado_Civil in('Soltero', 'Casado', 'Viudo', 'Divorciado'))
Go
Alter table Socio
add constraint chck_edo_civil_socio
check (Estado_Civil in('Soltero', 'Casado', 'Viudo', 'Divorciado'))
Go
--Crear constraint para referenciar el Numero_Matricula de la tabla Barco en la tabla Salida
Alter table Salida
add constraint chck_num_matricula_salida
foreign key(Numero_Matricula, Numero_Licencia)
references Barco(Numero_Matricula, Numero_Licencia)
Go
--Crear constraint para referenciar el Numero_Licencia de la tabla Patron en la tabla Salida
Alter table Salida
add constraint chck_num_licencia_salida
foreign key(Numero_Licencia)
references Patron(Numero_Licencia)
Go

--Insertar informacion en la tabla Patron
Insert into Patron
values ('1813120900','Jose Misael','Adame','Sandoval', 'M', 'AASM000203HDGDNSA0', 'Soltero', 'Av. Constitucion', 
		'Saucedo Dominguez', 'Gomez Palacio', 'Durango', '2000-02-03', '53160090766')
		Go
Insert into Patron
values ('1813124987','Jes�s Daniel','L�pez','Hern�ndez', 'M', 'LLJD000204HDGDNSA0', 'Soltero', 'Av. Gokú', 
		'Col. Prados', 'Lerdo', 'Durango', '1999-10-21', '53161240763')
		Go
Insert into Patron
values ('2124567890','Esperanza','Moreno','Pacheco', 'F', 'MMPE102405VDCDNLA4', 'Soltero', 'Calle 32', 
		'Col. Prados', 'Victoria de Durango', 'Durango', '1997-05-01', '94584445961')
		Go
Insert into Patron
values ('3456314567','Julio','Furch','Santana', 'M', 'FFSJ301403CODZNSN9', 'Casado', 'Av. Arboledas', 
		'Fracc. Campestre', 'Torreon', 'Coahuila', '1989-09-12', '12345060789')
		Go
Insert into Patron
values ('3456723341','Carlos','Netanyahu','Silva', 'M', 'NNSM400674SDCHNSP3', 'Viudo', 'Solidaridad', 
		'Fracc. Jardines del Sur', 'Saltillo', 'Coahuila', '1967-01-28', '50160090766')
		Go
Insert into Patron
values ('1234512456','Mariana','Trujillo','Suarez', 'F', 'TSMA123456TTAMANS0', 'Casado', 'Calle Manzana', 
		'Fracc. Villas El Roble', 'Tampico', 'Tamaulipas', '1989-08-25', '02453567811')
		Go
Insert into Patron
values ('4567134001','Josefina Andrea','Vazquez','Mota', 'F', 'VVMJ164513TOEDOME4', 'Divorciado', 'Hernandez Solis', 
		'Col. El Refugio', 'Toluca', 'Edo de Mexico', '1972-11-16', '58411121347')
		Go
Insert into Patron
values ('1200938479','Jose Brayan','Luna','Gonzalez', 'M', 'LGJB199456VTABCOP5', 'Soltero', 'Av. Hidalgo', 
		'Col. Centro', 'Villahermosa', 'Tabasco', '1994-10-14', '90012456789')
		Go
Insert into Patron
values ('7100012004','Christian','Guardado','Morales', 'M', 'GGNC444301FZZPONE7', 'Casado', 'Calle Isidoro', 
		'Col. Armando Castillo', 'Fresnillo', 'Zacatecas', '1956-08-13', '12345678901')
		Go
Insert into Patron
values ('9912415871','Angel Eduardo','Casta�eda','Ramirez', 'M', 'CARA665307XAVENSR6', 'Divorciado', 'Blvd. Revolucion', 
		'Fracc. Filadelfia', 'Xalapa', 'Veracruz', '1975-08-11', '98650020121')
		Go

--Insertar informacion en la tabla Emails_Patron
Insert into Emails_Patron
values ('1813120900', 'misael_adame@protonmail.com')
Go

Insert into Emails_Patron
values ('1813120900', 'jmas_veneno@hotmail.com')
Go

Insert into Emails_Patron
values ('1200938479', 'JBMB@yahoo.com.mx')
Go

Insert into Emails_Patron
values ('1234512456', 'mtrujillo23@outlook.com')
Go

Insert into Emails_Patron
values ('1234512456', 'mariana_trujillo@outlook.com')
Go

Insert into Emails_Patron
values ('1813124987', 'jdaniel@hotmail.com')
Go

Insert into Emails_Patron
values ('1813124987', 'goku_21@hotmail.com')
Go

Insert into Emails_Patron
values ('2124567890', 'kailen_moreno@protonmail.com')
Go

Insert into Emails_Patron
values ('3456314567', 'julio_furch_9@clubsantos.com.mx')
Go

Insert into Emails_Patron
values ('3456314567', 'julito_f_santana@hotmail.com')
Go

Insert into Emails_Patron
values ('3456723341', 'carlitos_netanyahu@outlook.com')
Go

Insert into Emails_Patron
values ('4567134001', 'vazquezmotaja@outlook.com')
Go

Insert into Emails_Patron
values ('4567134001', 'gatito19@gmail.com')
Go

Insert into Emails_Patron
values ('7100012004', 'cgmtec@gmail.com')
Go

Insert into Emails_Patron
values ('9912415871', 'angeleduardo_cast_ramirez@yahoo.com.mx')
Go

--Insertar informacion en la tabla Telefonos_Patron
Insert into Telefonos_Patron
values ('1200938479', '8711111111')
Go

Insert into Telefonos_Patron
values ('1200938479', '8712222222')
Go

Insert into Telefonos_Patron
values ('1234512456', '6741111111')
Go

Insert into Telefonos_Patron
values ('1234512456', '6741111111')
Go

Insert into Telefonos_Patron
values ('1813120900', '8713333333')
Go

Insert into Telefonos_Patron
values ('1813124987', '7391111111')
Go

Insert into Telefonos_Patron
values ('1813124987', '7481111111')
Go

Insert into Telefonos_Patron
values ('2124567890', '6185555555')
Go

Insert into Telefonos_Patron
values ('2124567890', '6186666666')
Go

Insert into Telefonos_Patron
values ('3456314567', '2128888888')
Go

Insert into Telefonos_Patron
values ('3456723341', '4359999999')
Go

Insert into Telefonos_Patron
values ('4567134001', '8232345678')
Go

Insert into Telefonos_Patron
values ('4567134001', '2314556786')
Go

Insert into Telefonos_Patron
values ('4567134001', '2314333211')
Go

Insert into Telefonos_Patron
values ('7100012004', '8719999999')
Go

Insert into Telefonos_Patron
values ('9912415871', '2996969696')
Go

--Insertar informacion en la tabla Socio
Insert into Socio
values ('1234567891','Mauro','Casta�eda','Sotelo', 'M', 'SCAM123454XAVENPV6', 'Soltero', 'De las Americas', 
		'Fracc. Del Mar', 'Mazatlan', 'Sinaloa', '1979-04-12', 305000)
		Go

Insert into Socio
values ('4523568234','Elizabeth','Gonzalez','Loera', 'F', 'GLEE568312GHFCLPV9', 'Soltero', 'Dominguez', 
		'Fracc. Amanecer', 'Puerto Vallarta', 'Jalisco', '1988-07-09', 200000)
		Go

Insert into Socio
values ('5984543984','Jose Ismael','Lira','McCarthy', 'M', 'RFSX678912GHFCLAS0', 'Casado', 'Av. Morelos', 
		'Col. Centro', 'Acapulco', 'Guerrero', '1983-09-11', 130000)
		Go

Insert into Socio
values ('8934753539','Valentin','Jaramillo','Mendoza', 'M', 'CDFA763459PRFNCBH0', 'Divorciado', 'Pavorreal', 
		'Fracc. Campestre', 'Acapulco', 'Guerrero', '1981-04-30', 434555)
		Go

Insert into Socio
values ('4750934759','Hernan Brian','Lozano','Hernandez', 'M', 'PORH896532CVBNSKJ2', 'Viudo', 'Nezahualcoyotl', 
		'Fracc. Campestre', 'Puerto Pe�asco', 'Sonora', '1954-07-21', 9500000)
		Go

Insert into Socio
values ('9849347593','Johanna','Bell','Tiburcio', 'F', 'CXLD896543PPSONKX0', 'Soltero', 'Paseo de la Reforma', 
		'Col. Anzures', 'Benito Juarez', 'CDMX', '1998-03-27', 100000)
		Go

Insert into Socio
values ('8752659262','Georgina','Vela','Cortes', 'F', 'PORE754321LMNSNCX4', 'Casado', 'Av. Ciruelos', 
		'Col. Santiba�ez', 'Mazatlan', 'Sinaloa', '1978-06-22', 350000)
		Go

Insert into Socio
values ('1285308455','Ernesto Gustavo','Diaz','Ordaz', 'M', 'DOEG744321LMNSNIB1', 'Casado', 'Calle Comonfort', 
		'Col. Centro', 'Torreon', 'Coahuila', '1983-02-16', 220000)
		Go

Insert into Socio
values ('2874832438','Luis','Aguirre','Benavides', 'M', 'AABL123621NVNSNSA0', 'Soltero', 'Calle Japon', 
		'Fracc. Troje', 'Tijuana', 'Baja Californa', '1999-02-01', 154679)
		Go

Insert into Socio
values ('9754378322','Jos� Louis','Carreon','Fields', 'M', 'CFJL334321GPDGNCA1', 'Soltero', 'Calle Amrabat', 
		'Fracc. Marruecos ', 'Gomez Palacio', 'Durango', '2000-03-17', 100000)
		Go

--Insertar informaci�n en la tabla Emails_Socio
Insert into Emails_Socio
values ('1234567891', 'mmcs1@gmail.com')
Go

Insert into Emails_Socio
values ('1234567891', 'tristecancion@hotmail.com')
Go

Insert into Emails_Socio
values ('1285308455', 'Ernesto_Gustavo@yahoo.com.mx')
Go

Insert into Emails_Socio
values ('1285308455', 'DOEG23@outlook.com')
Go

Insert into Emails_Socio
values ('2874832438', 'luis_aguirre@outlook.com')
Go

Insert into Emails_Socio
values ('2874832438', 'ben34@hotmail.com')
Go

Insert into Emails_Socio
values ('2874832438', 'luis_A_b_21@hotmail.com')
Go

Insert into Emails_Socio
values ('4523568234', 'eli_loera@protonmail.com')
Go

Insert into Emails_Socio
values ('4750934759', 'hblh@live.com.mx')
Go

Insert into Emails_Socio
values ('5984543984', 'j_i_l_McCarthy@hotmail.com')
Go

Insert into Emails_Socio
values ('5984543984', 'Jose98@outlook.com')
Go

Insert into Emails_Socio
values ('5984543984', 'jilm2009@outlook.com')
Go

Insert into Emails_Socio
values ('8752659262', 'gatito11@gmail.com')
Go

Insert into Emails_Socio
values ('8934753539', 'VALENTINjm@gmail.com')
Go

Insert into Emails_Socio
values ('8934753539', 'valentinjaramillomendoza@yahoo.com.mx')
Go

Insert into Emails_Socio
values ('9754378322', 'louis_carreon@yahoo.com.mx')
Go

Insert into Emails_Socio
values ('9754378322', 'pepe_fields1@yahoo.com.mx')
Go

Insert into Emails_Socio
values ('9849347593', 'johanna_bell@hotmail.com')
Go

--Insertar informacion en la tabla Telefonos_Socio
Insert into Telefonos_Socio
values ('1234567891', '8711111111')
Go

Insert into Telefonos_Socio
values ('1285308455', '8571111111')
Go

Insert into Telefonos_Socio
values ('1285308455', '8341111111')
Go

Insert into Telefonos_Socio
values ('1285308455', '8572222222')
Go

Insert into Telefonos_Socio
values ('1285308455', '8873333333')
Go

Insert into Telefonos_Socio
values ('2874832438', '2334444444')
Go

Insert into Telefonos_Socio
values ('4523568234', '8695555555')
Go

Insert into Telefonos_Socio
values ('4523568234', '8466666666')
Go

Insert into Telefonos_Socio
values ('4750934759', '4737777777')
Go

Insert into Telefonos_Socio
values ('5984543984', '8718888888')
Go

Insert into Telefonos_Socio
values ('5984543984', '8719999999')
Go

Insert into Telefonos_Socio
values ('8752659262', '3481111111')
Go

Insert into Telefonos_Socio
values ('8934753539', '5842222222')
Go

Insert into Telefonos_Socio
values ('9754378322', '8723333333')
Go

Insert into Telefonos_Socio
values ('9754378322', '1939999999')
Go

Insert into Telefonos_Socio
values ('9754378322', '9045555555')
Go

Insert into Telefonos_Socio
values ('9849347593', '8752323233')
Go

--Insertar informaci�n en la tabla Barco
Insert into Barco
values ('4324323241', 'Rojo-Panama', '2', 20000, '1234567891', '1200938479')
Go

Insert into Barco
values ('8957658343', 'El Navegante', '3', 244000, '1285308455', '1234512456')
Go

Insert into Barco
values ('8957489943', 'La Ostia', '3', 800000, '2874832438', '1813120900')
Go

Insert into Barco
values ('2131343252', 'Guerrero', '5', 89500, '4523568234', '1813124987')
Go

Insert into Barco
values ('1238748233', 'Santa Maria', '9', 950000, '4750934759', '2124567890')
Go

Insert into Barco
values ('8934278947', 'Disorder', '11', 38500, '5984543984', '3456314567')
Go

Insert into Barco
values ('9043287521', 'El Gato Negro', '7', 205000, '8752659262', '3456723341')
Go

Insert into Barco
values ('8563465832', 'El Marinero', '21', 100000, '8934753539', '4567134001')
Go

Insert into Barco
values ('7846732812', 'Maquina de Agua', '17', 202000, '9754378322', '7100012004')
Go

Insert into Barco
values ('8756348738', 'La Pinta', '23', 300000, '9849347593', '9912415871')
Go

--Insertar informaci�n en la tabla Salida
Insert into Salida
values ('1200938479', '4324323241', 'Mazatlan', '2019-04-21 23:00:00')
Go

Insert into Salida
values ('1234512456', '8957658343', 'Puerto Vallarta', '2019-06-21 21:00:00')
Go

Insert into Salida
values ('1813120900', '8957489943', 'Mazatlan', '2019-05-29 23:00:00')
Go

Insert into Salida
values ('1813124987', '2131343252', 'Mazatlan', '2019-04-21 11:30:00')
Go

Insert into Salida
values ('2124567890', '1238748233', 'Veracruz', '2019-04-21 23:00:00')
Go

Insert into Salida
values ('3456314567', '8934278947', 'Tampico', '2019-09-01 18:15:00')
Go

Insert into Salida
values ('3456723341', '9043287521', 'Topolobampo', '2019-10-07 16:35:00')
Go

Insert into Salida
values ('4567134001', '8563465832', 'Cancun', '2018-02-18 19:30:00')
Go

Insert into Salida
values ('7100012004', '7846732812', 'Cancun', '2017-02-11 17:00:00')
Go

Insert into Salida
values ('9912415871', '8756348738', 'Mazatlan', '2019-02-03 00:00:00')
Go

--Crear un indice de NSS de la tabla Socio
create index idx_NSS on Patron(NSS)
Go
--Crear un indice de la cuota de la tabla Barco
create index idx_cuota on Barco(Cuota)
Go

--Mostrar informaci�n de todas las tablas
select * from Patron
select * from Emails_Patron
select * from Telefonos_Patron
select * from Socio
select * from Emails_Socio
select * from Telefonos_Socio
select * from Salida
select * from Barco

--C1: Mostrar la informacion de todas las Socias 
Select * from Socio 
where sexo = 'F'

--C2: Mostrar Nombre completo y direccion de los Patrones hombres
Select Nombres, Apellido_Paterno, Apellido_Materno, Calle, Colonia, Ciudad, Estado from Patron
where sexo = 'M'

--C3: Mostrar la informaci�n de todos los Socios ordenados por el Pago Anual
Select * from Socio 
order by Pago_Anual

--C4: Mostrar los emails de las socios con salidas a Mazatlan
Select Email from Emails_Socio 
where ID_Socio in(Select ID_Socio from Barco 
				  where Numero_Matricula in(
				  Select Numero_Matricula from Salida
				  where Destino like 'Mazatlan'))

--C5: Cuota promedio de todos los Barcos
select AVG(Cuota) from Barco
				 
--C6: Insertar un socio nuevo
Insert into Socio
values ('3154371754','Javier Luis','Coronado','Galindo', 'M', 'BXJL334321GPDGNCA1', 'Casado', 'Av. Rodriguez', 
		'Col. Arboledas', 'Lerdo', 'Durango', '1998-02-11', 30000)

--C7: Mostrar la informaci�n de las salidas ocurridas en 2017 y 2018
select * from Salida
where Fecha_Hora between '2017-01-01' and '2018-12-31'

--C8: Nombre de los socios con una cuota mayor a 300000 
Select Nombres from Socio  
where ID_Socio in(Select ID_Socio from Barco
				  where Cuota > 300000)

--C9: Informacion de las salidas que su destino no fuera Cancun
Select * from Salida
where Destino <> 'Cancun'

--C10: Apellidos del socio con el maximo pago anual 
Select Apellido_Paterno, Apellido_Materno from Socio 
where Pago_Anual in(Select MAX(Pago_Anual) from Socio)

--C11: Telefonos de los patrones con salidas en el 2017
select Telefono from Telefonos_Patron
where Numero_Licencia in(Select Numero_Licencia from Salida
						 where Fecha_Hora between '2017-01-01' and '2017-12-31')

--C12: CURP y Estado Civil de los patrones en que su destino fue Mazatlan
select CURP, Estado_Civil from Patron
where Numero_Licencia in(Select Numero_Licencia from Salida
						 where Destino like 'Mazatlan')

--C13: Eliminar la tupla del Socio Javier Luis
Delete from Socio where Nombres = 'Javier Luis'

--C14: Cuantos Barcos hay en la base de datos
Select COUNT(*) from Barco

--C15: Actualizar la calle del patr�n Adame a Calle Clemente Flores
update Patron
set Calle = 'Clemente Flores'
where Apellido_Paterno = 'Adame'

--C16: Los nombres de los barcos ordenados de manera descendente 
Select Nombre from Barco
order by Nombre desc

--C17: Ciudades distintas de los Socios
Select distinct(Ciudad) from Socio

--C18: Aumentar las cuotas de los barcos en un %2
update Barco
set Cuota = Cuota*1.02

--C19: Mostrar el sexo de los Socios con pago anual menor a 120000
Select Sexo from Socio
where Pago_Anual < 120000

--C20: Nombre completo y NSS del patr�n que conduce el barco La Ostia
Select Nombres, Apellido_Paterno, Apellido_Materno from Patron
where Numero_Licencia in(Select Numero_Licencia from Barco
						 where Nombre = 'La Ostia')
