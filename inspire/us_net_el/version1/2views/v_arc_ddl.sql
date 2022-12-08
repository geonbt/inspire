SET search_path = us_net_el, public, pg_catalog;

CREATE OR REPLACE VIEW v_arc
	AS
	SELECT
		vu_arc.id,
		vu_arc.start_node,
		vu_arc.end_node,
		vu_arc.type,
		vu_arc.sub_type,
		vu_arc.conductive_material,
		vu_arc.operating_voltage,
		vu_arc.nominal_voltage,
		vu_arc.facility_reference,
		vu_arc.expl_id,
		vu_arc.district_id,
		vu_arc.state,
		vu_arc.comment,
		vu_arc.begin_lifespan_version,
		vu_arc.end_lifespan_version,
		vu_arc.cat_measurement,
		vu_arc.the_geom
	FROM
		vu_arc
	JOIN v_state_arc USING(id)