drop table if exists au.municipality_data;
drop table if exists au.district_data;
create table au.municipality_data(
	id			integer primary key,
	name		varchar,
	the_geom	geometry(MultiPolygon,5253)
);

create table au.district_data(
	id			integer primary key,
	name		varchar,
	parent_id	integer,
	the_geom	geometry(MultiPolygon,5253)
);

select * from au.identifier
insert into au.municipality (id,name,the_geom) select id,name,the_geom from au.municipality_data;

insert into au.district (id,name,parent_id,the_geom) select id,name,parent_id,the_geom from au.district_data;

select * from au.administrative_unit where upper_level_unit = 1462 or id = 1462 order by id


SELECT * FROM pg_attribute WHERE attrelid = 'au.administrative_unit'::regclass;
