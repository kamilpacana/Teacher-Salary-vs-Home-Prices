
CREATE TABLE PROPERTIES as
SELECT AVG(AV_TOTAL) as average_home_value, 2011 as year
FROM property11
GROUP BY LU
HAVING LU = "R1"

INSERT INTO PROPERTIES (average_home_value, year)
SELECT AVG(AV_TOTAL), 2012
FROM property12
GROUP BY LU
HAVING LU = "R1"

INSERT INTO PROPERTIES (average_home_value, year)
SELECT AVG(AV_TOTAL), 2013 as year
FROM property13
GROUP BY LU
HAVING LU = "R1"

INSERT INTO PROPERTIES (average_home_value, year)
SELECT AVG(AV_TOTAL), 2014 as year
FROM property14
GROUP BY LU
HAVING LU = "R1"

INSERT INTO PROPERTIES (average_home_value, year)
SELECT AVG(AV_TOTAL), 2015 as year
FROM property15
GROUP BY LU
HAVING LU = "R1"

INSERT INTO PROPERTIES (average_home_value, year)
SELECT AVG(AV_TOTAL), 2016 as year
FROM property16
GROUP BY LU
HAVING LU = "R1"

INSERT INTO PROPERTIES (average_home_value, year)
SELECT AVG(AV_TOTAL), 2017 as year
FROM property17
GROUP BY LU
HAVING LU = "R1"

INSERT INTO PROPERTIES (average_home_value, year)
SELECT AVG(AV_TOTAL), 2018 as year
FROM property18
GROUP BY LU
HAVING LU = "R1"

INSERT INTO PROPERTIES (average_home_value, year)
SELECT AVG(AV_TOTAL), 2019 as year
FROM property19
GROUP BY LU
HAVING LU = "R1"

INSERT INTO PROPERTIES (average_home_value, year)
SELECT AVG(AV_TOTAL), 2020 as year
FROM property20
GROUP BY LU
HAVING LU = "R1"

INSERT INTO PROPERTIES (average_home_value, year)
SELECT AVG(TOTAL_VALUE), 2021 as year
FROM property21
GROUP BY LU
HAVING LU = "R1"

INSERT INTO PROPERTIES (average_home_value, year)
SELECT AVG(TOTAL_VALUE), 2022 as year
FROM property22
GROUP BY LU
HAVING LU = "R1"

select *
from PROPERTIES
