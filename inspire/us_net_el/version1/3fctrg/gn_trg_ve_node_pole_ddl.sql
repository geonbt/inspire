SET search_path = us_net_el, public, pg_catalog;

CREATE OR REPLACE FUNCTION gn_trg_ve_node_pole()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE LEAKPROOF
AS $BODY$
BEGIN
	
	SET search_path = us_net_el, public, pg_catalog;
	IF TG_OP = 'INSERT' THEN
		
		PERFORM setval('identifier_id_seq', gn_fct_setvalidentifier(),true);
		NEW.id:= (SELECT nextval('identifier_id_seq'));
		
		INSERT INTO node(id,name,sub_type,sub_material,district_id,expl_id,comment,facility_reference,state,elevation,begin_lifespan_version,end_lifespan_version,
						cat_measurement,abone,the_geom)
		VALUES (NEW.id,NEW.name,NEW.sub_type,NEW.sub_material,NEW.district_id,NEW.expl_id,NEW.comment,NEW.facility_reference,NEW.state,NEW.elevation,
			   NEW.begin_lifespan_version,NEW.end_lifespan_version,NEW.cat_measurement,NEW.abone,NEW.the_geom);
			   
		INSERT INTO man_pole (node_id,length) VALUES (NEW.id,NEW.length);
	
	ELSIF TG_OP = 'UPDATE' THEN
		
		UPDATE node
		SET id = NEW.id, name = NEW.name, sub_type = NEW.sub_type, sub_material = NEW.sub_material, district_id = NEW.district_id, expl_id = NEW.expl_id,
			comment = NEW.comment, facility_reference = NEW.facility_reference, state = NEW.state, elevation = NEW.elevation, 
			begin_lifespan_version = NEW.begin_lifespan_version, end_lifespan_version = NEW.end_lifespan_version, cat_measurement = NEW.cat_measurement,
			abone = NEW.abone, the_geom = NEW.the_geom
		WHERE id = OLD.id;
		
		UPDATE man_pole
		SET node_id = NEW.id, length = NEW.length
		WHERE node_id = OLD.id;
	
	ELSIF TG_OP = 'DELETE' THEN
	
		DELETE FROM node WHERE id = NEW.id;
		DELETE FROM man_pole WHERE node_id = NEW.id;
		
	END IF;
	
	RETURN NEW;
	
END;
$BODY$;