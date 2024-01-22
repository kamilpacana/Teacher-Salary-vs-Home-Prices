DROP view if exists prop_22

create view prop_22 as
select ST_NUM,
ST_NAME,
CITY,
TOTAL_VALUE
from bos_prop_22
WHERE LU == 'R1'
order by TOTAL_VALUE desc

DROP VIEW IF EXISTS cleaned_prop_22

CREATE VIEW cleaned_prop_22 as
select * 
from prop_22
where ST_NUM NOTNULL
AND ST_NAME NOTNULL
AND CITY NOTNULL