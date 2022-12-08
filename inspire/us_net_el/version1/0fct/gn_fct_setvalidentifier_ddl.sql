SET search_path = us_net_el, public, pg_catalog;


CREATE OR REPLACE FUNCTION gn_fct_setvalidentifier()
	RETURNS bigint
	LANGUAGE 'plpgsql'
	COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE 

v_max int8;

BEGIN
	
	SET search_path = us_net_el, public, pg_catalog;

	SELECT GREATEST (
		(SELECT max(id::int8) FROM node WHERE id ~ '^\d+$'),
		(SELECT max(id::int8) FROM arc WHERE id ~ '^\d+$')
	) INTO v_max;
	 
	RETURN v_max;

END;
$BODY$;
	