

--Used to remove $ for the tables which had it in one of their columns
--https://www.tutorialspoint.com/how-to-remove-special-characters-from-a-database-field-in-mysql#:~:text=You%20can%20remove%20special%20characters,sign(%24)%2C%20percent%20(%25)%20etc.
UPDATE year2011
SET TOTAL_EARNINGS=REPLACE(TOTAL_EARNINGS,'$','');



--Using REPLACE to fix an issue where the ","  interfere with the casting was suggested by Chatgpt for an earlier problem
--Used to cast string columns to new int ones
--https://stackoverflow.com/questions/18480503/sql-alter-column-datatype-from-nvarchar-to-int
ALTER TABLE year2021 ADD gross_total int;
UPDATE year2022 SET gross_total = CAST(REPLACE(TOTAL_GROSS, ',', '') AS FLOAT);

/*
 * I filtered out any wage below $20,520 under the assumption that those teachers were not
 *  working full time. I received this number by multiplying 8 hours x 180 days x minimum wage
 * for that year.  eight hours a day because most teachers work more than eight hours, and
 *  180 days because that's the standard teacher's contractual yearly workdays. This is just a 
 * rough rule of thumb to try to falter out people who are working part time and is not a perfect measure.
 * https://www.edweek.org/teaching-learning/heres-how-many-hours-a-week-teachers-work/2022/04
 * https://www.weareteachers.com/teacher-overtime/#:~:text=(This%20is%20more%20than%20most,weeks%2C%20or%20around%20180%20days.
 * https://foreignusa.com/massachusetts-state-minimum-wage/
 * 
 * Rough code for how to use union all in combination with select and As Year to aggregate values across different tables
 *  was provided by chat gpt and later customized and tweaked for the specific needs of the problem.
 * */
CREATE VIEW overall_average_teacher_salaries AS
SELECT '2011' AS year, AVG(gross_total) AS average_earnings
FROM  year2011
WHERE TITLE = 'Teacher' 
AND gross_total >= (8 * 180 * 8)
UNION ALL
SELECT '2012' AS year, AVG(gross_total) AS average_earnings
FROM year2012
WHERE TITLE = 'Teacher' 
AND gross_total >= (8 * 180 * 8)
UNION ALL
SELECT '2013' AS year, AVG(gross_total) AS average_earnings
FROM year2013
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 8)
UNION ALL
SELECT '2014' AS year, AVG(gross_total) AS average_earnings
FROM year2014
WHERE TITLE = 'Teacher' 
AND gross_total >= (8 * 180 * 8)
UNION ALL
SELECT '2015' AS year, AVG(gross_total) AS average_earnings
FROM year2015
WHERE TITLE = 'Teacher' 
AND gross_total >= (8 * 180 * 9)
UNION ALL
SELECT '2016' AS year, AVG(gross_total) AS average_earnings
FROM year2016
WHERE TITLE = 'Teacher' 
AND gross_total >= (8 * 180 * 10)
UNION ALL
SELECT '2017' AS year, AVG(gross_total) AS average_earnings
FROM year2017
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 11)
UNION ALL
SELECT '2018' AS year, AVG(gross_total) AS average_earnings
FROM year2018
WHERE TITLE = 'Teacher' 
AND gross_total >= (8 * 180 * 11)
UNION ALL
SELECT '2019' AS year, AVG(gross_total) AS average_earnings
FROM year2019
WHERE TITLE = 'Teacher' 
AND gross_total >= (8 * 180 * 12)
UNION ALL
SELECT '2020' AS year, AVG(gross_total) AS average_earnings
FROM year2020
WHERE TITLE = 'Teacher' 
AND gross_total >= (8 * 180 * 12.75)
UNION ALL
SELECT '2021' AS year, AVG(gross_total) AS average_earnings
FROM year2021
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 13.50)
UNION ALL
SELECT '2022' AS year, AVG(gross_total) AS average_earnings
FROM year2022
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 14.25)



--The following views were created to return only the bottom 25th percentile of teacher salraies
CREATE VIEW bottom_2011 AS
SELECT gross_total
FROM year2011
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 8)
ORDER BY gross_total 
LIMIT FLOOR(5017 / 4)

CREATE VIEW bottom_2012 AS
SELECT gross_total
FROM year2012
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 8)
ORDER BY gross_total 
LIMIT FLOOR(5141 / 4)

CREATE VIEW bottom_2013 AS
SELECT gross_total
FROM year2013
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 8)
ORDER BY gross_total 
LIMIT FLOOR(5207 / 4)

CREATE VIEW bottom_2014 AS
SELECT gross_total
FROM year2014
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 8)
ORDER BY gross_total 
LIMIT FLOOR(5279 / 4)

CREATE VIEW bottom_2015 AS
SELECT gross_total
FROM year2015
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 9)
ORDER BY gross_total 
LIMIT FLOOR(5260 / 4)

CREATE VIEW bottom_2016 AS
SELECT gross_total
FROM year2016
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 *10)
ORDER BY gross_total 
LIMIT FLOOR(5231 / 4)

CREATE VIEW bottom_2017 AS
SELECT gross_total
FROM year2017
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 11)
ORDER BY gross_total 
LIMIT FLOOR(5268 / 4)

CREATE VIEW bottom_2018 AS
SELECT gross_total
FROM year2018
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 11)
ORDER BY gross_total 
LIMIT FLOOR(5114 / 4)

CREATE VIEW bottom_2019 AS
SELECT gross_total
FROM year2019
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 12)
ORDER BY gross_total 
LIMIT FLOOR(5011 / 4)

CREATE VIEW bottom_2020 AS
SELECT gross_total
FROM year2020
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 12.75)
ORDER BY gross_total 
LIMIT FLOOR(4970 / 4)

CREATE VIEW bottom_2021 AS
SELECT gross_total
FROM year2021
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 13.50)
ORDER BY gross_total 
LIMIT FLOOR(4842 / 4)

CREATE VIEW bottom_2022 AS
SELECT gross_total
FROM year2022
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 14.25)
ORDER BY gross_total 
LIMIT FLOOR(4818 / 4)




/*We chose not to subdivide based on high school verses middle school verses other school types because some of the datasets did not contain this information
 * and because there was no consistent price difference between different school types for the years the data was available.
 *  For that reason we differentiated based on percentile instead. instead
 
Shows the average salary from the bottom twenty fifth percentile of teacher salaries

**/
CREATE VIEW bottom_25th_percentile_teacher_salaries AS
SELECT '2011' AS year, AVG(gross_total) AS average_earnings
FROM  bottom_2011
UNION ALL
SELECT '2012' AS year, AVG(gross_total) AS average_earnings
FROM bottom_2012
UNION ALL
SELECT '2013' AS year, AVG(gross_total) AS average_earnings
FROM bottom_2013
UNION ALL
SELECT '2014' AS year, AVG(gross_total) AS average_earnings
FROM bottom_2014
UNION ALL
SELECT '2015' AS year, AVG(gross_total) AS average_earnings
FROM bottom_2015
UNION ALL
SELECT '2016' AS year, AVG(gross_total) AS average_earnings
FROM bottom_2016
UNION ALL
SELECT '2017' AS year, AVG(gross_total) AS average_earnings
FROM bottom_2017
UNION ALL
SELECT '2018' AS year, AVG(gross_total) AS average_earnings
FROM bottom_2018
UNION ALL
SELECT '2019' AS year, AVG(gross_total) AS average_earnings
FROM bottom_2019
UNION ALL
SELECT '2020' AS year, AVG(gross_total) AS average_earnings
FROM bottom_2020
UNION ALL
SELECT '2021' AS year, AVG(gross_total) AS average_earnings
FROM bottom_2021
UNION ALL
SELECT '2022' AS year, AVG(gross_total) AS average_earnings
FROM bottom_2022








--The following views were created to return only the top 25th percentile of teacher salraies
CREATE VIEW top_2011 AS
SELECT gross_total
FROM year2011
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 8)
ORDER BY gross_total DESC
LIMIT FLOOR(5017 / 4)

CREATE VIEW top_2012 AS
SELECT gross_total
FROM year2012
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 8)
ORDER BY gross_total DESC
LIMIT FLOOR(5141 / 4)

CREATE VIEW top_2013 AS
SELECT gross_total
FROM year2013
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 8)
ORDER BY gross_total DESC
LIMIT FLOOR(5207 / 4)

CREATE VIEW top_2014 AS
SELECT gross_total
FROM year2014
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 8)
ORDER BY gross_total DESC
LIMIT FLOOR(5279 / 4)

CREATE VIEW top_2015 AS
SELECT gross_total
FROM year2015
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 9)
ORDER BY gross_total DESC
LIMIT FLOOR(5260 / 4)

CREATE VIEW top_2016 AS
SELECT gross_total
FROM year2016
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 *10)
ORDER BY gross_total DESC
LIMIT FLOOR(5231 / 4)

CREATE VIEW top_2017 AS
SELECT gross_total
FROM year2017
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 11)
ORDER BY gross_total DESC
LIMIT FLOOR(5268 / 4)

CREATE VIEW top_2018 AS
SELECT gross_total
FROM year2018
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 11)
ORDER BY gross_total DESC
LIMIT FLOOR(5114 / 4)

CREATE VIEW top_2019 AS
SELECT gross_total
FROM year2019
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 12)
ORDER BY gross_total DESC
LIMIT FLOOR(5011 / 4)

CREATE VIEW top_2020 AS
SELECT gross_total
FROM year2020
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 12.75)
ORDER BY gross_total DESC
LIMIT FLOOR(4970 / 4)

CREATE VIEW top_2021 AS
SELECT gross_total
FROM year2021
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 13.50)
ORDER BY gross_total DESC
LIMIT FLOOR(4842 / 4)

CREATE VIEW top_2022 AS
SELECT gross_total
FROM year2022
WHERE TITLE = 'Teacher'
AND gross_total >= (8 * 180 * 14.25)
ORDER BY gross_total DESC
LIMIT FLOOR(4818 / 4)




/* shows the average salary from the top twenty fifth percentile of teacher salaries
**/
CREATE VIEW top_25th_percentile_teacher_salaries AS
SELECT '2011' AS year, AVG(gross_total) AS average_earnings
FROM  top_2011
UNION ALL
SELECT '2012' AS year, AVG(gross_total) AS average_earnings
FROM top_2012
UNION ALL
SELECT '2013' AS year, AVG(gross_total) AS average_earnings
FROM top_2013
UNION ALL
SELECT '2014' AS year, AVG(gross_total) AS average_earnings
FROM top_2014
UNION ALL
SELECT '2015' AS year, AVG(gross_total) AS average_earnings
FROM top_2015
UNION ALL
SELECT '2016' AS year, AVG(gross_total) AS average_earnings
FROM top_2016
UNION ALL
SELECT '2017' AS year, AVG(gross_total) AS average_earnings
FROM top_2017
UNION ALL
SELECT '2018' AS year, AVG(gross_total) AS average_earnings
FROM top_2018
UNION ALL
SELECT '2019' AS year, AVG(gross_total) AS average_earnings
FROM top_2019
UNION ALL
SELECT '2020' AS year, AVG(gross_total) AS average_earnings
FROM top_2020
UNION ALL
SELECT '2021' AS year, AVG(gross_total) AS average_earnings
FROM top_2021
UNION ALL
SELECT '2022' AS year, AVG(gross_total) AS average_earnings
FROM top_2022






/*
 *  aggregates the average salary for a fire department chief per year.
 *  we have elected not remove any injury based compensation as it is expected that this is more dangerous work
 *  than teaching, which that additional income compensates for. for it also helps insure those who were injured and took time off of work
 *  aren't being undercounted.
 * */
CREATE VIEW average_fire_department_chief_salary AS
SELECT '2011' AS year, AVG(gross_total) AS average_earnings
FROM  year2011
WHERE TITLE LIKE '%Dep Fire Chief%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2012' AS year, AVG(gross_total) AS average_earnings
FROM year2012
WHERE TITLE LIKE '%Dep Fire Chief%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2013' AS year, AVG(gross_total) AS average_earnings
FROM year2013
WHERE TITLE LIKE '%Dep Fire Chief%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2014' AS year, AVG(gross_total) AS average_earnings
FROM year2014
WHERE TITLE LIKE '%Dep Fire Chief%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2015' AS year, AVG(gross_total) AS average_earnings
FROM year2015
WHERE TITLE LIKE '%Dep Fire Chief%'
AND gross_total >= (8 * 250 * 9)
UNION ALL
SELECT '2016' AS year, AVG(gross_total) AS average_earnings
FROM year2016
WHERE TITLE LIKE '%Dep Fire Chief%'
AND gross_total >= (8 * 250 * 10)
UNION ALL
SELECT '2017' AS year, AVG(gross_total) AS average_earnings
FROM year2017
WHERE TITLE LIKE '%Dep Fire Chief%'
AND gross_total >= (8 * 250 * 11)
UNION ALL
SELECT '2018' AS year, AVG(gross_total) AS average_earnings
FROM year2018
WHERE TITLE LIKE '%Dep Fire Chief%'
AND gross_total >= (8 * 250 * 11)
UNION ALL
SELECT '2019' AS year, AVG(gross_total) AS average_earnings
FROM year2019
WHERE TITLE LIKE '%Dep Fire Chief%'
AND gross_total >= (8 * 250 * 12)
UNION ALL
SELECT '2020' AS year, AVG(gross_total) AS average_earnings
FROM year2020
WHERE TITLE LIKE '%Dep Fire Chief%'
AND gross_total >= (8 * 250 * 12.75)
UNION ALL
SELECT '2021' AS year, AVG(gross_total) AS average_earnings
FROM year2021
WHERE TITLE LIKE '%Dep Fire Chief%'
AND gross_total >= (8 * 250 * 13.50)
UNION ALL
SELECT '2022' AS year, AVG(gross_total) AS average_earnings
FROM year2022
WHERE TITLE LIKE '%Dep Fire Chief%'
AND gross_total >= (8 * 250 * 14.25)




/*
 *  aggregates the average salary for a custodian per year.
 * */
CREATE VIEW average_custodian_salary AS
SELECT '2011' AS year, AVG(gross_total) AS average_earnings
FROM  year2011
WHERE TITLE LIKE '%Cust%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2012' AS year, AVG(gross_total) AS average_earnings
FROM year2012
WHERE TITLE LIKE '%Cust%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2013' AS year, AVG(gross_total) AS average_earnings
FROM year2013
WHERE TITLE LIKE '%Cust%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2014' AS year, AVG(gross_total) AS average_earnings
FROM year2014
WHERE TITLE LIKE '%Cust%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2015' AS year, AVG(gross_total) AS average_earnings
FROM year2015
WHERE TITLE LIKE '%Cust%'
AND gross_total >= (8 * 250 * 9)
UNION ALL
SELECT '2016' AS year, AVG(gross_total) AS average_earnings
FROM year2016
WHERE TITLE LIKE '%Cust%'
AND gross_total >= (8 * 250 * 10)
UNION ALL
SELECT '2017' AS year, AVG(gross_total) AS average_earnings
FROM year2017
WHERE TITLE LIKE '%Cust%'
AND gross_total >= (8 * 250 * 11)
UNION ALL
SELECT '2018' AS year, AVG(gross_total) AS average_earnings
FROM year2018
WHERE TITLE LIKE '%Cust%'
AND gross_total >= (8 * 250 * 11)
UNION ALL
SELECT '2019' AS year, AVG(gross_total) AS average_earnings
FROM year2019
WHERE TITLE LIKE '%Cust%'
AND gross_total >= (8 * 250 * 12)
UNION ALL
SELECT '2020' AS year, AVG(gross_total) AS average_earnings
FROM year2020
WHERE TITLE LIKE '%Cust%'
AND gross_total >= (8 * 250 * 12.75)
UNION ALL
SELECT '2021' AS year, AVG(gross_total) AS average_earnings
FROM year2021
WHERE TITLE LIKE '%Cust%'
AND gross_total >= (8 * 250 * 13.50)
UNION ALL
SELECT '2022' AS year, AVG(gross_total) AS average_earnings
FROM year2022
WHERE TITLE LIKE '%Cust%'
AND gross_total >= (8 * 250 * 14.25)




/*
 *  aggregates the average salary for a librarian per year.
 * */
CREATE VIEW average_librarian_salary AS
SELECT '2011' AS year, AVG(gross_total) AS average_earnings
FROM  year2011
WHERE TITLE LIKE '%librarian%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2012' AS year, AVG(gross_total) AS average_earnings
FROM year2012
WHERE TITLE LIKE '%librarian%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2013' AS year, AVG(gross_total) AS average_earnings
FROM year2013
WHERE TITLE LIKE '%librarian%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2014' AS year, AVG(gross_total) AS average_earnings
FROM year2014
WHERE TITLE LIKE '%librarian%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2015' AS year, AVG(gross_total) AS average_earnings
FROM year2015
WHERE TITLE LIKE '%librarian%'
AND gross_total >= (8 * 250 * 9)
UNION ALL
SELECT '2016' AS year, AVG(gross_total) AS average_earnings
FROM year2016
WHERE TITLE LIKE '%librarian%'
AND gross_total >= (8 * 250 * 10)
UNION ALL
SELECT '2017' AS year, AVG(gross_total) AS average_earnings
FROM year2017
WHERE TITLE LIKE '%librarian%'
AND gross_total >= (8 * 250 * 11)
UNION ALL
SELECT '2018' AS year, AVG(gross_total) AS average_earnings
FROM year2018
WHERE TITLE LIKE '%librarian%'
AND gross_total >= (8 * 250 * 11)
UNION ALL
SELECT '2019' AS year, AVG(gross_total) AS average_earnings
FROM year2019
WHERE TITLE LIKE '%librarian%'
AND gross_total >= (8 * 250 * 12)
UNION ALL
SELECT '2020' AS year, AVG(gross_total) AS average_earnings
FROM year2020
WHERE TITLE LIKE '%librarian%'
AND gross_total >= (8 * 250 * 12.75)
UNION ALL
SELECT '2021' AS year, AVG(gross_total) AS average_earnings
FROM year2021
WHERE TITLE LIKE '%librarian%'
AND gross_total >= (8 * 250 * 13.50)
UNION ALL
SELECT '2022' AS year, AVG(gross_total) AS average_earnings
FROM year2022
WHERE TITLE LIKE '%librarian%'
AND gross_total >= (8 * 250 * 14.25)



/*
 *  aggregates the average salary for a police detective per year.
 *  we have elected not remove any injury based compensation as it is expected that this is more dangerous work
 *  than teaching, which that additional income compensates for. for it also helps insure those who were injured and took time off of work
 *  aren't being undercounted.With police officers specifically, injury pays also fairly common and so could be considered not an outlier in the data
 * */
CREATE VIEW average_police_detective_salary AS
SELECT '2011' AS year, AVG(gross_total) AS average_earnings
FROM  year2011
WHERE TITLE LIKE '%police detective%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2012' AS year, AVG(gross_total) AS average_earnings
FROM year2012
WHERE TITLE LIKE '%police detective%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2013' AS year, AVG(gross_total) AS average_earnings
FROM year2013
WHERE TITLE LIKE '%police detective%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2014' AS year, AVG(gross_total) AS average_earnings
FROM year2014
WHERE TITLE LIKE '%police detective%'
AND gross_total >= (8 * 250 * 8)
UNION ALL
SELECT '2015' AS year, AVG(gross_total) AS average_earnings
FROM year2015
WHERE TITLE LIKE '%police detective%'
AND gross_total >= (8 * 250 * 9)
UNION ALL
SELECT '2016' AS year, AVG(gross_total) AS average_earnings
FROM year2016
WHERE TITLE LIKE '%police detective%'
AND gross_total >= (8 * 250 * 10)
UNION ALL
SELECT '2017' AS year, AVG(gross_total) AS average_earnings
FROM year2017
WHERE TITLE LIKE '%police detective%'
AND gross_total >= (8 * 250 * 11)
UNION ALL
SELECT '2018' AS year, AVG(gross_total) AS average_earnings
FROM year2018
WHERE TITLE LIKE '%police detective%'
AND gross_total >= (8 * 250 * 11)
UNION ALL
SELECT '2019' AS year, AVG(gross_total) AS average_earnings
FROM year2019
WHERE TITLE LIKE '%police detective%'
AND gross_total >= (8 * 250 * 12)
UNION ALL
SELECT '2020' AS year, AVG(gross_total) AS average_earnings
FROM year2020
WHERE TITLE LIKE '%police detective%'
AND gross_total >= (8 * 250 * 12.75)
UNION ALL
SELECT '2021' AS year, AVG(gross_total) AS average_earnings
FROM year2021
WHERE TITLE LIKE '%police detective%'
AND gross_total >= (8 * 250 * 13.50)
UNION ALL
SELECT '2022' AS year, AVG(gross_total) AS average_earnings
FROM year2022
WHERE TITLE LIKE '%police detective%'
AND gross_total >= (8 * 250 * 14.25)







