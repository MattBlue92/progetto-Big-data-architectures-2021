use zabbix;
ALTER TABLE items ADD FULLTEXT(name);
ALTER TABLE history_text ADD FULLTEXT(value);
ALTER TABLE history ADD INDEX(clock);
ALTER TABLE history_uint ADD INDEX(clock);

#access as root or config file mysqld.cnf
#SET GLOBAL event_scheduler = ON;
#SET GLOBAL event_scheduler = 1;


DELIMITER //

CREATE PROCEDURE createHost()
BEGIN
	drop table if exists host;
	drop view if exists host;
	create table host
		select h.hostid as hostid, h.host as host, id.ip as ip
		from hosts h inner join  interface id  on h.hostid = id.hostid;
	alter table host add primary key (hostid);
END //

DELIMITER ;

CREATE EVENT create_host_event ON SCHEDULE EVERY 1 SECOND
DO
	CALL createHost();


DELIMITER //

CREATE PROCEDURE createInfo()
BEGIN
	drop view if exists info;
	drop table if exists info;
	create table info
		select distinct
		CONCAT(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1), ':%') as name,
		REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1), 'Container /mesos-', '') as mesos_id,
		h.value as value
		from items i inner join  history_text h on h.itemid=i.itemid
		where i.name like  CONCAT('%','MarathonAppId') and h.value not like 'unknown';
	alter table info add primary key (name);
    alter table info add fulltext(name);
END //

DELIMITER ;

CREATE EVENT create_info_event ON SCHEDULE EVERY 1 SECOND
DO
	CALL createInfo();


SELECT SLEEP(15);



create or replace view containerCPU as 
select host.host as hostname, host.ip as host_ip, info.value as container,
info.mesos_id as mesos_id, i.name as name, h.clock as clock, h.value as value_CPU
from items i,  history h, info, host
where i.itemid=h.itemid and i.hostid =host.hostid
and i.name like 'Container /mesos%CPU total usage per second' and i.name like info.name;



create or replace view containerNetworkIO_Sent as 
select host.host as hostname, host.ip as host_ip, info.value as container,
info.mesos_id as mesos_id, i.name as name, h.clock as clock, h.value as value_NET_IO_Sent
from items i,  history h, info, host
where i.itemid=h.itemid and i.hostid =host.hostid
and i.name like 'Container /mesos%Networks bytes sent per second' and i.name like info.name;


create or replace view containerNetworkIO_Received as 
select host.host as hostname, host.ip as host_ip, info.value as container,
info.mesos_id as mesos_id, i.name as name, h.clock as clock, h.value as value_NET_IO_Received
from items i,  history h, info, host
where i.itemid=h.itemid and i.hostid =host.hostid
and i.name like 'Container /mesos%Networks bytes received per second' and i.name like info.name;


create or replace view containerRAM as 
select host.host as hostname, host.ip as host_ip, info.value as container,
info.mesos_id as mesos_id, i.name as name, h.clock as clock, h.value as value_RAM
from items i, history_uint h, info, host
where i.itemid=h.itemid and i.hostid =host.hostid 
and i.name like 'Container /mesos%Memory usage' and i.name like info.name;





create or replace view containerError as 
select host.host as hostname, host.ip as host_ip, info.value as container,
info.mesos_id as mesos_id, i.name as name, h.clock as clock, h.value as value_Error
from items i,  history_str h, info, host
where i.itemid=h.itemid and i.hostid =host.hostid 
and i.name like 'Container /mesos%Error' and i.name like info.name;




create or replace view containerDocker as 
select host.host as hostname, host.ip as host_ip,
i.name as name, h.clock as clock, h.value as value
from items i, history_uint h, host
where i.itemid=h.itemid and i.hostid =host.hostid 
and (i.name = 'Docker: Containers paused' or  i.name ='Docker: Containers running'
or i.name= 'Docker: Containers stopped' or i.name= 'Docker: Containers total');

select hostname, host_ip,
SUBSTRING_INDEX(SUBSTRING_INDEX(host_ip, '.', 4), '.', -1) as host_ip_dett,
SUBSTRING_INDEX(SUBSTRING_INDEX(name, ':', 2), ':', -1) as metrics,
from_unixtime(clock) as time, value
from containerDocker where clock>UNIX_TIMESTAMP('2021-02-03 14:47:00') and clock<UNIX_TIMESTAMP(NOW()) ;



select hostname, host_ip,
SUBSTRING_INDEX(SUBSTRING_INDEX(host_ip, '.', 4), '.', -1) as host_ip_dett,
container, mesos_id,
SUBSTRING_INDEX(SUBSTRING_INDEX(name, ':', 2), ':', -1) as metrics,
from_unixtime(clock) as time, value_CPU
from containerCPU where clock>UNIX_TIMESTAMP('2021-02-03 14:47:00') and clock<UNIX_TIMESTAMP(NOW()) ;

SELECT * FROM INFORMATION_SCHEMA.events;


