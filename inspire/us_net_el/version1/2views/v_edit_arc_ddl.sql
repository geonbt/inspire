SET search_path = us_net_el, public, pg_catalog;

CREATE OR REPLACE VIEW v_edit_arc
	AS
	SELECT
		v_arc.id,
		v_arc.start_node,
		v_arc.end_node,
		v_arc.type,
		v_arc.sub_type,
		v_arc.conductive_material,
		v_arc.operating_voltage,
		v_arc.nominal_voltage,
		v_arc.facility_reference,
		v_arc.expl_id,
		v_arc.district_id,
		v_arc.state,
		v_arc.comment,
		v_arc.begin_lifespan_version,
		v_arc.end_lifespan_version,
		v_arc.cat_measurement,
		v_arc.the_geom
	FROM
		v_arc