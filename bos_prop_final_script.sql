

DROP view if exists prop_12

create view prop_12 as
select ST_NUM,
ST_NAME,
ZIPCODE,
AV_TOTAL
from bos_prop_12
WHERE LU == 'R1'
order by AV_TOTAL desc

SELECT * from prop_12

DROP VIEW IF EXISTS cleaned_prop_12

CREATE VIEW cleaned_prop_12 as
select ZIPCODE,
AVG(AV_TOTAL) AS TOTAL_VALUE
from prop_12
where ST_NUM NOTNULL
AND ST_NAME NOTNULL
GROUP BY ZIPCODE

DROP VIEW IF EXISTS zips_2012

create view zips_2012 as
select ZIPCODE,
avg(AV_TOTAL) as AVG_TOTAL
from bos_prop_12
where LU == 'R1'
GROUP BY ZIPCODE
ORDER BY AV_TOTAL DESC

drop view if exists final_prop_12

create view final_prop_12 as
SELECT *
from zips_2012
join clean_zip on zips_2012.ZIPCODE = clean_zip.ZIP5;

select * from final_prop_12

--------------------------------------------------------------------------------------

UPDATE bos_prop_17
SET ZIPCODE = REPLACE(ZIPCODE, '_', '')
WHERE ZIPCODE LIKE '%_';

create view 
select CAST(ZIPCODE AS INTEGER) AS ZIPCODE 
FROM bos_prop_17;

DROP view if exists prop_17

create view prop_17 as
select CAST(ZIPCODE AS INTEGER) AS ZIPCODE,
ST_NUM,
ST_NAME,
AV_TOTAL
from bos_prop_17
WHERE LU == 'R1'
order by AV_TOTAL desc


DROP VIEW IF EXISTS cleaned_prop_17

CREATE VIEW cleaned_prop_17 as
select CAST(ZIPCODE AS INTEGER) AS ZIPCODE,
AVG(AV_TOTAL) AS TOTAL_VALUE
from prop_17
where ST_NUM NOTNULL
AND ST_NAME NOTNULL
GROUP BY ZIPCODE

select * from cleaned_prop_17

DROP VIEW IF EXISTS zips_2017

create view zips_2017 as
select CAST(ZIPCODE AS INTEGER) AS ZIPCODE,
avg(AV_TOTAL) as AVG_TOTAL
from bos_prop_17
where LU == 'R1'
GROUP BY ZIPCODE
ORDER BY AV_TOTAL DESC

select * from zips_2017

drop view if exists final_prop_17

create view final_prop_17 as
SELECT *
from zips_2017
join clean_zip on zips_2017.ZIPCODE = clean_zip.ZIP5;

select * from final_prop_17

--------------------------------------------------------------------------------------

DROP view if exists prop_22

create view prop_22 as
select ST_NUM,
ST_NAME,
CITY,
ZIPCODE,
TOTAL_VALUE
from bos_prop_22
WHERE LU == 'R1'
order by TOTAL_VALUE desc

DROP VIEW IF EXISTS cleaned_prop_22

CREATE VIEW cleaned_prop_22 as
select ZIPCODE,
AVG(TOTAL_VALUE) AS TOTAL_VALUE
from prop_22
where ST_NUM NOTNULL
AND ST_NAME NOTNULL
AND CITY NOTNULL
GROUP BY ZIPCODE

SELECT * FROM cleaned_prop_22 

DROP VIEW IF EXISTS clean_zip

create view clean_zip as
SELECT ZIP5,
ShapeSTArea,
ShapeSTLength
FROM bos_zip



DROP VIEW IF EXISTS final_prop_22

create view final_prop_22 as
SELECT *
from cleaned_prop_22
join clean_zip on cleaned_prop_22.ZIPCODE = clean_zip.ZIP5;

select * from final_prop_22















