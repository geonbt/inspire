SET search_path = us_net_el, public, pg_catalog;

CREATE OR REPLACE VIEW v_node
	AS
	SELECT
		vu_node.id,
		vu_node.name,
		vu_node.type,
		vu_node.sub_type,
		vu_node.material,
		vu_node.sub_material,
		vu_node.district_id,
		vu_node.expl_id,
		vu_node.comment,
		vu_node.facility_reference,
		vu_node.state,
		vu_node.elevation,
		vu_node.begin_lifespan_version,
		vu_node.end_lifespan_version,
		vu_node.cat_measurement,
		vu_node.abone,
		vu_node.the_geom
	FROM
		vu_node
	JOIN v_state_node USING (id)
		
		