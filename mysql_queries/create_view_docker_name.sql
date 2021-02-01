create view docker_name as 
select distinct i.hostid as hostid, h.value as docker_name
from items i inner join history_str h on i.itemid=h.itemid
where i.name = 'Docker: Name'