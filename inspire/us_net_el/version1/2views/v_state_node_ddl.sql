SET search_path = us_net_el, public, pg_catalog;


CREATE OR REPLACE VIEW v_state_node
	AS
	SELECT
		node.id
	FROM
		selector_state,
		selector_expl,
		node
	WHERE selector_state.id = node.state 
	AND 
		selector_expl.id = node.expl_id 
	AND 
		selector_state.cur_user = "current_user"()::text 
	AND 
		selector_expl.cur_user = "current_user"()::text