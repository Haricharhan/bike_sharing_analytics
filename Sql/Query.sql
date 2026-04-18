show tables;
select COUNT(*) from bike_share_yr_0;
select COUNT(*) from bike_share_yr_0;

-- Check Null Values:
select 
    SELECT 
    SUM(CASE WHEN dteday IS NULL THEN 1 ELSE 0 END) AS null_dteday,
    SUM(CASE WHEN season IS NULL THEN 1 ELSE 0 END) AS null_season,
    SUM(CASE WHEN yr IS NULL THEN 1 ELSE 0 END) AS null_year,
    SUM(CASE WHEN hr IS NULL THEN 1 ELSE 0 END) AS null_hr,
    SUM(CASE WHEN riders IS NULL THEN 1 ELSE 0 END) AS null_riders
FROM bike_share_yr_0;

select 
    SELECT 
    SUM(CASE WHEN dteday IS NULL THEN 1 ELSE 0 END) AS null_dteday,
    SUM(CASE WHEN season IS NULL THEN 1 ELSE 0 END) AS null_season,
    SUM(CASE WHEN yr IS NULL THEN 1 ELSE 0 END) AS null_year,
    SUM(CASE WHEN hr IS NULL THEN 1 ELSE 0 END) AS null_hr,
    SUM(CASE WHEN riders IS NULL THEN 1 ELSE 0 END) AS null_riders
FROM bike_share_yr_1;


--Replace Nulls With Mean 
UPDATE bike_share_yr_0
SET riders = (
    SELECT AVG(riders) FROM bike_share_yr_0
)
WHERE riders IS NULL;
-- SAME FOR ALL THE COLUMNS IF NEEDED 



-- Checking Data Types 

DESCRIBE  bike_share_yr_0;


-- Basic Statistics 
SELECT 
    MIN(riders) AS min_riders,
    MAX(riders) AS max_riders,
    AVG(riders) AS avg_riders,
    STDDEV(riders) AS std_riders
FROM bike_share_yr_0;


-- Checking Duplicates :
SELECT 
    dteday, hr, COUNT(*) AS count_duplicates
FROM bike_share_yr_0
GROUP BY dteday, hr
HAVING COUNT(*) > 1;


-- Remove Duplicates :
DELETE t1
FROM bike_share_yr_0 t1
JOIN bike_share_yr_0 t2
ON t1.dteday = t2.dteday
AND t1.hr = t2.hr
AND t1.id > t2.id;                                                                                    


-- Combine + Transform :
with combined as (
	select * from bike_share_yr_0 
	union all 
	select * from bike_share_yr_1
)
select 
dteday ,
season,
a.yr,
weekday,
hr,
rider_type,
riders ,
price ,
COGS , 
riders * price as revenue,
riders  * price - riders * COGS as profit
from combined  as a 
left join cost_table as c
on a.yr = c.yr; 