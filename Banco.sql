--Script para crear la base de datos Banco
--Con las tablas Cliente, Sucursal, Cuenta, Prestamo, Cli_Cta, Cli_Prest 
--Materia FBD 
--Fecha de creacion 11/11/19
--Autor: Jos� Misael Adame Sandoval 18131209
--Fecha de ultima actualizacion 14/11/19
--Lugar: Torreon Coahuila 

--C1: Crear la base de datos
create database Banco

--Poner en uso la base de datos
use Banco

--C2: Crear la tabla Sucursal
Create table Sucursal
(
Nombre_Sucursal varchar(20),
Ciudad_Sucursal varchar(15),
Activos money,
primary key(Nombre_Sucursal)
)

--Creacion de la tabla Cliente
Create table Cliente
(
Nombre_Cliente varchar(40),
Calle_Cliente varchar(30),
Ciudad_Cliente varchar(20),
primary key(Nombre_Cliente)
)

--Creacion de la tabla Cuenta
Create table Cuenta
(
Numero_Cuenta bigint,
Nombre_Sucursal varchar(20),
Saldo money,
primary key(Numero_Cuenta)
)

--Creacion de la tabla Prestamo
Create table Prestamo
(
Numero_Prestamo bigint,
Nombre_Sucursal varchar(20),
Importe money,
primary key(Numero_Prestamo)
)

--Creacion de la tabla Cliente_Cuenta
Create table Cliente_Cuenta
(
Nombre_Cliente varchar(40),
Numero_Cuenta bigint
primary key(Nombre_Cliente)
)

--Creacion de la tabla Cliente_Prestamo
Create table Cliente_Prestamo
(
Nombre_Cliente varchar(40),
Numero_Prestamo bigint,
primary key(Nombre_Cliente)
)

--C3.- Crear constraints para: Cliente_Cuenta
Alter table Cliente_Cuenta
add constraint chk_Nombre_Cliente_Cli_Cta
foreign key (Nombre_Cliente)
references Cliente(Nombre_Cliente)

Alter table Cliente_Cuenta
add constraint chk_Numero_Cuenta_Cli_Cta
foreign key (Numero_Cuenta)
references Cuenta(Numero_Cuenta)

--Crear constraints para: Cuenta
Alter table Cuenta
add constraint chck_Nombre_Sucursal_Cta
foreign key (Nombre_Sucursal)
references Sucursal(Nombre_Sucursal)

--Crear constraints para: Prestamo
Alter table Prestamo
add constraint chck_Nombre_Sucursal_Prest
foreign key (Nombre_Sucursal)
references Sucursal(Nombre_Sucursal)

--Crear constraints para: Cliente_Prestamo
Alter table Cliente_Prestamo
add constraint chck_Nombre_Cliente_Cli_Prest
foreign key(Nombre_Cliente)
references Cliente(Nombre_Cliente)

Alter table CLiente_Prestamo
add constraint chck_Numero_Prestamo_Cli_Prest
foreign key(Numero_Prestamo)
references Prestamo(Numero_Prestamo)

--Insertar informaci�n en la tabla Cliente
insert into Cliente
values('Adrian', 'Gonzalitos', 'Torreon')

insert into Cliente
values('Luis', 'Av. Hidalgo', 'Gomez Palacio')

insert into Cliente
values('Misael Adame', 'Avenida 85', 'Gomez Palacio')

insert into Cliente
values('Julio Furch', 'Av. Cuauhtemoc', 'Mendoza')

insert into Cliente
values('Kailen', 'Banana', 'Durango')

--Insertar inforamcion en la tabla Sucursal
insert into Sucursal
values('Olvera', 'Torreon', 4000000)

insert into Sucursal
values('Tl�loc', 'CDMX', 850000000)

insert into Sucursal
values('Mayotte' ,'Mendoza', 9999995)

insert into Sucursal 
values('Hamburgo', 'Gomez Palacio', 50000000)

insert into Sucursal
values('Angelo', 'Durango', 4500000)

--Insertar informaci�n en la tabla Cuenta
insert into Cuenta
values(24598, 'Tlaloc', 40000)

insert into Cuenta
values(56565, 'Hamburgo', 5000000)

insert into Cuenta
values(78921, 'Angelo', 300000)

insert into Cuenta
values(00001, 'Hamburgo', 2500)

insert into Cuenta
values(02212, 'Mayotte', 8500000)

--Insertar informaci�n en la tabla Prestamo
insert into Prestamo
values(0001, 'Hamburgo', 4500)

insert into Prestamo 
values(234543, 'Hamburgo', 20000)

insert into Prestamo
values(893243, 'Tlaloc', 330000)

insert into Prestamo
values(412444, 'Tlaloc', 90000)

insert into Prestamo
values(8999, 'Angelo', 500000)

--Insertar informaci�n en la tabla Cliente_Cuenta
insert into Cliente_Cuenta
values('Julio Furch', 56565)

insert into Cliente_Cuenta
values('Adrian', 24598)

insert into Cliente_Cuenta
values('Luis', 02212)

insert into Cliente_Cuenta
values('Misael Adame' , 00001)

insert into Cliente_Cuenta
values('Kailen', 78921)

--Insetar informacion en la tabla Clientes_Prestamo
insert into Cliente_Prestamo
values('Misael Adame', 0001)

insert into Cliente_Prestamo
values('Kailen', 234543)

insert into Cliente_Prestamo
values('Julio Furch', 8999)

--C4: Agregar atributo fecha de apertura a la tabla Cuenta
Alter table Cuenta
add Fecha_Apertura smallDateTime

--C5: Muestre nombre, calle, ciudad de los clientes que tienen prestamos
select Nombre_Cliente, Calle_Cliente, Ciudad_Cliente from Cliente 
where Nombre_Cliente in(Select Nombre_Cliente from Cliente_Prestamo)

--C6: Nombre del cliente con la cuenta del saldo mas alto
select Nombre_Cliente from Cliente_Cuenta
where Numero_Cuenta in(Select Numero_Cuenta from Cuenta 
					   where Saldo in
					   (Select MAX(Saldo) from Cuenta))

--C7: Nombre, calle, ciudad, cliente con el prestamo del menor importe
select Nombre_Cliente, Calle_Cliente, Ciudad_Cliente from Cliente
where Nombre_Cliente in(Select Nombre_Cliente from Cliente_Prestamo
						where Numero_Prestamo in
						(Select Numero_Prestamo from Prestamo
						 where Importe in
						 (Select MIN(Importe) from Prestamo)))

--C8: Nombre, ciudad de la sucursal con el menor activos
Select Nombre_Sucursal, Ciudad_Sucursal from Sucursal 
where Activos in(Select MIN(Activos) from Sucursal)

--C9: Informaci�n de los prestamos ordenada por importe de forma descendente 
Select * from Prestamo 
order by Importe desc

--C10: Distintas ciudades donde existen clientes
Select distinct(Ciudad_Cliente) from Cliente

--C11: Nombre de los Clientes tienen un prestamo y tambien tienen una cuenta
Select Nombre_Cliente from Cliente_Prestamo 
where Nombre_Cliente in(Select Nombre_Cliente from Cliente_Cuenta)

--C12.- Cambiar la ciudad de Lopez para que sea la misma de Gomez
Update Cliente
set Ciudad_Cliente = (Select Ciudad_Cliente from Cliente 
					  where Nombre_Cliente = 'Gomez')
where Nombre_Cliente = 'Lopez'

--C13: Cuantos prestamos a otorgado la sucursal Navocerrada
Select COUNT(*) from Prestamo 
where Nombre_Sucursal like 'Navacerrada'

--C14: Muestre los importes de los prestamos, suponiendo que el importe cuenta un 10%
Select importe*1.10 from Prestamo

--C15: Promedio de los actuvos de las sucursales que estan en la ciudad de Aluche
Select AVG(Activos) from Sucursal 
where Ciudad_Sucursal like 'Aluche'

--C16: En total, �a cuanto asciende el importe de los prestamos que ha otorgado la sucursal centro?
Select SUM(importe) from Prestamo
where Nombre_Sucursal like 'Centro'

--C17: Reduzca el saldo de todas las cuentas un %2
Update Cuenta
set saldo = saldo*0.98

--C18: Agregue el atributo tel�fono a los clientes
alter table Cliente
add Telefono int

select * from Cliente
--C19: Aumente el activos un 10% a quienes tengan los activos actual menor de 5000
Update Sucursal
set Activos = Activos*1.10
where Activos < 5000

--C20: Nombre de los clientes que viven en la calle Carretas
Select Nombre_Cliente from Cliente
where Calle_Cliente like 'Carretas'

--C21: Cambiar la ciudad de los clientes cuyo nombre inicie con 'A', para que sea Torre�n
Update Cliente
set Ciudad_Cliente = 'Torreon'
where Nombre_Cliente = 'A%'

--C22: Mostrar la informaci�n de los prestamos de los clientes que viven en Gomez 
select * from Prestamo
where Numero_Prestamo in(Select Numero_Prestamo from Cliente_Prestamo
						 where Nombre_Cliente in
						 (Select Nombre_Cliente from Cliente
						  where Ciudad_Cliente like 'Gomez Palacio'))

--C23: Cuales son los saldos de las cuentas que son menores a todos los importes de los prestamos
select Saldo from Cuenta
where Saldo < ALL (Select Importe from Prestamo)

--C24: Cuales son los importes de los prestamos que son mayores a cualqueir saldo de las cuentas
Select Importe from Prestamo 
where Importe > any (Select Saldo from Cuenta)

--C25: Calle, Nombre y ciudad del Cliente que m�s debe
Select Calle_Cliente, Nombre_Cliente, Ciudad_Cliente from Cliente
where Nombre_Cliente in(Select Nombre_Cliente from Cliente_Prestamo
						where Numero_Prestamo in
						(Select Numero_Prestamo from Prestamo
						 where Importe in(Select MAX(Importe) from Prestamo)))

--C26: Nombre de las sucursales que terminen con la letra 'D'
Select Nombre_Sucursal from Sucursal
where Nombre_Sucursal like '%D'

--C27: Crear un indice para la tabla sucursal, por activos
Create index idx_activos_suc on Sucursal(Activos)

--C28: Aumente un 10% de inter�s a los prestamos de la Sucursal Centro
Update Prestamo 
set Importe = Importe*1.10
where  Nombre_Sucursal = 'Centro'
						  
--C29: Inserte un nuevo Cliente
Insert into Cliente
values('Alfaro', 'Santa Fe', 'Gomez Palacio', '871233454')

--C30: Nombre de los CLientes cuyos prestamos tienen un importe mayor que mil pesos pero menor que cinco mil pesos
Select Nombre_Cliente from Cliente_Prestamo
where Numero_Prestamo in(Select Numero_Prestamo from Prestamo
						 where Importe > 1000 and importe < 5000)

select * from Cliente
select * from Sucursal
select * from Cuenta
select * from Prestamo
select * from Cliente_Cuenta
select * from Cliente_Prestamo
