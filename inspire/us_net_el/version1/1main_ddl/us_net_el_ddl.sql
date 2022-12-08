-- SET search_path = us_net_el, public, pg_catalog;

DROP TABLE IF EXISTS us_net_el.man_pole;
DROP TABLE IF EXISTS us_net_el.man_transformer;
DROP TABLE IF EXISTS us_net_el.man_connec;
DROP TABLE IF EXISTS us_net_el.arc ;
DROP TABLE IF EXISTS us_net_el.abone;
DROP TABLE IF EXISTS us_net_el.node;
DROP TABLE IF EXISTS us_net_el.cat_node;
DROP TABLE IF EXISTS us_net_el.cat_arc;
DROP TABLE IF EXISTS us_net_el.cat_feature;
DROP TABLE IF EXISTS us_net_el.cat_sub_mat_node;
DROP TABLE IF EXISTS us_net_el.cat_mat_node;
DROP TABLE IF EXISTS us_net_el.cat_mat_arc;
DROP TABLE IF EXISTS us_net_el.selector_expl;
DROP TABLE IF EXISTS us_net_el.selector_state;
DROP TABLE IF EXISTS us_net_el.exploitation;
DROP TABLE IF EXISTS us_net_el.district;
DROP TABLE IF EXISTS us_net_el.state;
DROP SEQUENCE IF EXISTS us_net_el.identifier_id_seq;
DROP SEQUENCE IF EXISTS us_net_el.abone_id_seq;



CREATE  SEQUENCE us_net_el.identifier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
CREATE SEQUENCE us_net_el.abone_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	

CREATE TABLE us_net_el.cat_feature
(
	system_id				varchar PRIMARY KEY,				
	feature_type			varchar
);
CREATE TABLE us_net_el.cat_node(
	id						varchar PRIMARY KEY,
	nodetype_id				varchar
);

CREATE TABLE us_net_el.cat_arc(
	id						varchar PRIMARY KEY,
	arctype_id				varchar
);
	
CREATE TABLE us_net_el.cat_mat_node(
	id						varchar PRIMARY KEY
);

CREATE TABLE us_net_el.cat_mat_arc(
	id						varchar PRIMARY KEY
);

CREATE TABLE us_net_el.cat_sub_mat_node(
	id						varchar PRIMARY KEY,
	nodemat_id				varchar 
);

CREATE TABLE us_net_el.exploitation(
	id						integer PRIMARY KEY,
	name					varchar,
	the_geom				geometry(MultiPolygon,5253)
);

CREATE TABLE us_net_el.district(
	id						integer PRIMARY KEY,
	name					varchar,
	the_geom				geometry(MultiPolygon,5253)
);

CREATE TABLE us_net_el.state(
	id						integer PRIMARY KEY,
	name					varchar,
	CONSTRAINT value_state_check CHECK (id = ANY (ARRAY[0, 1, 2]))
);

CREATE TABLE us_net_el.man_connec(
	node_id					integer PRIMARY KEY
);

CREATE TABLE us_net_el.man_transformer(
	node_id					integer PRIMARY KEY,
	power					numeric(10,2)
);

CREATE TABLE us_net_el.man_pole(
	node_id					integer PRIMARY KEY,
	length					 numeric(10,2)
);

CREATE TABLE us_net_el.node(
	id						integer DEFAULT nextval('us_net_el.identifier_id_seq'::regclass) NOT NULL,
	name					varchar,
	sub_type				varchar,
	sub_material			varchar,
	elevation				integer,
	facility_reference		integer,--code_list
	state					integer,
	comment					text,
	expl_id					integer,
	district_id				integer,
	insert_user				varchar DEFAULT CURRENT_USER,
	begin_lifespan_version	timestamp without time zone,
	end_lifespan_version	timestamp without time zone,
	cat_measurement			varchar,
	the_geom				geometry(Point,5253),
	CONSTRAINT node_pk PRIMARY KEY (id)
);


CREATE TABLE us_net_el.arc(
	id						integer DEFAULT nextval('us_net_el.identifier_id_seq'::regclass) NOT NULL,
	start_node				integer,--node id foreign
	end_node				integer,--node if foreign
	sub_type				varchar,
	conductive_material		varchar,
	operating_voltage		integer,
	nominal_voltage			integer,
	facility_reference		integer,--code_list
	state					integer,
	comment					text,
	expl_id					integer,
	district_id				integer,
	insert_user				varchar DEFAULT CURRENT_USER,
	begin_lifespan_version	timestamp without time zone,
	end_lifespan_version	timestamp without time zone,
	cat_measurement			varchar,
	the_geom				geometry(MultiLineString,5253),
	CONSTRAINT arc_pk PRIMARY KEY (id)
);

CREATE TABLE us_net_el.abone(
	id 						integer DEFAULT nextval('us_net_el.abone_id_seq'::regclass)  NOT NULL,
	abone_no				integer,
	sayac_no				integer,
	sozlesme_gucu			integer,
	kurulu_guc				integer,
	tuketim_kwh				integer,
	tarife_turu				varchar,
	node_id					integer,
	CONSTRAINT abone_id_pk PRIMARY KEY (id)
);

CREATE TABLE us_net_el.selector_state(
	id						integer NOT NULL,
	cur_user				varchar NOT NULL DEFAULT CURRENT_USER
);

CREATE TABLE us_net_el.selector_expl(
	id						integer NOT NULL,
	cur_user				varchar NOT NULL DEFAULT CURRENT_USER
);


--katalog
ALTER TABLE us_net_el.cat_node ADD CONSTRAINT "cat_node_nodetype_id_fkey"
	FOREIGN KEY (nodetype_id)
		REFERENCES us_net_el.cat_feature(system_id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.cat_arc ADD CONSTRAINT "cat_arc_arctype_id_fkey"
	FOREIGN KEY (arctype_id)
		REFERENCES us_net_el.cat_feature(system_id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.cat_sub_mat_node ADD CONSTRAINT "cat_sub_mat_nodemat_id_fkey"
	FOREIGN KEY (nodemat_id)
		REFERENCES us_net_el.cat_mat_node(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
--node

ALTER TABLE us_net_el.node ADD CONSTRAINT "node_sub_type_value"
	FOREIGN KEY (sub_type)
		REFERENCES us_net_el.cat_node(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;

ALTER TABLE us_net_el.node ADD CONSTRAINT "node_sub_mat_fkey"
	FOREIGN KEY(sub_material)
		REFERENCES us_net_el.cat_sub_mat_node(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.node ADD CONSTRAINT "node_expl_id_fkey"
	FOREIGN KEY (expl_id)
		REFERENCES us_net_el.exploitation(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;

ALTER TABLE us_net_el.node ADD CONSTRAINT "node_district_id_fkey"
	FOREIGN KEY (district_id)
		REFERENCES us_net_el.district(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.node ADD CONSTRAINT "node_state_fkey"
	FOREIGN KEY (state)
		REFERENCES us_net_el.state(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.node ADD CONSTRAINT	"node_cat_measurement_fkey"
	FOREIGN KEY (cat_measurement)
		REFERENCES bohyy.cat_measurement(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
--ARC
ALTER TABLE us_net_el.arc ADD CONSTRAINT "arc_start_node_fkey"
	FOREIGN KEY(start_node)
		REFERENCES us_net_el.node(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.arc ADD CONSTRAINT "arc_end_node_fkey"
	FOREIGN KEY(end_node)
		REFERENCES us_net_el.node(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.arc ADD CONSTRAINT "arc_sub_type_fkey"
	FOREIGN KEY(sub_type)
		REFERENCES us_net_el.cat_arc(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;

ALTER TABLE us_net_el.arc ADD CONSTRAINT "arc_conductive_material_fkey"
	FOREIGN KEY(conductive_material)
		REFERENCES us_net_el.cat_mat_arc(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;

ALTER TABLE us_net_el.arc ADD CONSTRAINT "arc_expl_id_fkey"
	FOREIGN KEY (expl_id)
		REFERENCES us_net_el.exploitation(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.arc ADD CONSTRAINT "arc_district_id_fkey"
	FOREIGN KEY (district_id)
		REFERENCES us_net_el.district(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.arc ADD CONSTRAINT "arc_cat_measurement_fkey"
	FOREIGN KEY (cat_measurement)
		REFERENCES bohyy.cat_measurement(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
---ABONE

ALTER TABLE us_net_el.abone ADD CONSTRAINT "abone_node_id_fkey"
	FOREIGN KEY (node_id)
		REFERENCES us_net_el.node(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
---SELECTORS

ALTER TABLE us_net_el.selector_state ADD CONSTRAINT "selector_state_id_fkey"
	FOREIGN KEY (id)
		REFERENCES us_net_el.state(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.selector_expl ADD CONSTRAINT "selector_expl_id_fkey"
	FOREIGN KEY (id)
		REFERENCES us_net_el.exploitation (id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
--- Man tables

ALTER TABLE us_net_el.man_connec ADD CONSTRAINT "man_connec_node_id_fkey"
	FOREIGN KEY (node_id)
		REFERENCES us_net_el.node(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.man_transformer ADD CONSTRAINT "man_transformer_node_id_fkey"
	FOREIGN KEY (node_id)
		REFERENCES us_net_el.node(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;
			
ALTER TABLE us_net_el.man_pole ADD CONSTRAINT "man_pole_node_id_fkey"
	FOREIGN KEY (node_id)
		REFERENCES us_net_el.node(id)
			ON UPDATE CASCADE
        	ON DELETE RESTRICT;