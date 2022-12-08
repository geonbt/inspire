DROP TABLE IF EXISTS ad.inside_door;
DROP TABLE IF EXISTS ad.outside_door;
DROP TABLE IF EXISTS ad.road_district;
DROP TABLE IF EXISTS ad.address_component;
DROP TABLE IF EXISTS ad.identifier;
DROP TYPE IF EXISTS ad.status_value;


CREATE TYPE ad.status_value AS ENUM(
	'current','retired','proposed','reserved','alternative'
);

CREATE TABLE ad.identifier(
	id		serial primary key
);

CREATE TABLE ad.address_component(
	id 						integer primary key,
	parent_id				integer,
	type					integer,
	alternative_identifier	varchar,
	status_value			ad.status_value,
	valid_from				timestamp without time zone,
	valid_to				timestamp without time zone,
	begin_lisespan_version	timestamp without time zone,
	end_lifespan_version	timestamp without time zone,
	the_geom				geometry(Point,5253)
)INHERITS(ad.identifier);

CREATE TABLE ad.road_district(
	id				integer PRIMARY KEY,
	road_link_id	integer,
	district_id		integer
)INHERITS(ad.address_component);


CREATE TABLE ad.outside_door(
	id					integer PRIMARY KEY,
	construction_id		integer,
	post_number			varchar
)INHERITS(ad.address_component);

CREATE TABLE ad.inside_door(
	id							integer PRIMARY KEY,
	building_unit_id			integer,
	post_number					integer,
	condition_of_construction	integer,
	floor						integer
)INHERITS(ad.address_component);

CREATE TABLE ad.type_road_district(
	id				integer PRIMARY KEY,
	type			varchar
);

CREATE TABLE ad.type_outside_door(
	id			integer PRIMARY KEY,
	type		varchar
);

CREATE TABLE ad.type_inside_door(
	id			integer PRIMARY KEY,
	type		varchar
);

-------------------------------------------- 
ALTER TABLE ad.road_district ADD CONSTRAINT "road_district_district_id_fkey"
	FOREIGN KEY (district_id)
		REFERENCES au.district(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE ad.road_district ADD CONSTRAINT "road_district_road_link_id_fkey"
	FOREIGN KEY (road_link_id)
		REFERENCES tn_ro.road_link(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;
			
ALTER TABLE ad.road_district ADD CONSTRAINT "road_district_type_fkey"
	FOREIGN KEY (type)
		REFERENCES ad.type_road_district(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;
			
ALTER TABLE ad.outside_door ADD CONSTRAINT "outside_door_parent_id_fkey"
	FOREIGN KEY (parent_id)
		REFERENCES ad.road_district(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE ad.outside_door ADD CONSTRAINT "outside_door_type_fkey"
	FOREIGN KEY (type)
		REFERENCES ad.type_outside_door(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;
			
ALTER TABLE ad.inside_door ADD CONSTRAINT "inside_door_parent_id_fkey"
	FOREIGN KEY (parent_id)
		REFERENCES ad.outside_door(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE ad.inside_door ADD CONSTRAINT "inside_door_building_unit_id_fkey"
	FOREIGN KEY (building_unit_id)
		REFERENCES bu.building_unit(id) 
			ON DELETE RESTRICT ON UPDATE CASCADE;
			
ALTER TABLE ad.inside_door ADD CONSTRAINT "inside_door_type_fkey"
	FOREIGN KEY (type)
		REFERENCES ad.type_inside_door(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;
			
ALTER TABLE ad.inside_door ADD CONSTRAINT "inside_door_condition_of_construction_fkey"
	FOREIGN KEY (condition_of_construction)
		REFERENCES bu.condition_of_construction(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;