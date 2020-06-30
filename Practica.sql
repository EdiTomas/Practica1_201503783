CREATE DATABASE COMITE_OLIMPICO
-- Genear el script que crea cada tabla
-- NOTA: Debe cumplir con todos las restricciones correspondientes (primary
-- key, Foreign Key, Unique, Null, Not null).



       
-- 1)  PROFESION
CREATE TABLE PROFESION
(
    cod_prof int not null,
    nombre  varchar(50) not null,
    constraint pk_cod_prof primary key(cod_prof),
	UNIQUE(nombre)
);

-- 2)  PAIS
CREATE TABLE PAIS
(
    cod_pais int not null,
	nombre  varchar(50) not null,
	constraint pK_cod_pais primary key(cod_pais),
	UNIQUE(nombre)
);

-- 3)  PUESTO
CREATE TABLE PUESTO
(
    cod_puesto int not null,
	nombre  varchar(50) not null,
	constraint pK_cod_puesto primary key(cod_puesto),
	UNIQUE(nombre)
);

-- 4)  DEPARTAMENTO
CREATE TABLE DEPARTAMENTO
(
    cod_depto int not null,
	nombre  varchar(50) not null,
	constraint pK_cod_depto primary key(cod_depto),
	UNIQUE(nombre)
);

-- 5)  MIEMBRO
CREATE TABLE MIEMBRO
(
    cod_miembro int not null,
	nombre  varchar(100) not null,
	apellido varchar(100) not null,
	edad int not null,
    telefono  int null,
	residencia varchar(100) null,
	PAIS_cod_pais  int not null,
	PROFESION_cod_profesion  int not null,
	constraint pk_cod_miembro primary key(cod_miembro),
	constraint fk_PAIS_cod_pais foreign key(PAIS_cod_pais) 
	REFERENCES PAIS(cod_pais),
	constraint fk_PROFESION_cod_profesion foreign key(PROFESION_cod_profesion) 
	REFERENCES PROFESION(cod_prof) 
);


-- 6) PUESTO_MIEMBRO
CREATE TABLE PUESTO_MIEMBRO
(
	MIEMBRO_cod_miembro int not null,    
    PUESTO_cod_puesto int not null,
	DEPARTAMENTO_cod_depto int not null,
	fecha_inicio  date not null,
	fecha_fin  date null,
	constraint pk_cod_puesto_miembro primary key(
    MIEMBRO_cod_miembro,PUESTO_cod_puesto,
	DEPARTAMENTO_cod_depto),
    constraint fK_MIEMBRO_cod_miembro foreign key (MIEMBRO_cod_miembro) REFERENCES MIEMBRO (cod_miembro),        
    constraint fK_PUESTO_cod_puesto foreign key (PUESTO_cod_puesto) REFERENCES PUESTO (cod_puesto),        
    constraint fK_DEPARTAMENTO_cod_depto foreign key (DEPARTAMENTO_cod_depto) REFERENCES DEPARTAMENTO (cod_depto)        
);

 
-- 7)  TIPO_MEDALLA
CREATE TABLE TIPO_MEDALLA
(
    cod_tipo int not null,
    medalla  varchar(20) not null,
    constraint pk_cod_tipo primary key(cod_tipo),
	UNIQUE(medalla)
	
);

-- 8)  MEDALLERO
CREATE TABLE MEDALLERO
(
    PAIS_cod_pais int not null,
    cantidad_medallas  int not null,
    TIPO_MEDALLA_cod_tipo int not null,
    constraint pk_cod_medallero primary key(
    PAIS_cod_pais,TIPO_MEDALLA_cod_tipo),
    constraint fK_PAIS_cod_pais foreign key (PAIS_cod_pais) REFERENCES PAIS (cod_pais),        
    constraint fK_TIPO_MEDALLA_cod_tipo foreign key (TIPO_MEDALLA_cod_tipo) REFERENCES TIPO_MEDALLA(cod_tipo)        
);






-- 9)  DISCIPLINA
CREATE TABLE DISCIPLINA
(
    cod_disciplina int not null,
    nombre  varchar(50) not null,
    descripcion  varchar(750) null,
    constraint pk_cod_disciplina primary key(cod_disciplina)
);

-- 10)  ATETLA
CREATE TABLE ATLETA
(
	cod_atleta int not null,
	nombre  varchar(50) not null,
	apellido varchar(50) not null,
	edad int not null,
    participantes  varchar(100) not null,
	DISCIPLINA_cod_disciplina  int not null,
	PAIS_cod_pais  int not null,
	constraint pk_cod_atleta primary key(cod_atleta),
	constraint fk_DISCIPLINA_cod_disciplina foreign key(DISCIPLINA_cod_disciplina) 
	REFERENCES DISCIPLINA(cod_disciplina),
	constraint fk_PAIS_cod_pais foreign key(PAIS_cod_pais) 
	REFERENCES PAIS(cod_pais)
);

-- 11)  CATEGORIA
CREATE TABLE CATEGORIA
(
    cod_categoria int not null,
    categoria  varchar(50) not null,
    constraint pk_cod_categoria primary key(cod_categoria)
);

-- 12)  TIPO_PARTICIPACION
CREATE TABLE TIPO_PARTICIPACION
(
    cod_participacion int not null,
    tipo_participacion  varchar(100) not null,
    constraint pk_cod_participacion primary key(cod_participacion)
);

-- 13)  EVENTO
CREATE TABLE EVENTO
(
    cod_evento int not null,
    fecha      date not null,
	ubicacion  varchar(50) not null,
	hora       date not null,
    DISCIPLINA_cod_disciplina  int not null,
	TIPO_PARTICIPACION_cod_participacion int not null,
	CATEGORIA_cod_categoria  int not null, 
    constraint pk_cod_evento primary key(cod_evento),
    constraint fk_DISCIPLINA_cod_disciplina foreign key(DISCIPLINA_cod_disciplina) 
	REFERENCES DISCIPLINA(cod_disciplina),
	constraint fk_TIPO_PARTICIPACION_cod_participacion foreign key(TIPO_PARTICIPACION_cod_participacion) 
	REFERENCES TIPO_PARTICIPACION(cod_participacion),
	constraint fk_CATEGORIA_cod_categoria foreign key(CATEGORIA_cod_categoria) 
	REFERENCES CATEGORIA(cod_categoria)
);

-- 14)  EVENTO_ATLETA

CREATE TABLE EVENTO_ATLETA
(
    ATLETA_cod_atleta int not null,
    EVENTO_cod_evento int not null,
    constraint pk_evento_atleta primary key(
    ATLETA_cod_atleta,EVENTO_cod_evento), 
    constraint fK_ATLETA_cod_atleta foreign key (ATLETA_cod_atleta) REFERENCES ATLETA (cod_atleta),        
    constraint fK_EVENTO_cod_evento foreign key (EVENTO_cod_evento) REFERENCES EVENTO (cod_evento)        
);

-- 15)  TELEVISORA

CREATE TABLE TELEVISORA
(
    cod_televisora int not null,
    nombre int not null,
    constraint pk_cod_televisora primary key(cod_televisora) 
);
-- 16)  COSTO_EVENTO

CREATE TABLE COSTO_EVENTO
(
    EVENTO_cod_evento int not null,
    TELEVISORA_cod_televisora int not null,
	tarifa numeric not null,
    constraint pk_costo_evento primary key(EVENTO_cod_evento,TELEVISORA_cod_televisora),
    constraint fK_EVENTO_cod_evento foreign key (EVENTO_cod_evento) REFERENCES EVENTO (cod_evento),        
    constraint fK_TELEVISORA_cod_televisora foreign key (TELEVISORA_cod_televisora) REFERENCES TELEVISORA (cod_televisora)        
);

--  2)  En la tabla “Evento” se decidió que la fecha y hora se trabajaría en una sola
--      columna
---     Eliminar las columnas fecha y hora.
---     Crear una columna llamada “fecha_hora” con el tipo de dato que
---     corresponda según el DBMS.

 alter table  EVENTO
 drop column  fecha,
 drop column  hora,
 add column  fecha_hora timestamp;



--  3) Todos los eventos de las olimpiadas deben ser programados del 24 de julio
-- de 2020 a partir de las 9:00:00 hasta el 09 de agosto de 2020 hasta las
-- 20:00:00.
-- Generar el Script que únicamente permita registrar los eventos entre estas
-- fechas y horarios.

  alter table EVENTO
  add constraint verificar_fecha_evento check (fecha_hora between '2020/07/24 9:00:00'and'2020/08/09 20:00:00' )



-- 4) Se decidió que las ubicación de los eventos se registrarán previamente en
-- una tabla y que en la tabla “Evento” sólo se almacenara la llave foránea
-- según el código del registro de la ubicación, para esto debe realizar lo
-- siguiente:
-- a. Crear la tabla llamada “Sede” que tendrá los campos:
--   i). Código: será tipo entero y será la llave primaria.
-- ii). Sede: será tipo varchar(50) y será obligatoria.
-- b). Cambiar el tipo de dato de la columna Ubicación de la tabla Evento
-- por un tipo entero.
-- c. Crear una llave foránea en la columna Ubicación de la tabla Evento y
-- referenciarla a la columna código de la tabla Sede, la que fue creada
-- en el paso anterior.

--a)
CREATE TABLE SEDE(
	   codigo int not null,
       sede varchar(50) not null,
	   constraint pk_codigo primary key(codigo)	
	);

--b)
alter table EVENTO
alter column ubicacion set data type int using ubicacion::int,
alter column ubicacion set not null,
add constraint  fk_ubicacion foreign key(ubicacion) REFERENCES SEDE(codigo);

-- 5) Se revisó la información de los miembros que se tienen actualmente y antes
-- de que se ingresen a la base de datos el Comité desea que a los miembros
-- que no tengan número telefónico se le ingrese el número por Default 0 al
-- momento de ser cargados a la base de datos
   alter table MIEMBRO
   alter column telefono set default 0;
   
   
   
--    6) Generar el script necesario para hacer la inserción de datos a las tablas
-- requeridas.
   
   insert into PAIS (cod_pais,nombre) values
   (1,'Guatemala'),
   (2,'Francia'),
   (3,'Argentina'),
   (4,'Alemania'),
   (5,'Italia'),
   (6,'Brasil'),
   (7,'Estados Unidos');
   
   insert into PROFESION (cod_prof,nombre) values
   (1,'Medico'),
   (2,'Arquitecto'),
   (3,'Ingeniero'),
   (4,'Secretaria'),
   (5,'Auditor');
   
   insert into MIEMBRO (cod_miembro,nombre,apellido,edad,telefono,residencia,PAIS_cod_pais,PROFESION_cod_profesion) values
   (1,'Scott','Mitchell',32,null,' 1092 Highland Drive Manitowoc, WI 54220',7,3),
   (2,'Fanette','Poulin',25,25075853,' 49, boulevard Aristide Briand 76120 LE GRAND-QUEVILLY',2,4),
   (3,'Laura','Cunha silva',55,null,'Rua Onze, 86 UberabaMG',6,5),
   (4,'Juan jose','Lopez',38,'36985247','26 calle 4-10 zona 11',1,2),
   (5,'Arcangela','Panicucci',39,'391664921','Via Santa Teresa, 114 90010-Geraci Siculo PA',5,1),
   (6,'Jeuel','Villalpando',31,null,'Acuña de Figeroa 6106  80101 Playa Pascual',3,5);
   
   insert into DISCIPLINA (cod_disciplina,nombre,descripcion) values
    (1,'Atletismo','Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamiento de martillo, jabalina y disco.'),
	(2,'Bádminton',null),
    (3,'Ciclismo',null),
    (4,'Judo','Es un arte marcial que se originó en Japón alrededor de 1880'),
    (5,'Lucha',null),
    (6,'Tenis de Mesa',null),
    (7,'Boxeo',null),
    (8,'Natacion','Está presente como deporte en los Juegos desde la primera edición de la era moderna, en Atenas, 
     Grecia, en 1896, donde se disputo en aguas abiertas.'),
	(9,'Esgrima',null),
    (10,'Vela',null);
	insert into TIPO_MEDALLA (cod_tipo,medalla) values
    (1,'oro'),
    (2,'plata'),
	(3,'Bronce'),
    (4,'Platino');
	
	insert into CATEGORIA (cod_categoria,categoria) values
    (1,'Clasificatorio'),
    (2,'Eliminatorio'),
	(3,'Final');

insert into TIPO_PARTICIPACION (cod_participacion,tipo_participacion) values
    (1,'individual'),
    (2,'Parejas'),
	(3,'Equipos');
	
	
	PAIS_cod_pais int not null,
    cantidad_medallas  int not null,
    TIPO_MEDALLA_cod_tipo int not null,
	
insert into MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) values
    (5,1,3),
    (2,1,5),
	(6,3,4),
	(4,4,3),
	(7,3,10),
	(3,2,8),
	(1,1,2),
	(1,4,5),
	(5,2,7);
	
insert into SEDE (codigo,sede) values
	(1,'Gimnasio Metropolitano de Tokio'),
	(2,'Jardín del Palacio Imperial de Tokio'),
	(3,'Gimnasio Nacional Yoyogi'),
	(4,'Nippon Budokan'),
	(5,'Estadio Olímpico');



insert into EVENTO (cod_evento,fecha_hora,ubicacion,DISCIPLINA_cod_disciplina,
	TIPO_PARTICIPACION_cod_participacion ,CATEGORIA_cod_categoria) values
	(1,'24/7/2020 11:00:00' ,3,2,2,1),
	(2,'26/7/2020 10:30:00' ,1,6,1,3),
	(3,'30/7/2020 18:45:00' ,5,7,1,2),
	(4,'01/8/2020 12:15:00' ,2,1,1,1),
	(5,'08/8/2020 19:35:00' ,4,10,3,1);
	
	
	
	select * from EVENTO
	
-- 7) Después de que se implementó el script el cuál creó todas las tablas de las
-- bases de datos, el Comité Olímpico Internacional tomó la decisión de
-- eliminar la restricción “UNIQUE” de las siguientes tablas:
-- Tabla
-- País Columna
-- Nombre
-- Tipo_medalla
-- Departamento Medalla
-- Nombre
-- Elabore el script que elimine las restricciones “UNIQUE” de las columnas
-- antes mencionadas.

ALTER TABLE PAIS DROP CONSTRAINT PAIS_nombre_key;
ALTER TABLE TIPO_MEDALLA DROP CONSTRAINT TIPO_MEDALLA_medalla_key;
ALTER TABLE DEPARTAMENTO DROP CONSTRAINT DEPARTAMENTO_nombre_key;









-- 8) Después de un análisis más profundo se decidió que los Atletas pueden
-- participar en varias disciplinas y no sólo en una como está reflejado
-- actualmente en las tablas, por lo que se pide que realice lo siguiente.
-- a. Script que elimine la llave foránea de “cod_disciplina” que se
-- encuentra en la tabla “Atleta”.
-- b. Script que cree una tabla con el nombre “Disciplina_Atleta” que
-- contendrá los siguiente campos:
-- i. Cod_atleta (llave foránea de la tabla Atleta)
-- ii. Cod_disciplina (llave foránea de la tabla Disciplina)
-- La llave primaria será la unión de las llaves foráneas “cod_atleta” y
-- “cod_disciplina”.

ALTER TABLE ATLETA
DROP CONSTRAINT fk_DISCIPLINA_cod_disciplina,
DROP column DISCIPLINA_cod_disciplina; 

create table DISCIPLINA_ATLETA
(
  cod_atleta int not null, 
  cod_disciplina int not null,
  Constraint  pk_disciplina_atleta primary key(cod_atleta,cod_disciplina),
  Constraint  fk_cod_atleta foreign key(cod_atleta) REFERENCES ATLETA (cod_atleta),
  Constraint  fk_cod_disciplina foreign key(cod_disciplina) REFERENCES DISCIPLINA (cod_disciplina)
);
-- 9) En la tabla “Costo_Evento” se determinó que la columna “tarifa” no debe
-- ser entero sino un decimal con 2 cifras de precisión.
-- Generar el script correspondiente para modificar el tipo de dato que se le
-- pide.
        alter table COSTO_EVENTO
		alter column tarifa set data type numeric(20,2); 

-- 10) Generar el Script que borre de la tabla “Tipo_Medalla”, el registro siguiente:
     select * from TIPO_MEDALLA
	 Delete from MEDALLERO  
	 where TIPO_MEDALLA_cod_tipo = 2;
     
	 Delete from TIPO_MEDALLA  
	 where cod_tipo = 2;
     select * from TIPO_MEDALLA
-- 11)
-- La fecha de las olimpiadas está cerca y los preparativos siguen, pero de
-- último momento se dieron problemas con las televisoras encargadas de
-- transmitir los eventos, ya que no hay tiempo de solucionar los problemas
-- que se dieron, se decidió no transmitir el evento a través de las televisoras
-- por lo que el Comité Olímpico pide generar el script que elimine la tabla
-- “TELEVISORAS” y “COSTO_EVENTO”.
     DROP TABLE TELEVISORA,COSTO_EVENTO;
-- 12. El comité olímpico quiere replantear las disciplinas que van a llevarse a cabo,
-- por lo cual pide generar el script que elimine todos los registros contenidos
-- en la tabla “DISCIPLINA”.
    select * from  DISCIPLINA;
	
    Delete from EVENTO;   
    Delete from DISCIPLINA;   
    
-- 13. Los miembros que no tenían registrado su número de teléfono en sus
-- perfiles fueron notificados, por lo que se acercaron a las instalaciones de
-- Comité para actualizar sus datos.
   
-- Laura Cunha Silva              55464601
-- Jeuel Villalpando              91514243	
-- Scott Mitchell                 920686670
   update  MIEMBRO set telefono=55464601 where ( nombre = 'Laura' and apellido ='Cunha Silva');
   update  MIEMBRO set telefono=91514243 where ( nombre = 'Jeuel' and apellido ='Villalpando');
   update  MIEMBRO set telefono=920686670 where( nombre = 'Scott' and apellido ='Mitchell');
   
-- 14) El Comité decidió que necesita la fotografía en la información de los atletas
-- para su perfil, por lo que se debe agregar la columna “Fotografía” a la tabla
-- Atleta, debido a que es un cambio de última hora este campo deberá ser
-- opcional.
-- Utilice el tipo de dato que crea conveniente según el DBMS y explique el por
-- qué utilizó este tipo de dato.
   ALTER TABLE ATLETA
   add column fotografia bytea null;   




-- 15). Todos los atletas que se registren deben cumplir con ser menores a 25 años.
-- De lo contrario no se debe poder registrar a un atleta en la base de datos.
    alter table ATLETA
	add constraint vr_atleta_edad check (edad<25);
	
	
	
