SET search_path = us_net_el, public, pg_catalog;

CREATE OR REPLACE VIEW ve_node
	AS
	SELECT
		v_node.id,
		v_node.name,
		v_node.type,
		v_node.sub_type,
		v_node.material,
		v_node.sub_material,
		v_node.district_id,
		v_node.expl_id,
		v_node.comment,
		v_node.facility_reference,
		v_node.state,
		v_node.elevation,
		v_node.begin_lifespan_version,
		v_node.end_lifespan_version,
		v_node.cat_measurement,
		v_node.abone,
		v_node.the_geom
	FROM	
		v_node