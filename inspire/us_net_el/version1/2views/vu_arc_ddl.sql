SET search_path = us_net_el, public, pg_catalog;


CREATE OR REPLACE VIEW us_net_el.vu_arc
 AS
 SELECT arc.id,
    arc.start_node,
    arc.end_node,
    cat_feature.system_id AS type,
    cat_arc.id AS sub_type,
    cat_mat_arc.id AS conductive_material,
    arc.operating_voltage,
    arc.nominal_voltage,
    arc.facility_reference,
    arc.expl_id,
    arc.district_id,
    state.name AS state,
    arc.comment,
    arc.begin_lifespan_version,
    arc.end_lifespan_version,
    arc.cat_measurement,
    arc.the_geom
   FROM us_net_el.arc
     LEFT JOIN us_net_el.cat_arc ON cat_arc.id::text = arc.sub_type::text
     LEFT JOIN us_net_el.cat_feature ON cat_arc.arctype_id::text = cat_feature.system_id::text
     LEFT JOIN us_net_el.cat_mat_arc ON cat_mat_arc.id::text = arc.conductive_material::text
     LEFT JOIN us_net_el.state ON state.id = arc.state;


