-- Modificado el 17/01/2026
--
--
ALTER SESSION SET NLS_LANGUAGE=American;
ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yy';

CREATE TABLE continentes 
    ( IDcont  NUMBER(1) , 
      nombre    VARCHAR2(25),
    CONSTRAINT PKContinentes PRIMARY KEY (IDCont)  );

CREATE TABLE paises  
   (IDpais      CHAR(2) NOT NULL, 
    nombre      VARCHAR2(40), 
    IDcont      NUMBER(1),  
    CONSTRAINT  PKpais PRIMARY KEY (IDpais) );

ALTER TABLE paises 
ADD ( CONSTRAINT FKpais_continente FOREIGN KEY (IDcont) 
          	  REFERENCES continentes(IDcont)  ) ;

CREATE TABLE oficinas 
    (IDoficina  NUMBER(4) NOT NULL, 
     direccion  VARCHAR2(40), 
     codpostal  VARCHAR2(10), 
     ciudad     VARCHAR2(25), 
     estado     VARCHAR2(25), 
     IDpais     CHAR(2), 
     CONSTRAINT PKoficina PRIMARY KEY (IDoficina), 
     CONSTRAINT FKoficina_pais FOREIGN KEY (IDpais) REFERENCES paises(IDpais)  ) ;

CREATE TABLE departamentos 
    ( IDdep    NUMBER(4), 
     nombre    VARCHAR2(40) NOT NULL, 
     IDdirector   NUMBER(4), 
     IDoficina    NUMBER(4), 
     CONSTRAINT PKdep PRIMARY KEY (IDdep), 
     CONSTRAINT FKdep_Oficina FOREIGN KEY (IDoficina) REFERENCES oficinas (IDoficina)  ) ;

CREATE TABLE puestos 
    ( IDpuesto      VARCHAR2(4), 
     titulo         VARCHAR2(40) NOT NULL, 
     salario_min    NUMBER(6),   
     salario_max    NUMBER(6), 
     CONSTRAINT PKpuestos PRIMARY KEY (IDpuesto) ) ;

CREATE TABLE empleados 
    ( IDemp NUMBER(4), 
     nombre     VARCHAR2(20), 
     apellido   VARCHAR2(25) not null, 
     sexo       CHAR(1), 
     email      VARCHAR2(50), 
     dianacimiento DATE not null, 
     Diaingreso    DATE not null, 
     IDpuesto  VARCHAR2(4) not null, 
     salario   NUMBER(6), 
     bono      NUMBER(6), 
     IDjefe    NUMBER(4), 
     IDdep     NUMBER(4), 
     CONSTRAINT   CKemp_salario_min CHECK (salario >= 0),  
     CONSTRAINT   PKempleados PRIMARY KEY (IDemp), 
     CONSTRAINT   FKemp_dep  FOREIGN KEY (IDdep) REFERENCES departamentos(IDdep), 
     CONSTRAINT   FKemp_puesto FOREIGN KEY (IDpuesto) REFERENCES puestos (IDpuesto), 
     CONSTRAINT   FKemp_jefe  FOREIGN KEY (IDjefe) REFERENCES empleados (IDemp)  ) ;

ALTER TABLE departamentos  
ADD ( CONSTRAINT FKdep_director FOREIGN KEY (IDdirector) REFERENCES empleados(IDemp)  ) ;

CREATE TABLE movimientos 
    (IDemp      NUMBER(4) NOT NULL, 
     Diacambio  DATE not null, 
     IDpuestoAnterior  VARCHAR2(4), 
     IDpuestoNuevo     Varchar2(4), 
     IDdepAnterior NUMBER(4), 
     IDdepNuevo    NUMBER(4), 
     CONSTRAINT    PKmovimientos PRIMARY KEY (IDemp,Diacambio), 
     CONSTRAINT    FKmov_puestoAnt FOREIGN KEY (IDpuestoAnterior) references puestos(IDpuesto), 
     CONSTRAINT    FKmov_puestoNuevo FOREIGN KEY (IDpuestoNuevo) references puestos(IDpuesto), 
     CONSTRAINT    FKMov_depAnt FOREIGN KEY (IDdepAnterior) references departamentos(IDdep), 
     CONSTRAINT    FKMov_depNuevo FOREIGN KEY (IDdepNuevo) references departamentos(IDdep)) ;


ALTER TABLE departamentos DISABLE CONSTRAINT FKdep_director;

CREATE TABLE Proyectos 
    ( 
     IDPrt              CHAR (6)  NOT NULL , 
     Nombre_Prt         VARCHAR2 (20)  NOT NULL , 
     Fecha_Inicio       DATE  NOT NULL , 
     Avance             NUMBER (3)  NOT NULL , 
     Presupuesto        NUMBER (7) , 
     IDoficina NUMBER (4)  NOT NULL 
    ) 
    LOGGING 
;

ALTER TABLE Proyectos 
    ADD CONSTRAINT Proyectos_PK PRIMARY KEY ( IDPrt ) ;


CREATE TABLE Asignaciones 
    ( 
     IDemp NUMBER (4)  NOT NULL , 
     IDPrt CHAR (6)  NOT NULL 
    ) 
    LOGGING 
;

ALTER TABLE Asignaciones 
    ADD CONSTRAINT Asignaciones_PK PRIMARY KEY ( IDemp, IDPrt ) ;

