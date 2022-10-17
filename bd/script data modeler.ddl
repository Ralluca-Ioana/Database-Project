-- Generated by Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   at:        2022-05-17 21:17:14 GMT+02:00
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE bilet (
    id_muzeu        NUMBER(20) NOT NULL,
    nume            VARCHAR2(50),
    duratavizionare NUMBER(20),
    pret            NUMBER(20),
    stoc            NUMBER(20)
);

ALTER TABLE bilet ADD CONSTRAINT bilet_pk PRIMARY KEY ( id_muzeu );

CREATE TABLE client (
    id_user NUMBER(20) NOT NULL,
    nume    VARCHAR2(50),
    email   VARCHAR2(50),
    parola  VARCHAR2(50)
);

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( id_user );

CREATE TABLE comanda (
    id_comanda     NUMBER(20) NOT NULL,
    numarbilete    NUMBER(20),
    totalcomanda   NUMBER,
    bilet_id_muzeu NUMBER(20) NOT NULL,
    cos_id_cos     NUMBER(20) NOT NULL
);

ALTER TABLE comanda ADD CONSTRAINT comanda_pk PRIMARY KEY ( id_comanda );

CREATE TABLE cos (
    id_cos         NUMBER(20) NOT NULL,
    client_id_user NUMBER(20) NOT NULL
);

ALTER TABLE cos ADD CONSTRAINT cos_pk PRIMARY KEY ( id_cos );

ALTER TABLE comanda
    ADD CONSTRAINT comanda_bilet_fk FOREIGN KEY ( bilet_id_muzeu )
        REFERENCES bilet ( id_muzeu );

ALTER TABLE comanda
    ADD CONSTRAINT comanda_cos_fk FOREIGN KEY ( cos_id_cos )
        REFERENCES cos ( id_cos );

ALTER TABLE cos
    ADD CONSTRAINT cos_client_fk FOREIGN KEY ( client_id_user )
        REFERENCES client ( id_user );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              7
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
