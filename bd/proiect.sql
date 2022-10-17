CREATE OR REPLACE TRIGGER secure_bilet
BEFORE INSERT OR UPDATE OR DELETE ON bilet
BEGIN
  IF (TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN'))
      OR (TO_DATE(TO_CHAR(SYSDATE, 'HH24:MI'), 'HH24:MI') 
        NOT BETWEEN TO_DATE('08:00', 'HH24:MI')
          AND TO_DATE('22:00', 'HH24:MI'))
  THEN
    RAISE_APPLICATION_ERROR(-20500, 'Se pot efectua modificari asupra datelor doar in timpul orelor de program!');
  END IF;
END;

CREATE OR REPLACE TRIGGER sold_out
BEFORE UPDATE ON bilet
FOR EACH ROW
DECLARE
    v_stoc NUMBER := 0;
    cursor c1 is
    select stoc
    from bilet;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO v_stoc; 
    
    IF v_stoc < 0
    THEN
        RAISE_APPLICATION_ERROR(-20500, 'STOCUL NU POATE FI < 0');
    END IF;
       END LOOP;
    CLOSE c1;
END;

CREATE OR REPLACE PACKAGE bilet_op IS
    PROCEDURE cumpara_bilet(v_id in bilet.id_muzeu%type,v_buy IN bilet.stoc%type);
    PROCEDURE delete_bilet (v_id in bilet.id_muzeu%type);
    PROCEDURE update_bilet ( v_id in bilet.id_muzeu%type,
        v_nume in bilet.nume%type, 
        v_durataVizionare in bilet.durataVizionare%type, 
        v_pret in bilet.pret%type, 
        v_stoc in bilet.stoc%type);
    PROCEDURE insert_bilet( v_nume in bilet.nume%type default 'unknown', 
        v_durataVizionare in bilet.durataVizionare%type default 0, 
        v_pret in bilet.pret%type default 0, 
        v_stoc in bilet.stoc%type default 0);
    PROCEDURE delete_comanda (v_id in comanda.id_comanda%type, v_id_muzeu in comanda.bilet_id_muzeu%type);
    FUNCTION sumaTotal (v_cos in comanda.cos_id_cos%type) RETURN comanda.totalComanda%type;
 END bilet_op;

CREATE SEQUENCE bilet_id_muzeu;
CREATE SEQUENCE comanda_id_comanda;

CREATE OR REPLACE PACKAGE BODY bilet_op IS
    PROCEDURE cumpara_bilet(v_id in bilet.id_muzeu%type, v_buy IN bilet.stoc%type)
    IS
        v_pret bilet.pret%type;
        v_total bilet.pret%type;
        
        CURSOR c1 is 
        SELECT pret
        FROM bilet
        WHERE id_muzeu=v_id;
 
        BEGIN
            UPDATE BILET
            SET STOC = stoc-v_buy
            WHERE id_muzeu = v_id;
                
            OPEN c1;
            LOOP
                FETCH c1 INTO v_pret;
                EXIT WHEN c1%notfound;
            END LOOP;
            CLOSE c1;
            
            v_total := v_pret * v_buy;
            INSERT INTO comanda
            VALUES(comanda_id_comanda.Nextval, v_buy, v_total, v_id, 1);
            
    END cumpara_bilet;
 
    PROCEDURE delete_bilet (v_id in bilet.id_muzeu%type)
    IS
        BEGIN
            DELETE FROM BILET
            WHERE id_muzeu = v_id;
            IF SQL%ROWCOUNT = 0 THEN
              dbms_output.put_line('Produsul cu ID-ul ' || v_id || ' nu exista!');
            ELSE
              dbms_output.put_line('Produsul cu ID-ul ' || v_id || 'a fost sters cu succes.');
            END IF;
    END delete_bilet;
    
     PROCEDURE delete_comanda (v_id in comanda.id_comanda%type, v_id_muzeu in comanda.bilet_id_muzeu%type)
     IS
        v_stoc NUMBER;
        BEGIN
            SELECT numarBilete
            INTO v_stoc
            FROM comanda
            WHERE id_comanda=v_id AND bilet_id_muzeu=v_id_muzeu;
                
            UPDATE bilet
            SET stoc = stoc + v_stoc
            WHERE id_muzeu=v_id_muzeu;
            
            DELETE FROM comanda
            WHERE id_comanda = v_id;
            IF SQL%ROWCOUNT = 0 THEN
              dbms_output.put_line('Produsul cu ID-ul ' || v_id || ' nu exista!');
            ELSE
              dbms_output.put_line('Produsul cu ID-ul ' || v_id || 'a fost sters cu succes.');
            END IF;
    END delete_comanda;
    
    PROCEDURE update_bilet ( v_id in bilet.id_muzeu%type,
        v_nume in bilet.nume%type, 
        v_durataVizionare in bilet.durataVizionare%type, 
        v_pret in bilet.pret%type,
        v_stoc in bilet.stoc%type)
    IS
        BEGIN
        UPDATE bilet
        SET nume = v_nume, durataVizionare=v_durataVizionare, pret=v_pret, stoc=v_stoc
        WHERE id_muzeu=v_id;
          IF SQL%ROWCOUNT = 0 THEN
              dbms_output.put_line('Produsul cu ID-ul ' || v_id || ' nu exista!');
            ELSE
              dbms_output.put_line('Produsul cu ID-ul ' || v_id || 'a fost actualizat cu succes.');
            END IF;
    END update_bilet;
    
    
    PROCEDURE insert_bilet( v_nume in bilet.nume%type default 'unknown', 
        v_durataVizionare in bilet.durataVizionare%type default 0, 
        v_pret in bilet.pret%type default 0,  
        v_stoc in bilet.stoc%type default 0)
        IS
            BEGIN
            INSERT INTO bilet
            VALUES(bilet_id_muzeu.NEXTVAL, v_nume, v_durataVizionare, v_pret, v_stoc);
    END insert_bilet;
    
    FUNCTION sumaTotal (v_cos in comanda.cos_id_cos%type)
        RETURN comanda.totalComanda%type
        IS
        v_sum comanda.totalComanda%type;
        
        BEGIN
        SELECT sum(totalComanda)
        INTO v_sum
        FROM comanda
        WHERE cos_id_cos=v_cos;
    END sumaTotal;
    
 END bilet_op;

