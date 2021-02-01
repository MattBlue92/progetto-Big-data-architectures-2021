create view finalData as (
  select
    unionTable,
    case when itemname = " Cpu usage for second" then itemvalue end as " Cpu usage for second",
    case when itemname = " Memory usage" then itemvalue end as " Memory usage",
  from history
);


###### ghera I'm going to sleep now!