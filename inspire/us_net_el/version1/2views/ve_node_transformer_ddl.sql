SET search_path = us_net_el, public, pg_catalog;

CREATE OR REPLACE VIEW ve_node_transformer
	AS
	SELECT
		ve_node.id,
		ve_node.name,
		ve_node.type,
		ve_node.sub_type,
		ve_node.material,
		ve_node.sub_material,
		ve_node.district_id,
		ve_node.expl_id,
		ve_node.comment,
		ve_node.facility_reference,
		ve_node.state,
		ve_node.elevation,
		ve_node.begin_lifespan_version,
		ve_node.end_lifespan_version,
		ve_node.cat_measurement,
		ve_node.abone,
		ve_node.the_geom,
		man_transformer.power
	FROM	
		ve_node
	JOIN man_transformer ON man_transformer.node_id = ve_node.id
	WHERE ve_node.type::text = 'TRANSFORMER'::text
	