

select * from history where from_unixtime(history.clock) > :sql_last_value AND from_unixtime(history.clock) < NOW())



select * from history_str where from_unixtime(history_str.clock) > :sql_last_value AND from_unixtime(history_str.clock) < NOW());



select * from history_text where from_unixtime(history_text.clock) > :sql_last_value AND from_unixtime(history_text.clock) < NOW());



select * from history_uint where from_unixtime(history_uint.clock) > :sql_last_value AND from_unixtime(history_uint.clock) < NOW());



select * from history_log where from_unixtime(history_log.clock) > :sql_last_value AND from_unixtime(history_log.clock) < NOW());