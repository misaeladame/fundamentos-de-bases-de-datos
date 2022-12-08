--Script para crear la base de datos Escuela 
--Con las tablas alumnos, materias y cursa 
--Materia FBD 
--Fecha de creacion 7/10/19
--Autor: Jos� Misael Adame Sandoval 18131209
--Fecha de ultima actualizacion 11/11/19
--Lugar: Torreon Coahuila 

--Crear la Base de Datos 
create database escuela 

--Poner en uso Base de Datos 
use escuela 

--Crear la tabla alumno 
create table alumno 
(
no_control varchar(8),
nombre varchar(40),
direccion varchar(30),
sexo char,
telefono varchar(10),
primary key(no_control)
)

--Crear tabla materia 
create table materia 
(
clave_materia varchar(8),
nombre varchar(40),
no_creditos smallint,
primary key(clave_materia)
)

--Crear tabla cursa
create table cursa
(
no_control varchar(8),
clave_materia varchar(8),
semestre varchar(10),
calif tinyint,
primary key (no_control,clave_materia)
)

--Crear tabla profesor
create table profesor
(
no_tarjeta varchar(8),
nombre varchar(15),
ap_paterno varchar(15),
ap_materno varchar(15),
fecha_nac date,
sueldo smallmoney
primary key(no_tarjeta)
)

--Crear tabla imparte
create table imparte
(
clave_materia varchar(8),
no_tarjeta varchar(8),
aula varchar(3)
primary key(clave_materia,no_tarjeta)
)

--Crear constraint para referenciar el numero de control de la tabla cursa
Alter table cursa 
add constraint chck_no_control 
foreign key (no_control)
references alumno (no_control)

--Crear constraint para referenciar la clave de materia de la tabla cursa
Alter table cursa 
add constraint chck_clave_materia
foreign key (clave_materia) 
references materia (clave_materia)

--Crear constraint para validar la calificacion de la tabla cursa 
Alter table cursa 
add constraint chck_calif
check (calif >= 0 and calif <=100) 

--Crear constraint para referenciar la clave de materia de la tabla imparte
Alter table imparte
add constraint chc_clave_materia
foreign key(clave_materia)
references materia(clave_materia)

--Crear constraint para referenciar el numero de tarjeta de la tabla imparte
Alter table imparte
add constraint chck_no_tarjeta
foreign key(no_tarjeta)
references profesor(no_tarjeta)

--Insertar informacion en la tabla alumno
Insert into alumno
values ('18131209','Josr Adame','Calle Teotihuacan Col. Jardines de Morelos','M','8712345678')

Insert into alumno 
values ('18131252','Jesus Lopez','Av. Blanco Col. California','M','8713555555')
 
Insert into alumno 
values ('18131282','Jose Rocha','Dom. Conocido Ejido La Sociedad Protectora','M','8711111111')
 
Insert into alumno 
values ('17131209','Axel Neave','Av. Falcon Col. Centro','M','8724568888')

Insert into alumno 
values ('17131259','Jannette Trujillo','Av. Madrid Col. Yuri','F','8714265988')

--Insertar informacion en la tabla materia 
Insert into materia
values ('0001', 'Calculo Vectorial', 5)

Insert into materia
values ('0002', 'Simulacion', 5)

Insert into materia
values ('0003', 'Estructura de Datos', 5)

Insert into materia
values ('0004', 'Graficacion', 4)

Insert into materia
values ('0005', 'Principios Elec', 5)

--Insertar info en la tabla cursa 
Insert into cursa
values ('17131209', '0001', 'AD18', 95)

Insert into cursa
values ('17131209', '0002', 'EJ17', 80)

Insert into cursa
values ('17131259', '0005', 'AD18', 75)

Insert into cursa
values ('17131259', '0003', 'EJ19', 100)

Insert into cursa
values ('18131209', '0002', 'AD18', 100)

Insert into cursa
values ('18131209', '0003', 'AD17', 100)

Insert into cursa
values ('18131252', '0001', 'AD17', 100)

Insert into cursa
values ('18131252', '0003', 'AD17', 95)

Insert into cursa
values ('18131282', '0001', 'EJ19', 100)

Insert into cursa
values ('18131282', '0004', 'EJ19', 70)

--Insertar informaci�n en la table profesor
insert into profesor
values ('13890001', 'Sergio Victor', 'Guardado', 'Guzman', '19650623', '300.00')

insert into profesor
values ('13890002', 'Edmundo', 'Ollervides', 'Valdes', '19811230', '280.00')  

insert into profesor
values ('13890003', 'Francisco', 'Rios', 'Acosta', '19470412', '350.00')

insert into profesor
values ('13890004', 'Mayela', 'De Santiago', 'Barragan', '19691129', '400.00')

insert into profesor
values ('13890005', 'Jose Angel', 'Delgado', 'Trujillo', '19380223', '500.00')

--Insertar informacion en la tabla imparte
Insert into imparte 
values ('0001', '13890005', '19G')

insert into imparte 
values ('0002', '13890004', '19L')

insert into imparte 
values ('0003', '13890003', 'AA7')

insert into imparte
values ('0004', '13890002', '19J')

insert into imparte
values ('0005', '13890001', '19H')

insert into imparte
values ('0001', '13890004', '19J')

--C1 informacion de todos los alumnos 
Select * from alumno

--C2 mostrar numero de control y nombre de todos los alumnos 
Select no_control, nombre from alumno

--C3: Mostrar la info de todas las alumnas 
Select * from alumno 
where sexo = 'F'

--C4: Mostrar no de control, nombre y direccion de los alumnos 
Select no_control, nombre, direccion from alumno 
where sexo = 'M'

--C5: Mostrar el nombre de todos los alumnos ordenados por nombre
Select nombre from alumno 
order by nombre 

--C6: En forma descendente todos los alumnos ordenados por nombre
Select nombre from alumno 
order by nombre desc

--C7: Mostrar tabla materia 
Select * from materia 

--C8: Informacion de las materias cursadas en el semestre AD17
Select * from cursa  
where semestre = 'AD17'

--C9: Informacion de las materias que no fueron cursadas en EJ19
Select * from cursa 
where semestre <> 'EJ19'

--C10: Info de todas las materias cuya calif sea mayor a 90 
Select * from cursa 
where calif > 90

--C11: Nombre de las materias cuya calif sea mayor a 95
Select nombre from materia 
where clave_materia In(Select clave_materia from cursa 
					   where calif > 95)

--C12: Nombre de los alumnos cuya calif sea mayor a 95
Select nombre from alumno 
where no_control In(Select no_control from cursa 
					where calif > 95)

--C13: mostrar promedio de todas las calif de las materias cursadas
Select AVG(calif) from cursa

--C14: Calificacion maxima de todas las materias cursadas
Select MAX(calif) from cursa

--C15: Clave de las materias con la calificacion m�s baja
select clave_materia from cursa 
where calif in(select MIN(calif) from cursa)

--C16: Cuantos alumnos hay en la Base de Datos
select COUNT(*) from alumno

--C17: Suma de todos los creditos de las materias
select SUM(no_creditos) from materia

--C18: Nombre de las materias con mayor numero de creditos
select nombre from materia 
where no_creditos in(select max(no_creditos) from materia)

--C19: Nombre de las materias cursadas en algun semestre
select nombre from materia 
where clave_materia in (select clave_materia from cursa 
						where semestre In 
					    (select semestre from cursa))

--C20: Cuantos alumnos han cursado la materia de Simulaci�n
select count(no_control) from cursa 
WHERE clave_materia in(SELECT clave_materia FROM materia 
					   WHERE clave_materia = '0002')

--C21: Agregar ciudad a la tabla alumnos restringir a: Torre�n, Gomez, Lerdo
alter table Alumno
add ciudad varchar(20)

alter table Alumno
add constraint chck_ciudad
check (ciudad in('Torreon', 'Gomez', 'Lerdo'))

--C22: Agregar ciudades a los alumnos de la tabla alumnos 
update alumno
set ciudad='Torreon'
where nombre like 'Axel Neave'

update alumno
set ciudad = 'Lerdo'
where no_control like '17131259'

update alumno 
set ciudad = 'Gomez'
where no_control = '18131209'

update alumno 
set ciudad = 'Gomez'
where no_control = '18131252'

update alumno
set ciudad = 'Torreon'
where no_control = '18131282'

--C23: Mostrar las distintas ciudades donde hay alumnos
select distinct ciudad from alumno

--C24: Mostrar cuantos alumnos vivan en Torre�n
select COUNT(*) from alumno 
where ciudad like 'Torreon'

--C25: Cuantos alumnos no viven en Torre�n
select COUNT(*) from alumno 
where ciudad not like 'Torreon'

--C26: Cuantos alumnos han aprobado la materia de Graficacion
select COUNT(no_control) from cursa 
where clave_materia = '0004' and calif>=70

select COUNT(*) from cursa
where clave_materia in(select clave_materia from materia
					   where nombre='Graficacion') and calif >= 70

--C27: Cuantos alumnos han aprobado la materia de Calculo Vectorial
select COUNT(no_control) from cursa 
where clave_materia = '0001' and calif>=70

select COUNT(*) from cursa
where clave_materia in(select clave_materia from materia
					   where nombre='Calculo Vectorial') and calif >= 70

--C28: Crear un indice para la tabla alumno en base a la ciudad 
create index idx_ciudad on alumno (ciudad)

--C29: Cuantas materias imparte la profesora Mayela De Santiago Barragan
select COUNT(clave_materia) from imparte 
where no_tarjeta in (select no_tarjeta from profesor 
					 where nombre = 'Mayela' and ap_paterno = 'De Santiago' and ap_materno = 'Barragan')

--C30: Cuantos profesores nacieron en la decada de los 70's
select COUNT(*) from profesor 
where fecha_nac between '1970/01/01' and '1979/12/31'

--C31: Sueldo promedio de todos los profesores
select AVG(sueldo) from profesor 

--C32: Nombre del profesor que gana mas que el sueldo promedio
select nombre from profesor 
where sueldo > (select AVG(sueldo) FROM profesor)

--C33: Cuales materias imparte Francisco Rios Acosta 
select nombre from materia
where clave_materia in(select clave_materia from imparte 
					   where no_tarjeta in
					   (select no_tarjeta from profesor 
					    where nombre='Francisco' and ap_paterno='Rios' and ap_materno='Acosta'))

--C34: Agregar atributo 'Departamento' a los profesores solo dptos: Mecatronica, Sistemas, Electronica
alter table profesor
add departamento varchar(15)

alter table profesor
add constraint chk_dept
check (departamento in('Sistemas', 'Mecatronica', 'Electronica'))

--C35: Insertar inforamci�n de los departamentos a los profesores
update profesor
set departamento = 'Electronica'
where no_tarjeta like '13890001'

update profesor
set departamento = 'Sistemas'
where no_tarjeta like '13890002'

update profesor
set departamento = 'Sistemas'
where no_tarjeta = '13890003'

update profesor
set departamento = 'Sistemas'
where no_tarjeta = '13890004'

update profesor
set departamento = 'Mecatronica'
where no_tarjeta = '13890005'

--C36: Cuantos profesores hay de Sistemas
select count (no_tarjeta) from profesor 
where departamento = 'Sistemas'

--C37: Nombre del Profesor de sistemas que gana mas que todos los profesores de electronica:
select nombre from profesor 
where departamento like 'Sistemas' and sueldo > all (select sueldo from profesor 
												   	 where departamento like 'Electronica')

--C38: Cuanto ganan todos los profesores de Mecatronica
select SUM(sueldo) from profesor 
where departamento like 'Mecatronica'

--C39: Nombre de las materias que imparten los Profesores de Mectronica
select nombre from materia 
where clave_materia in (select clave_materia from imparte  
						where no_tarjeta in 
						(select no_tarjeta from profesor 
						 where departamento like 'Mecatronica'))

--C40: Cambie la ciudad de Axel Neave para que sea la misma que Jannette Trujillo
update alumno
set ciudad = (select ciudad from alumno
              where nombre = 'Jannette Trujillo')
where nombre = 'Axel Neave'

--C41: Cuantos alumnos viven en Gomez
select COUNT(*) from Alumno 
where ciudad = 'Gomez'

--C42: Nombre de los Maestros que no Imparten Graficacion
select nombre from profesor 
where no_tarjeta not in (select no_tarjeta from imparte 
						 where clave_materia in
						 (select clave_materia from materia 
						  where nombre = 'Graficacion'))

--C43: Nombre de los Alumnos que no han cursado Principios Electricos
select nombre from alumno
where no_control not in (select no_control from cursa
                         where clave_materia in
                         (select clave_materia from materia
                          where nombre like 'Principios Elec'))

--C44: De que departamento es el profesor con mayor sueldo
select departamento from profesor
where sueldo = (select MAX(sueldo) from profesor)

--C45: Cuantos materia imparten los profesores de sistemas
select COUNT(clave_materia) from Imparte
where no_tarjeta in (select no_tarjeta from Profesor
                     where departamento like 'Sistemas')
                     
--C46: Insertar un nuevo Profesor de Mecatronica
Insert into Profesor
values ('13890006', 'Agustin', 'Flores', 'Avila', '1973-09-03', 470.00, 'Mecatronica')

--C47: Nombre del profesor que imparte que no Imparte Materias
Select nombre From profesor
where no_tarjeta not in (Select no_tarjeta From imparte)
    
--C48: Nombre de los Alumnos que han llevado la materia Calculo Vectorial
Select nombre From alumno
where no_control in (Select no_control From cursa
                     where clave_materia in
                     (Select clave_materia From materia
                      where nombre = 'Calculo Vectorial'))
                   
--C49: Cuantos Creditos lleva: 'Jos� Rocha'
select SUM(no_creditos) from materia 
where clave_materia in(select clave_materia from cursa
					   where no_control in
					   (select no_control from alumno
					    where nombre like 'Jose Rocha'))
 
--C50: Mostrar los Profesores ordenadas por sueldo descendiente
Select sueldo From Profesor
order by sueldo desc
    
Select	p.sueldo
From Profesor as P
order by P.sueldo desc

--C51: Aumentar al doble el sueldo de los Profesores de Sistemas
Update Profesor
set sueldo = sueldo*2
where departamento like 'Sistemas'
 
--C52: Cambiar el sueldo de Profesor : 'Mayela De Santiago Barragan' para que sea el mismo sueldo de: 'Sergio Victor Guardado Guzman'
Update Profesor
set sueldo = (Select sueldo From Profesor
              where nombre = 'Sergio Victor' AND ap_paterno = 'Guardado' and ap_materno = 'Guzman')
where nombre = 'Mayela' AND ap_paterno = 'De Santiago' and ap_materno = 'Barragan' 
 
--C53: Cambie departamento del Profesor 'Agustin Flores Avila' a Sistemas
Update profesor
set departamento = 'Sistemas'
where nombre = 'Agustin' AND ap_paterno = 'Flores' and ap_materno = 'Avila' 

--C54: En que aulas Imparte sus Materias 'Francisco Rios Acosta'
select aula from imparte 
where no_tarjeta in(select no_tarjeta from profesor
					where nombre='Francisco' and ap_paterno='Rios' and ap_materno='Acosta')

select  aula 
From Imparte as I, Profesor as P
where I.no_tarjeta = P.no_tarjeta and
P.nombre = 'Francisco' and P.ap_paterno = 'Rios' and P.ap_materno = 'Acosta'

--C55: Cual es la Calificacion menor que se ha obtenido en la Materia de ' Principios Electricos '
select min(calif) from cursa 
where clave_materia in(select clave_materia from materia
					   where nombre = 'Principios Elec')

Select MIN(C.calif)
From Cursa as C, Materia as M
where C.clave_materia = M.clave_materia 
and M.nombre = 'Principios Elec'

--C56: Eliminar los profesores que no imparten materia
delete from profesor where no_tarjeta not in (select no_tarjeta from imparte)

--C57: Inforamci�n de los maestros de Sistemas ordenada por fecha de nacimiento en forma descendente
select * from profesor 
where departamento like 'Sistemas'
order by fecha_nac desc

--C58: Nombre de los alumnos que no han llevado Estructura de Datos
select nombre from alumno
where no_control not in(select no_control from cursa
						where clave_materia in
						(select clave_materia from materia
						 where nombre like 'Estructura de Datos'))

--C59: En total cuanto se les paga a todos los profesores
select SUM(sueldo) from profesor

--C60: Cuantas materias hay en la BD, que imparte los maestros de Mecatr�nica
select count(*) from materia 
where clave_materia in(select clave_materia from imparte 
					   where no_tarjeta in
					   (select no_tarjeta from profesor
					   where departamento = 'Mecatronica'))

