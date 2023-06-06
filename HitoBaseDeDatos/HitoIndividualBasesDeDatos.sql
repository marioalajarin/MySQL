drop database if exists hito;
create database hito;
use hito;

create table barrio(
	IDBarrio int primary key,
    NombreBarrio varchar(35)
);

create table calle(
	IDCalle int primary key,
    NombreCalle varchar(35)
);

create table puntoInteres(
	IDPuntoInteres int primary key,
    NombrePuntoInteres varchar(35),
    TipoPuntoInteres varchar(40)
);

create table lineaAutobus(
	IDAutobus int primary key,
    NumeroAutobus varchar(10)
);


create table lineaMetro(
	NumeroLinea int primary key,
    Color varchar(20)
);

create table estacionMetro(
	IDEstacion int primary key,
    NombreEstacion varchar(50)
);

create table estacionLineaMetro(
	NumeroLinea int,
    IDEstacion int,
	foreign key (NumeroLinea) references lineaMetro(NumeroLinea),
    foreign key (IDEstacion) references estacionMetro(IDEstacion)
);

create table tramo(
	IDBarrio int,
    IDCalle int,
    IDEstacion int,
	IDTramo int primary key,
    CoordenadasInicio varchar(50), 
    CoordenadasFinal varchar(50), 
    Orden int,
    foreign key (IDBarrio) references barrio(IDBarrio),
    foreign key (IDCalle) references calle(IDCalle),
    foreign key (IDEstacion) references estacionMetro(IDEstacion)
);

create table paradaAutobus(
	IDParada int primary key,
    NombreParada varchar(35),
    NumeroParada int,
    IDTramo int,
    foreign key (IDTramo) references tramo(IDTramo)
);

create table lineaParadaAutobus(
	IDAutobus int,
    IDParada int,
	foreign key (IDAutobus) references lineaAutobus(IDAutobus),
    foreign key (IDParada) references paradaAutobus(IDParada)
);

create table puntoInteresTramo(
	IDPuntoInteres int,
    IDTramo int,
	foreign key (IDPuntoInteres) references puntoInteres(IDPuntoInteres),
    foreign key (IDTramo) references tramo(IDTramo)
);

insert into barrio values (47383,"Ribera");

insert into calle values (37293,"Calle de Pavía");
insert into calle values (45645,"Calle de Jose Juan Recio");
insert into calle values (77246,"Calle de Bola de Cañón");

insert into puntoInteres values (74837,"Centro Comercial La Gavia","Centro comercial");
insert into puntoInteres values (74203,"Ayuntamiento de Usera","Ayuntamiento");

insert into lineaAutobus values (3839,143);
insert into lineaAutobus values (1244,102);
insert into lineaAutobus values (5234,012);

insert into lineaMetro values (1,"Azul");

insert into estacionMetro values (91827,"El Torcal");
insert into estacionMetro values (39847,"El Río");
insert into estacionMetro values (12903,"La Magdalena");

insert into tramo values(47383,37293,91827,73817,"40.31642046, -3.7442760264","40.31759424, -3.7070453126",1);
insert into tramo values(47383,37293,null,84756,"40.31759424, -3.7070453126","40.51759424, -3.7270453126",2);
insert into tramo values(47383,45645,null,12710,"31.36127375, -3.7442760345","30.31759424, -3.7100453126",1);
insert into tramo values(47383,45645,null,52355,"30.31759424, -3.7100453126","30.00759424, -3.2300453126",2);
insert into tramo values(47383,77246,12903,99999,"11.31642046, 5.7442760264","11.12059424, 5.9070453126",1);
insert into tramo values(47383,77246,39847,17283,"11.12059424, 5.9070453126","10.96059424, 6.1170453126",2);

insert into paradaAutobus values (82917,"Congosto",3033,73817);
insert into paradaAutobus values (37476,"Buenos Aires",3309,99999);
insert into paradaAutobus values (12736,"Leganés",3000,17283);

insert into estacionLineaMetro values("1","91827");
insert into estacionLineaMetro values("1","39847");
insert into estacionLineaMetro values("1","12903");

insert into lineaParadaAutobus values("3839","82917");
insert into lineaParadaAutobus values("3839","37476");
insert into lineaParadaAutobus values("1244","37476");
insert into lineaParadaAutobus values("5234","12736");

insert into puntoInteresTramo values("74837","73817");
insert into puntoInteresTramo values("74837","84756");
insert into puntoInteresTramo values("74203","17283");

-- SELECTS

-- Pregunta 1: dime los tramos que tengan estación de metro
select idtramo,idestacion
from tramo
where idestacion is not null;

-- Pregunta 2: dime el nombre de las paradas de la linea 1
select NombreEstacion, lineaMetro.NumeroLinea
from lineaMetro inner join estacionLineaMetro
on lineaMetro.NumeroLinea = estacionLineaMetro.NumeroLinea
inner join estacionMetro on estacionMetro.IDEstacion = estacionLineaMetro.IDEstacion
where lineaMetro.NumeroLinea ="1";

-- Pregunta 3: dime el nombre de las calles de cada tramo con orden 2 y su IDTramo
select IDTramo, orden, NombreCalle
from tramo inner join calle
on tramo.IDCalle = calle.IDCalle
where orden = "2";

-- Pregunta 4: dime el nombre de las paradas de autobús (en orden alfabetico) por las que pasa el 143.
select NombreParada, lineaAutobus.IDAutobus, lineaAutobus.NumeroAutobus
from lineaAutobus inner join lineaParadaAutobus
on lineaAutobus.IDAutobus = lineaParadaAutobus.IDAutobus
inner join paradaAutobus on paradaAutobus.IDParada = lineaParadaAutobus.IDParada
where lineaAutobus.NumeroAutobus = "143"
order by NombreParada;

-- Pregunta 5: dime el nombre de las calles donde hay estaciones de metro
select NombreCalle, estacionMetro.IDEstacion, estacionMetro.NombreEstacion
from calle inner join tramo
on calle.IDCalle = tramo.IDCalle
inner join estacionMetro on estacionMetro.IDEstacion = tramo.IDEstacion
where estacionMetro.IDEstacion is not null;

-- Pregunta 6: ¿en qué tramos hay puntos de interés? (IDTramo, orden y nombre de puntos de interés)
select tramo.IDTramo, Orden, puntoInteres.NombrePuntoInteres
from puntoInteres inner join puntoInteresTramo
on puntoInteres.IDPuntoInteres = puntoInteresTramo.IDPuntoInteres
inner join tramo on tramo.IDTramo = puntoInteresTramo.IDTramo;

-- Pregunta 7: dime los puntos de interés y su tipo en el barrio Ribera
select barrio.NombreBarrio, puntoInteres.NombrePuntoInteres, puntoInteres.TipoPuntoInteres
from barrio inner join puntoInteres;

-- Pregunta 8: dime las coordenadas de inicio y final de los tramos de cada calle (Coordenadas de inicio y final, nombre de la calle, idtramo, orden)
select NombreCalle, tramo.IDTramo, CoordenadasInicio, CoordenadasFinal,orden
from calle inner join tramo
on calle.IDCalle = tramo.IDCalle
order by NombreCalle, orden;












