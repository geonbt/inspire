SET search_path = us_net_el, public, pg_catalog;


CREATE OR REPLACE FUNCTION gn_trg_v_edit_arc()
	RETURNS trigger
	LANGUAGE 'plpgsql'
	COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	
	SET search_path = us_net_el, public, pg_catalog;
	
	IF TG_OP = 'INSERT' THEN
		PERFORM setval('identifier_id_seq', gn_fct_setvalidentifier(),true);
		NEW.id:= (SELECT nextval('identifier_id_seq'));
		
		INSERT INTO arc(id,start_node,end_node,sub_type,conductive_material,operating_voltage,nominal_voltage,facility_reference,expl_id,district_id,state,comment,
					   begin_lifespan_version,end_lifespan_version,_the_geom)
		VALUES (NEW.id,NEW.start_node,NEW.end_node,NEW.sub_type,NEW.conductive_material,NEW.operating_voltage,NEW.nominal_voltage,NEW.facility_reference,NEW.expl_id,
			   NEW.district_id,NEW.state,NEW.comment,NEW.begin_lifespan_version,NEW.end_lifespan_version,NEW.the_geom);
	ELSIF TG_OP = 'UPDATE' THEN
		UPDATE arc
		SET id = NEW.id , start_node = NEW.start_node, end_node = NEW.end_node, sub_type = NEW.sub_type, conductive_material = NEW.conductive_mateial,
			operating_voltage = NEW.operating_voltage, nominal_voltage = NEW.nominal_voltage, facility_reference = NEW.facility_reference, expl_id = NEW.expl_id,
			district_id = NEW.district_id, state = NEW.state, comment = NEW.comment, begin_lifespan_version = NEW.begin_lifespan_version,
			end_lifespan_version = NEW.end_lifespan_version, the_geom = NEW.the_geom 
		WHERE id = OLD.id;
	ELSIF TG_OP = 'DELETE' THEN
		DELETE FROM ARC WHERE id = NEW.id;
	END IF;
	RETURN NEW;
	
END
$BODY$