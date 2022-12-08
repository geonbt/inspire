SET search_path = us_net_el, public, pg_catalog;

CREATE TRIGGER gn_trg_edit_arc
    INSTEAD OF INSERT OR DELETE OR UPDATE 
    ON v_edit_arc
    FOR EACH ROW
    EXECUTE FUNCTION gn_trg_v_edit_arc();
	
	