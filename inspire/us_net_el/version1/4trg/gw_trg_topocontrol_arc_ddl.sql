SET search_path = us_net_el, public, pg_catalog;

CREATE TRIGGER gw_trg_topocontrol_arc
    BEFORE INSERT OR UPDATE OF the_geom
    ON us_net_el.arc
    FOR EACH ROW
    EXECUTE FUNCTION us_net_el.topocontrol_arc();