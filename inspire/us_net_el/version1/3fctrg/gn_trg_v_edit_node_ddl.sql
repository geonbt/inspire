SET search_path = us_net_el, public, pg_catalog;


CREATE OR REPLACE FUNCTION gn_trg_v_edit_node()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
v_state	integer;
BEGIN
	
	SET search_path = us_net_el, public, pg_catalog;
	SELECT id FROM STATE INTO v_state WHERE name = NEW.state;
	IF TG_OP = 'INSERT' THEN
		
		PERFORM setval('identifier_id_seq', gn_fct_setvalidentifier(),true);
		NEW.id:= (SELECT nextval('identifier_id_seq'));
		
		INSERT INTO node(id,name,sub_type,sub_material,district_id,expl_id,comment,facility_reference,state,elevation,
					   begin_lifespan_version,end_lifespan_version,the_geom)
		VALUES (NEW.id,NEW.name,NEW.sub_type,NEW.sub_material, NEW.district_id, NEW.expl_id,NEW.comment, NEW.facility_reference,
				v_state,NEW.elevation,NEW.begin_lifespan_version,NEW.end_lifespan_version,NEW.the_geom);
	ELSIF TG_OP = 'UPDATE' THEN
		
		UPDATE node
		SET id = NEW.id, name = NEW.name ,sub_type = NEW.sub_type, sub_material = NEW.sub_material,
			facility_reference = NEW.facility_reference, expl_id = NEW.expl_id,
			district_id = NEW.district_id, state = v_state, comment = NEW.comment, elevation = NEW.elevation,
			begin_lifespan_version = NEW.begin_lifespan_version,
			end_lifespan_version = NEW.end_lifespan_version, the_geom = NEW.the_geom 
		
		WHERE id = OLD.id;
	
	ELSIF TG_OP = 'DELETE' THEN
		
		DELETE FROM node WHERE id = NEW.id;
	
	END IF;
	
	RETURN NEW;
	
END
$BODY$