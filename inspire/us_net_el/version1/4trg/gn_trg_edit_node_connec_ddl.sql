SET search_path = us_net_el, public, pg_catalog;

CREATE TRIGGER gn_trg_edit_node_connec
    INSTEAD OF INSERT OR DELETE OR UPDATE 
    ON ve_node_connec
    FOR EACH ROW
    EXECUTE FUNCTION gn_trg_ve_node_connec();
	
	