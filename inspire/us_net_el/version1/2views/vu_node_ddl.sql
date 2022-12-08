SET search_path = us_net_el, public, pg_catalog;

CREATE OR REPLACE VIEW us_net_el.vu_node
 AS
 SELECT node.id,
    node.name,
    cat_feature.system_id AS type,
    cat_node.id AS sub_type,
    cat_mat_node.id AS material,
    cat_sub_mat_node.id AS sub_material,
    node.district_id,
    node.expl_id,
    node.comment,
    node.facility_reference,
    state.name AS state,
    node.elevation,
    node.begin_lifespan_version,
    node.end_lifespan_version,
    node.cat_measurement,
    abone.id AS abone,
    node.the_geom
   FROM us_net_el.node
     LEFT JOIN us_net_el.cat_node ON node.sub_type::text = cat_node.id::text
     LEFT JOIN us_net_el.cat_feature ON cat_node.nodetype_id::text = cat_feature.system_id::text
     LEFT JOIN us_net_el.cat_sub_mat_node ON cat_sub_mat_node.id::text = node.sub_material::text
     LEFT JOIN us_net_el.cat_mat_node ON cat_mat_node.id::text = cat_sub_mat_node.nodemat_id::text
     LEFT JOIN us_net_el.state ON node.state = state.id
     LEFT JOIN us_net_el.abone ON node.id = abone.node_id;