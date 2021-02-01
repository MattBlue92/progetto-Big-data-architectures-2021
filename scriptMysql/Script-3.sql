use zabbix;
create or replace view host as 
select h.hostid as hostid, h.host as host, id.ip as ip
from hosts h inner join  interface id  on h.hostid = id.hostid;


create or replace view info as (select distinct SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1) as name, h.value
from items i inner join  history_text h on h.itemid=i.itemid
where SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1)=' MarathonAppId' and h.value != 'unknown');



# container metric views

create or replace view Finished_at as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( Finished at)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Started_at as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( Started at)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view CPU_kernelmode_usage_per_second as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( CPU kernelmode usage per second)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;



create or replace view Throttled_time as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( Throttled time)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view CPU_total_usage_per_second as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( CPU total usage per second)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view CPU_usermode_usage_per_second as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( CPU usermode usage per second)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Networks_bytes_received_per_second as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( Networks bytes received per second)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;


create or replace view Networks_incoming_packets_dropped_per_second as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( Networks incoming packets dropped per second)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Networks_errors_received_per_second as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( Networks errors received per second)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view  Networks_packets_received_per_second as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( Networks packets received per second)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view  Networks_bytes_sent_per_second as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( Networks bytes sent per second)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view  Networks_outgoing_packets_dropped_per_second as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( Networks outgoing packets dropped per second)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view  Networks_errors_sent_per_second as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( Networks errors sent per second)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view  Networks_packets_sent_per_second as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( Networks packets sent per second)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Memory_maximum_usage as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '( Memory maximum usage)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Restart_count as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '( Restart count)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Dead as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '( Dead)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view OMKilled as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(OMKilled)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Paused as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(Paused)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Pid as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(Pid)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Running as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(Running)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Throttled_periods as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(Throttled periods)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Restarting as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(Restarting)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Throttling_periods as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(Throttling periods)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Memory_commit_bytes as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(Memory commit bytes)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Memory_commit_peak_bytes as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(Memory commit peak bytes)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Memory_maximum_usage as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(Memory maximum usage)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Memory_private_working_set as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(Memory private working set)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Memory_usage as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(Memory usage)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view Online_CPUs as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where (i.name regexp '^(Container /mesos)' and  i.name regexp '(Online CPUs)$' 
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name)
and i.itemid=h.itemid and i.hostid =host.hostid;


create or replace view Error as 
select host.host as hostname, host.ip as host_ip, info.value as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i,  history_str h, info, host
where i.name regexp '^(Container /mesos)'  and i.name regexp '( Error)$'
and SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1)=info.name 
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view DockerPaused as 
select host.host as hostname, host.ip as host_ip, 'Docker' as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where i.name = 'Docker: Containers paused'
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view DockerRunning as 
select host.host as hostname, host.ip as host_ip, 'Docker' as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where i.name = 'Docker: Containers running'
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view DockerStopped as 
select host.host as hostname, host.ip as host_ip, 'Docker' as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value
from items i, history_uint h, info, host
where i.name = 'Docker: Containers stopped'
and i.itemid=h.itemid and i.hostid =host.hostid;

create or replace view DockerTotal as 
select host.host as hostname, host.ip as host_ip, 'Docker' as container,
SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, 'S', 2), 'S', -1), ':', 1), ':', -1) as instance_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1) as metrics,
from_unixtime(h.clock) as time, h.value as value 
from items i, history_uint h, info, host
where i.name = 'Docker: Containers total'
and i.itemid=h.itemid and i.hostid =host.hostid;









