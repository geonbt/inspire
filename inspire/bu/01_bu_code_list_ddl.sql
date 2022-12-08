DROP TABLE IF EXISTS bu.commerce_and_services;
DROP TABLE IF EXISTS bu.collective_residence;
DROP TABLE IF EXISTS bu.residential;
DROP TABLE IF EXISTS bu.current_use_value;
DROP TYPE IF EXISTS bu.horizontal_geometry_references_value;
DROP TYPE IF EXISTS bu.elevation_reference_value;
DROP TYPE IF EXISTS bu.height_status_value;
DROP TYPE IF EXISTS bu.condition_of_construction_value;
DROP TYPE IF EXISTS bu.building_nature_value;

CREATE TYPE bu.building_nature_value AS ENUM(
	'arch','bunker','canopy','castle','cave_building','chapel','church','dam',
	'greenhouse','lighthouse','mosque','shed','silo','stadium','storage_tank',
	'synagogue','temple','tower','windmill','wind_turbine'
);


CREATE TYPE bu.condition_of_construction_value AS ENUM(
	'declined','demolished','functional','projected','ruin','under construction'
);

CREATE TYPE bu.height_status_value AS ENUM(
	'estimated','measured'
);

CREATE TYPE bu.elevation_reference_value AS ENUM(
	'above_ground_envelope','bottom_of_construction','entrance_point','general_eave',
	'general_ground','general_roof','general_roof_edge','highest_eave','highest_ground_point',
	'highest_point','highest_roof_edge','lowest_eave','lowest_floor_above_ground',
	'lowest_ground_point','lowest_roof_edge','top_of_construction'
);

CREATE TYPE bu.horizontal_geometry_references_value AS ENUM(
	'above_ground_envelope','combined','entrance_point','envelope','footprint',
	'lower_floor_above_ground','point_inside_building','point_inside_cadastral_parcel',
	'roof_edge'
);

-- CREATE TABLE bu.current_use_value(
-- 	id 			serial PRIMARY KEY,
-- 	name		varchar,
-- 	parent_id	integer
-- );

-- CREATE TABLE bu.residential(
-- 	id		integer PRIMARY KEY,
-- 	name	varchar
-- )INHERITS(bu.current_use_value);

-- CREATE TABLE bu.collective_residence(
-- 	id 		integer PRIMARY KEY,
-- 	name	varchar
-- )INHERITS(bu.residential);

-- CREATE TABLE bu.commerce_and_services(
-- 	id integer PRIMARY KEY,
-- 	name varchar
-- )INHERITS(bu.current_use_value);

-- ALTER TABLE bu.residential ADD CONSTRAINT "residential_id_fkey"
-- 	FOREIGN KEY (parent_id)
-- 		REFERENCES bu.current_use_value(id)
-- 			ON DELETE RESTRICT ON UPDATE CASCADE;

-- ALTER TABLE bu.collective_residence ADD CONSTRAINT "collective_residence_id_fkey"
-- 	FOREIGN KEY (parent_id)
-- 		REFERENCES bu.residential(id)
-- 			ON DELETE RESTRICT ON UPDATE CASCADE;

-- ALTER TABLE bu.commerce_and_services ADD CONSTRAINT "commerce_and_services_id_fkey"
-- 	FOREIGN KEY (parent_id)
-- 		REFERENCES bu.current_use_value(id)
-- 			ON DELETE RESTRICT ON UPDATE CASCADE;



-- ALTER TABLE bu.current_use_value RENAME TO current_user_value_old;

-- CREATE TABLE bu.current_use_value (
-- 	id 			serial PRIMARY KEY,
-- 	name		varchar,
-- 	parent_id	integer
-- );

-- INSERT INTO bu.current_use_value SELECT * FROM bu.current_user_value_old
-- DROP TABLE bu.current_use_value_old

select * from bu.current_use_value
