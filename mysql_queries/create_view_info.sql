create view info as (select distinct SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 1), ':', -1) as name, h.value
from items i inner join  history_text h on h.itemid=i.itemid
where SUBSTRING_INDEX(SUBSTRING_INDEX(i.name, ':', 2), ':', -1)=' MarathonAppId' and h.value != 'unknown');



