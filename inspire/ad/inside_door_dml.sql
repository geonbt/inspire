INSERT INTO ad.inside_door(
	id, parent_id)
	
	
	SELECT bagimsizbolum.kimlikno,numarataj.kimlikno
	FROM public.bagimsizbolum
	inner join numarataj ON bagimsizbolum.numaratajid = numarataj.id

	