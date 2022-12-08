--------idari
CREATE OR REPLACE VIEW ws.v_municipality
AS
SELECT id,name,national_level FROM au.municipality;

CREATE OR REPLACE VIEW ws.v_district
AS
SELECT id,name,national_level,
get_json('ws.v_municipality', 'id', district.parent_id, false)::json AS ilce
FROM au.district;
---------yol
CREATE OR REPLACE VIEW ws.v_road_link
AS
SELECT id,name
FROM tn_ro.road_link;

----------------building
CREATE OR REPLACE VIEW ws.v_building
AS
SELECT id,name FROM bu.building;

CREATE OR REPLACE VIEW ws.v_other_construction
AS
SELECT id, name FROM bu.other_construction;
--------------adres

CREATE OR REPLACE VIEW ws.v_road_district
AS
SELECT id,
get_json('ws.v_road_link', 'id', coalesce(road_district.road_link_id,0), false)::json as yol,
get_json('ws.v_district', 'id', coalesce(road_district.district_id,0), false)::json as mahalle
FROM ad.road_district;

CREATE OR REPLACE VIEW ws.v_outside_door
AS
SELECT id,post_number,
get_json('ws.v_road_district','id',outside_door.parent_id,false)::json as road_district,
get_json('ws.v_building','id',coalesce(outside_door.construction_id,0),false)::json as building,
get_json('ws.v_other_construction','id',coalesce(outside_door.construction_id,0),false)::json as other_construction
FROM ad.outside_door ;

select * from ws.v_outside_door limit 10

select get_json('ws.v_outside_door', 'id', 189407380, false)::json as adres



 


