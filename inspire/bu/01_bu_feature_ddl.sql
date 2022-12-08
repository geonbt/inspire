DROP TABLE IF EXISTS bu.building_unit;
DROP TABLE IF EXISTS bu.construction;
DROP TABLE IF EXISTS bu.date_of_renovation;
DROP TABLE IF EXISTS bu.date_of_demolition;
DROP TABLE IF EXISTS bu.date_of_construction;
DROP TABLE IF EXISTS bu.date_of_event;
DROP TABLE IF EXISTS bu.identifier;
DROP TYPE IF EXISTS bu.construction_type;
--DROP TYPE IF EXISTS bu.feature_types;

-- CREATE TYPE bu.feature_types AS ENUM(
-- 	'abstract_construction','abstract_building','building','building_part'
-- );
CREATE TYPE bu.construction_type AS ENUM(
	'building','building_part','other_construction','additional_construction'
);

CREATE TABLE bu.identifier(
	id			serial PRIMARY KEY
	--namespace	bu.feature_types
);

CREATE TABLE bu.date_of_event(
	id				serial PRIMARY KEY,
	beginning		timestamp without time zone,
	any_point		timestamp without time zone,
	end_of_event	timestamp without time zone
);
CREATE TABLE bu.date_of_construction(
	id			integer PRIMARY KEY
)INHERITS(bu.date_of_event);

CREATE TABLE bu.date_of_demolition(
	id			integer PRIMARY KEY
)INHERITS(bu.date_of_event);

CREATE TABLE bu.date_of_renovation(
	id			integer PRIMARY KEY
)INHERITS(bu.date_of_event);

CREATE TABLE bu.construction(
	id										integer PRIMARY KEY,
	name									varchar,
	parent_id								integer,--aşağıda oluşacak mirasçılar arası bağda kullanılacak.,
	construction_type						bu.construction_type,
	begin_lifespan_version					timestamp without time zone,
	end_lifespan_version					timestamp without time zone,
	condition_of_construction				bu.condition_of_construction_value,
	date_of_construction					integer,--ayrı 
	date_of_demolition						integer,--tablo  (date_of_event)
	date_of_renovation						integer,--yapılacak
	elevation_reference						bu.elevation_reference_value,
	elevation_value							integer,
	height_above_ground_value				integer,
	height_above_ground_height_reference	bu.elevation_reference_value,
	height_above_ground_low_reference		bu.elevation_reference_value,
	building_nature							bu.building_nature_value,
	current_use								varchar,--current_use_value tablosu ile bağlanacak
	number_of_dwellings						integer,
	number_of_building_units				integer,
	number_of_floors_above_ground			integer,
	status									bu.height_status_value,
	the_geom	geometry(MultiPolygon,5253)
)INHERITS(bu.identifier);

CREATE TABLE bu.building_unit(
	id			integer PRIMARY KEY,
	parent_id	integer
)INHERITS(bu.identifier);


---------------------------------------

ALTER TABLE bu.construction ADD CONSTRAINT "construction_date_of_construction_fkey"
	FOREIGN KEY (date_of_construction)
		REFERENCES bu.date_of_construction(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;
			
ALTER TABLE bu.construction ADD CONSTRAINT "construction_date_of_demolition_fkey"
	FOREIGN KEY (date_of_demolition)
		REFERENCES bu.date_of_demolition(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;
			
ALTER TABLE bu.construction ADD CONSTRAINT "construction_date_of_renovation_fkey"
	FOREIGN KEY (date_of_renovation)
		REFERENCES bu.date_of_renovation(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;
			
ALTER TABLE bu.construction ADD CONSTRAINT "constuction_parent_id_fkey"
	FOREIGN KEY (parent_id)
		REFERENCES bu.construction(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;
			
ALTER TABLE bu.building_unit ADD CONSTRAINT "building_part_parent_id_fkey"
	FOREIGN KEY (parent_id)
		REFERENCES bu.construction(id)
			ON DELETE RESTRICT ON UPDATE CASCADE;
---------------------------------------
-- ALTER TABLE bu.abstract_construction ALTER COLUMN namespace SET DEFAULT 'abstract_construction';

-- ALTER TABLE bu.abstract_construction ADD CONSTRAINT "abstract_construction_namespace_check" CHECK (namespace = 'abstract_construction');

-- ALTER TABLE bu.abstract_building ALTER COLUMN namespace SET DEFAULT 'abstract_building';

-- ALTER TABLE bu.abstract_building ADD CONSTRAINT "abstract_building_namespace_check" CHECK (namespace = 'abstract_building');

-- ALTER TABLE bu.building ALTER COLUMN namespace SET DEFAULT 'building';

-- ALTER TABLE bu.building ADD CONSTRAINT "building_namespace_check" CHECK (namespace = 'building');

-- ALTER TABLE bu.building_part ALTER COLUMN namespace SET DEFAULT 'building_part';

-- ALTER TABLE bu.building_part ADD CONSTRAINT "building_part_namespace_check"	CHECK (namespace = 'building_part');
