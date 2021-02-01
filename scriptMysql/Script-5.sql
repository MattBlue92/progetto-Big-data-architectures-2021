use zabbix;

ALTER TABLE items  ADD FULLTEXT(name);
ALTER TABLE history_text ADD FULLTEXT(value);


create or replace view host as 
select h.hostid as hostid, h.host as host, id.ip as ip
from hosts h inner join  interface id  on h.hostid = id.hostid;


create or replace view info as (
select distinct SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1) as name, h.value
from items i inner join  history_text h on h.itemid=i.itemid
where i.name like  CONCAT('%','MarathonAppId') and h.value != 'unknown');


# container metric views

create or replace view CPU_kernelmode_usage_per_second as 
select host.host as hostname, host.ip as host_ip, info.value as container,
REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1), 'Container /mesos-', '') as mesos_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name like  CONCAT('Container /mesos' ,'%','CPU kernelmode usage per second')
and i.name like CONCAT(info.name, ':%')
and i.itemid=h.itemid and i.hostid =host.hostid;

select * from CPU_kernelmode_usage_per_second ckups ;