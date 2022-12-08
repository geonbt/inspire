SET search_path = us_net_el, public, pg_catalog;


CREATE OR REPLACE VIEW v_state_arc
	AS
	SELECT
		arc.id
	FROM
		selector_expl,
		selector_state,
		arc
	WHERE
		selector_expl.id = arc.expl_id
	AND	
		selector_state.id = arc.state
	AND
		selector_state.cur_user = "current_user"()::text
	AND 
		selector_expl.cur_user = "current_user"()::text