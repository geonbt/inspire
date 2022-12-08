SET search_path = us_net_el, public, pg_catalog;


CREATE TRIGGER gw_trg_topocontrol_node
    AFTER INSERT OR UPDATE OF the_geom
    ON us_net_el.node
    FOR EACH ROW
    EXECUTE FUNCTION topocontrol_node();
