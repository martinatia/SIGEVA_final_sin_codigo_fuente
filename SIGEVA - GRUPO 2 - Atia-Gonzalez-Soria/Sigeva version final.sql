CREATE TABLE ministerio(
  id_ministerio varchar(5) NOT NULL,
  min_nombre varchar(50) NOT NULL,
  min_direccion varchar(50) NOT NULL,
  min_telefono varchar(25) NOT NULL,
  PRIMARY KEY (id_ministerio)
);

CREATE TABLE efector(
  codigoEfector int NOT NULL AUTO_INCREMENT,
  efe_nombre varchar(50) NOT NULL,
  efe_direccion varchar(50) NOT NULL,
  efe_telefono varchar(25) NOT NULL,
  tipoDeEfector varchar(50) NOT NULL,
  efe_departamento varchar(50) NOT NULL,
  efe_ciudad varchar(50) NOT NULL,
  id_ministerio varchar(5) NOT NULL,
  st int DEFAULT '1',
  PRIMARY KEY (codigoEfector)
);


CREATE TABLE vacuna (
  codigoVacuna int NOT NULL AUTO_INCREMENT,
  nombreVacuna varchar(50) NOT NULL,
  cantidadDeDosis varchar(25) DEFAULT 'Unica',
  calendario varchar(50) NOT NULL,
  contraindicacion varchar(100) DEFAULT NULL,
  sl int DEFAULT '1',
  PRIMARY KEY (codigoVacuna)
);

CREATE TABLE personalministerio(
  CUIL varchar(13) NOT NULL,
  nombrePM varchar(50) NOT NULL,
  apellidoPM varchar(50) NOT NULL,
  cargoPM varchar(50) NOT NULL,
  tipoDeContrato varchar(50) NOT NULL,
  fechaInicioContrato date NOT NULL,
  id_ministerio varchar(5) NOT NULL,
  st int DEFAULT '1',
  PRIMARY KEY (CUIL)
);


CREATE TABLE personalefector(
  CUIL varchar(13) NOT NULL,
  nombrePE varchar(50) NOT NULL,
  apellidoPE varchar(50) NOT NULL,
  cargoPE varchar(50) NOT NULL,
  tipoDeContratoPE varchar(50) NOT NULL,
  fechaInicioContratoPE datetime NOT NULL,
  codigoEfector int NOT NULL,
  st int DEFAULT '1',
  PRIMARY KEY (CUIL)
);


CREATE TABLE usuario(
  id_usuario varchar(25) NOT NULL,
  usu_email varchar(50) NOT NULL,
  usu_contrasena varchar(25) NOT NULL,
  usu_fecha_alta date NOT NULL,
  tipo_usuario int NOT NULL,
  CUIL varchar(13) NOT NULL,
  st int DEFAULT '1',
  PRIMARY KEY (`id_usuario`)
);


CREATE TABLE lote(
  codigoLote varchar(5) NOT NULL,
  codigoVacuna int NOT NULL,
  fechaElaboracion date NOT NULL,
  fechaDeVencimiento date NOT NULL,
  estadoLote int DEFAULT '1',
  stockDisponible int NOT NULL DEFAULT '0',
  st int DEFAULT '1',
  PRIMARY KEY (codigoLote,codigoVacuna)
);

CREATE TABLE depositoministerio(
  id_ministerio varchar(5) NOT NULL,
  codigoVacuna int NOT NULL,
  stock int NOT NULL DEFAULT '0',
  stockMinimo int NOT NULL,
  estado int NOT NULL DEFAULT '1',
  PRIMARY KEY (id_ministerio,codigoVacuna)
);

CREATE TABLE loteefector(
  codigoLote varchar(5) NOT NULL,
  fechaElaboracion date NOT NULL,
  fechaDeVencimiento date NOT NULL,
  estadoLote int DEFAULT '1',
  codigoVacuna int NOT NULL,
  stockDisponible int NOT NULL DEFAULT '0',
  codigoEfector int NOT NULL,
  st int DEFAULT '1',
  PRIMARY KEY (codigoLote,codigoVacuna,codigoEfector)
);


CREATE TABLE depositoefector(
  codigoEfector int NOT NULL,
  codigoVacuna int NOT NULL,
  stock int NOT NULL DEFAULT '0',
  puntoReposicion int NOT NULL DEFAULT '0',
  estado int NOT NULL DEFAULT '1',
  PRIMARY KEY (codigoEfector,codigoVacuna)
);

CREATE TABLE pedido (
  codigoPedido int NOT NULL AUTO_INCREMENT,
  fechaPedido datetime DEFAULT NULL,
  estadoPedido int NOT NULL DEFAULT '1',
  codigoEfector int NOT NULL,
  id_usuario varchar(25) NOT NULL,
  PRIMARY KEY (codigoPedido)
);


CREATE TABLE pedvac(
  codigoPedido int NOT NULL,
  codigoVacuna int NOT NULL,
  cantidadSolicitada int NOT NULL,
  PRIMARY KEY (codigoPedido,codigoVacuna)
);

CREATE TABLE pedidom(
  codigoPedido int NOT NULL AUTO_INCREMENT,
  fechaPedido datetime DEFAULT NULL,
  estadoPedido int NOT NULL DEFAULT '1',
  idMinisterio varchar(5) NOT NULL,
  id_usuario varchar(25) NOT NULL,
  PRIMARY KEY (codigoPedido)
);

CREATE TABLE pedvacm(
  codigoPedido int NOT NULL,
  codigoVacuna int NOT NULL,
  cantidadSolicitada int NOT NULL,
  PRIMARY KEY (codigoPedido,codigoVacuna)
);

CREATE TABLE IF NOT EXISTS libroingreso(
  codigoLibro int NOT NULL AUTO_INCREMENT,
  fechaCarga datetime NOT NULL,
  codigoPedido int NOT NULL,
  id_ministerio varchar(5) NOT NULL,
  id_usuario varchar(25) NOT NULL,
  PRIMARY KEY (codigoLibro)
);

CREATE TABLE libvacunas(
  codigoLibro int NOT NULL,
  codigoVacuna int NOT NULL,
  codigoLote varchar(5) NOT NULL,
  cantidad int NOT NULL,
  PRIMARY KEY (codigoLibro,codigoVacuna,codigoLote)
);

CREATE TABLE minentrega(
  codigoEntregaM int NOT NULL AUTO_INCREMENT,
  FechaEntrega datetime NOT NULL,
  codigoEfector int NOT NULL,
  CUIL varchar(13) NOT NULL,
  codigoPedidoRealizado int NOT NULL,
  PRIMARY KEY (codigoEntregaM)
);

CREATE TABLE minentregavac(
  codigoEntregaM int NOT NULL,
  codigoVacuna int NOT NULL,
  cantidad int NOT NULL,
  codLote varchar(5) NOT NULL,
  PRIMARY KEY (codigoEntregaM,codigoVacuna,codLote)
);

CREATE TABLE entrega(
  codigoEntrega int NOT NULL AUTO_INCREMENT,
  fechaEntrega datetime NOT NULL,
  codigoPedido int NOT NULL,
  codigoEfector int NOT NULL,
  CUILentrega varchar(13) NOT NULL,
  CUILrecibe varchar(13) NOT NULL,
  PRIMARY KEY (codigoEntrega)
);


CREATE TABLE entregavacuna(
  codigoEntrega int NOT NULL,
  codigoVacuna int NOT NULL,
  loteVacuna varchar(5) NOT NULL,
  cantidad int NOT NULL,
  PRIMARY KEY (codigoEntrega,codigoVacuna,loteVacuna)
);


CREATE TABLE repinconsistencia(
  codigoReporte int NOT NULL AUTO_INCREMENT,
  codigoEntregaM int NOT NULL,
  codigoPedido int NOT NULL,
  Fecha date NOT NULL,
  CUIL varchar(13) NOT NULL,
  estadoLeido int NOT NULL DEFAULT '1',
  PRIMARY KEY (codigoReporte)
);

CREATE TABLE repinconvac(
  codigoReporte int NOT NULL,
  codigoVacuna int NOT NULL,
  codigoLote varchar(5) NOT NULL,
  cantidad int NOT NULL,
  PRIMARY KEY (codigoReporte,codigoVacuna,codigoLote)
);

CREATE TABLE IF NOT EXISTS informeefector(
  codigoInforme int NOT NULL AUTO_INCREMENT,
  Fecha date NOT NULL,
  CUIL varchar(13) NOT NULL,
  codigoEfector int NOT NULL,
  PRIMARY KEY (codigoInforme,Fecha,codigoEfector)
  );

CREATE TABLE informeefectorvac(
  codigoInforme int NOT NULL,
  codigoVacuna int NOT NULL,
  codigoLote varchar(5) NOT NULL,
  cantidad int NOT NULL,
  PRIMARY KEY (codigoInforme,codigoVacuna,codigoLote)
);


INSERT INTO Usuario (id_usuario,usu_email,usu_contrasena,usu_fecha_alta,tipo_usuario,CUIL) VALUES ('Admin','admin@sigeva.com','1234','2021-06-01','0','20-35844319-3');
INSERT INTO Ministerio (id_ministerio,min_nombre,min_direccion,min_telefono) VALUES ('1','Min. Sgo Del Estero','Belgano Sur 1850','4378585');
INSERT INTO Efector (efe_nombre,efe_direccion,efe_telefono,tipoDeEfector,efe_departamento,efe_ciudad,id_ministerio) 
VALUES ('UPA CENTRO LB','Rivadavia s/n','427112233','UPA','Juan Francisco Borges','Capital','1');
