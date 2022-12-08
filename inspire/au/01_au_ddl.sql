DROP TABLE IF EXISTS au.district;
DROP TABLE IF EXISTS au.municipality;
DROP TABLE IF EXISTS au.administrative_unit;
DROP TYPE IF EXISTS au.administrative_hierarchy_level;
DROP TABLE IF EXISTS au.identifier;
DROP TABLE IF EXISTS au.feature_types;

-- CREATE TYPE au.feature_types as ENUM(
-- 	'administrative_unit'
-- );

CREATE TABLE au.identifier(
	id			integer primary key
-- 	namespace	au.feature_types
);

CREATE TYPE au.administrative_hierarchy_level AS ENUM(
	'ilce','belediye','mahalle'
);

CREATE TABLE au.administrative_unit(
	id						integer PRIMARY KEY,
	name 					varchar,
	national_level			au.administrative_hierarchy_level,
	begin_lifespan_version	timestamp without time zone,
	end_lifespan_version	timestamp without time zone,
	parent_id				integer,
	the_geom				geometry(MultiPolygon)
	
)INHERITS(au.identifier);

CREATE TABLE au.municipality(
	id integer PRIMARY KEY
)INHERITS(au.administrative_unit);

CREATE TABLE au.district(
	id	integer PRIMARY KEY
)INHERITS(au.administrative_unit);

ALTER TABLE au.district ADD CONSTRAINT "district_parent_id_fkey" 
	FOREIGN KEY (parent_id)
		REFERENCES au.municipality(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;

-- ALTER TABLE au.administrative_unit ALTER COLUMN namespace SET DEFAULT 'administrative_unit';

-- ALTER TABLE au.administrative_unit ADD CONSTRAINT "administrative_unit_namespace_check" CHECK (namespace='administrative_unit');

ALTER TABLE au.municipality ALTER COLUMN national_level SET DEFAULT 'ilce';

ALTER TABLE au.municipality ADD CONSTRAINT "municipality_national_level_check" CHECK (national_level= 'ilce');

ALTER TABLE au.district ALTER COLUMN national_level SET DEFAULT 'mahalle';

ALTER TABLE au.district ADD CONSTRAINT "district_national_level_check" CHECK (national_level='mahalle');

