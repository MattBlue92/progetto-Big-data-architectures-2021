create view host as 
select h.hostid as hostid, h.host as host, id.ip as ip, id.dns as dns, id.port as port
from hosts h inner join  interface id  on h.hostid = id.hostid