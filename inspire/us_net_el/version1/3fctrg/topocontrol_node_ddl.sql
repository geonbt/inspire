SET search_path = us_net_el, public, pg_catalog;

CREATE OR REPLACE FUNCTION topocontrol_node()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
v_node_proximity double precision = 0.05;
v_node_proximity_control boolean;
v_node_proximity_counter integer;
BEGIN
	SET search_path = us_net_el, public, pg_catalog;

	SELECT COUNT(*) INTO v_node_proximity_counter FROM node WHERE ST_Distance(NEW.the_geom,node.the_geom) < v_node_proximity;
	
	IF TG_OP = 'UPDATE' THEN
		IF (v_node_proximity_counter > 1) THEN
			 --UPDATE node SET the_geom = OLD.the_geom WHERE id = NEW.id;
			 RAISE EXCEPTION 'Girilmeye çalışılan düğüm noktası 0.5 m uzaklık kuralını ihlal ediyor, koordinat = (%)',v_node_proximity_counter;
		ELSE
			RETURN NEW;
		END IF;
	ELSIF TG_OP = 'INSERT' THEN
		IF (v_node_proximity_counter > 1) THEN
			--DELETE FROM node WHERE id = NEW.id;
			RAISE EXCEPTION 'INSERT!! Girilmeye çalışılan düğüm noktası 0.5 m uzaklık kuralını ihlal ediyor, koordinat = (%)',v_node_proximity_counter;
		ELSE
			RETURN NEW;
		END IF;
		RETURN NEW;
	END IF;
END;
$BODY$;


	
