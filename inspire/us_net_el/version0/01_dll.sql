DROP TABLE IF EXISTS us_net_el.link;
DROP TABLE IF EXISTS us_net_el.node;
DROP TABLE IF EXISTS us_net_el.electricity_element;
DROP TABLE IF EXISTS us_net_el.node_function_type_value;
DROP TABLE IF EXISTS us_net_el.node_sub_material_type_value;
DROP TABLE IF EXISTS us_net_el.node_material_type_value;
DROP TABLE IF EXISTS us_net_el.node_type_value;
DROP TABLE IF EXISTS us_net_el.facility_reference_type_value;
DROP TABLE IF EXISTS us_net_el.vertical_position_type_value;
DROP TABLE IF EXISTS us_net_el.identifier;

CREATE TABLE us_net_el.identifier(
	id			serial PRIMARY KEY
);

CREATE TABLE us_net_el.electricity_element(
	id						integer PRIMARY KEY,
	begin_lifespan_version	timestamp without time zone,
	end_lifespan_version	timestamp without time zone,
	vertical_position		integer,--code list
	facility_reference		integer--code_list
)INHERITS(us_net_el.identifier);

CREATE TABLE us_net_el.link(
	id						integer PRIMARY KEY,
	start_node				integer,--node id foreign
	end_node				integer,--node if foreign
	operating_voltage		integer,
	nominal_voltage			integer,
	the_geom				geometry(MultiLineString,5253)
)INHERITS(us_net_el.electricity_element);

CREATE TABLE us_net_el.node(
	id						integer PRIMARY KEY,
	type					varchar,
	material				varchar,
	sub_material			varchar,
	function				varchar,
	elevation 				integer,
	length					integer,
	the_geom				geometry(Point,5253)
)INHERITS(us_net_el.electricity_element);

CREATE TABLE us_net_el.vertical_position_type_value(
	id						integer PRIMARY KEY,
	type_value				varchar				
);

CREATE TABLE us_net_el.facility_reference_type_value(
	id						integer PRIMARY KEY,
	type_value				varchar
);

CREATE TABLE us_net_el.node_type_value(
	id						integer,
	type_value				varchar PRIMARY KEY
);

CREATE TABLE us_net_el.node_material_type_value(
	id						integer,
	type_value				varchar PRIMARY KEY
);

CREATE TABLE us_net_el.node_sub_material_type_value(
	id						integer,
	type_value				varchar PRIMARY KEY
);

CREATE TABLE us_net_el.node_function_type_value(
	id						integer,
	type_value				varchar PRIMARY KEY
);


ALTER TABLE us_net_el.electricity_element ADD CONSTRAINT "electricity_element_vertical_position_fkey"
	FOREIGN KEY (vertical_position)
		REFERENCES us_net_el.vertical_position_type_value(id)
			ON UPDATE CASCADE
       		ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.electricity_element ADD CONSTRAINT "electricity_element_facility_reference_fkey"
	FOREIGN KEY (facility_reference)
		REFERENCES us_net_el.facility_reference_type_value(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.link ADD CONSTRAINT "link_start_node_fkey"
	FOREIGN KEY (start_node)
		REFERENCES us_net_el.node(id)
			ON UPDATE CASCADE
       		ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.link ADD CONSTRAINT "link_end_node_fkey"
	FOREIGN KEY (end_node)
		REFERENCES us_net_el.node(id)
			ON UPDATE CASCADE
       		ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.node ADD CONSTRAINT "node_type_fkey"
	FOREIGN KEY (type)
		REFERENCES us_net_el.node_type_value(type_value)
			ON UPDATE CASCADE
       		ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.node ADD CONSTRAINT "node_material_fkey"
	FOREIGN KEY (material)
		REFERENCES us_net_el.node_material_type_value(type_value)
			ON UPDATE CASCADE
       		ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.node ADD CONSTRAINT "node_sub_material_fkey"
	FOREIGN KEY (sub_material)
		REFERENCES us_net_el.node_sub_material_type_value(type_value)
			ON UPDATE CASCADE
       		ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.node ADD CONSTRAINT "node_function_fkey"
	FOREIGN KEY (function)
		REFERENCES us_net_el.node_function_type_value(type_value)
			ON UPDATE CASCADE
       		ON DELETE RESTRICT;