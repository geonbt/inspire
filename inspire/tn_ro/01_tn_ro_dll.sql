DROP TABLE IF EXISTS tn_ro.road_link;
DROP TABLE IF EXISTS tn_ro.road;
DROP TABLE IF EXISTS tn_ro.identifier;

CREATE TABLE tn_ro.identifier(
	id						serial PRIMARY KEY
);
CREATE TABLE tn_ro.road(
	id 						integer PRIMARY KEY,
	name					varchar,
	begin_lifespan_version	timestamp without time zone,
	end_lifespan_version	timestamp without time zone
)INHERITS(tn_ro.identifier);

CREATE TABLE tn_ro.road_link(
	id						serial PRIMARY KEY,
	name					varchar,
	road_id					integer,
	begin_lifespan_version	timestamp without time zone,
	end_lifespan_version	timestamp without time zone,
	the_geom				geometry(MultiLineString,5253)
);

ALTER TABLE tn_ro.road_link ADD CONSTRAINT "road_link_road_id_fkey"
	FOREIGN KEY (road_id)
		REFERENCES tn_ro.road(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;

