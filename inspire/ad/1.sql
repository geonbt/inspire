INSERT INTO ad.outside_door(
	id, parent_id, construction_id, post_number)
	
	SELECT  numarataj.kimlikno, yolyon.kimlikno, yapi.kimlikno, kapino
	FROM public.numarataj
	LEFT JOIN public.yolyon ON numarataj.yolortahatyonid = yolyon.id
	LEFT JOIN public.yapi ON numarataj.yapiid = yapi.id
	
	
	
	