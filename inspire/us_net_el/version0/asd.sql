CREATE OR REPLACE FUNCTION ws.get_address_f(sayi int)
RETURNS TABLE
(
	get_address	json
)
AS
$$
begin
	RETURN QUERY
	SELECT json_build_object(get_address.mahalle, 
					get_address.sokak,
					get_address.no, 
					get_address.ilce)
	FROM ws.get_address WHERE id = sayi;
end;
$$
LANGUAGE plpgsql;

  drop function ws.get_address_f


select ws.get_address_f(100098474)

