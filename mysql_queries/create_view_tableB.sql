create view tableB as 
select host.host as hostname, host.ip as host_ip, host.dns as host_dns, host.port as host_port, docker_name.docker_name as docker_name,
IF(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1)='Docker','Docker',  info.value) as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value
from items i, history_uint h, info, host, docker_name
where i.itemid=h.itemid and i.hostid =host.hostid and i.hostid =docker_name.hostid
and (i.name = 'Docker: Containers paused' or  i.name ='Docker: Containers running'
or i.name= 'Docker: Containers stopped' or i.name= 'Docker: Containers total'
or (i.name regexp '^(Container /mesos)' and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name))