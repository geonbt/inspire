SET search_path = us_net_el, public, pg_catalog;

CREATE OR REPLACE FUNCTION topocontrol_arc()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE 
startNode	Record;
endNode		Record;
o			Record;
BEGIN
	SET search_path = us_net_el, public, pg_catalog;

	
	SELECT * INTO startNode FROM node WHERE node.the_geom && ST_Expand(ST_StartPoint(NEW.the_geom),0.5)
	ORDER BY ST_Distance(node.the_geom,ST_StartPoint(NEW.the_geom)) LIMIT 1;
	
	SELECT * INTO endNode FROM node WHERE node.the_geom && ST_Expand(ST_EndPoint(NEW.the_geom),0.5)
	ORDER BY ST_Distance(node.the_geom,ST_EndPoint(NEW.the_geom)) LIMIT 1;
	
	FOR O IN SELECT start_node,end_node FROM arc
	LOOP
		IF startNode.id = o.start_node AND endNode.id = o.end_node THEN
			RAISE EXCEPTION 'BASLANGIC VE BITIS NOKTALARI AYNI BIR VEYA DAHA FAZLA HAT OLAMAZ!';
		ELSIF startNode.id = o.end_node AND endNode.id = o.start_node THEN
			RAISE EXCEPTION 'BASLANGIC VE BITIS NOKTALARI AYNI BIR VEYA DAHA FAZLA HAT OLAMAZ!';
		END IF;
	END LOOP;
	
	IF(startNode.id IS NOT NULL) AND (endNode.id IS NOT NULL) THEN
		IF (startNode.id = endNode.id) THEN
			RAISE EXCEPTION 'Baslangic ve bitis noktaları ayni olamaz, projenizi kontrol edin!';
		ELSE
			NEW.the_geom := ST_SetPoint(NEW.the_geom,0,startNode.the_geom);
			NEW.the_geom := ST_SetPoint(NEW.the_geom,ST_NumPoints(NEW.the_geom) - 1,endNode.the_geom);
			NEW.start_node := startNode.id;
			NEW.end_node := endNode.id;
			RETURN NEW; 
		END IF;
	ELSE
		RAISE EXCEPTION 'Baslangic ve bitis noktalari olmak zorunda, projenizi kontrol edin!(%)',ST_StartPoint(NEW.the_geom);
		RETURN NULL;
	END IF;
END
$BODY$;

ALTER FUNCTION us_net_el.topocontrol_arc()
    OWNER TO postgres;



