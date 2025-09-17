--Duplicate values
SELECT id, COUNT(*) AS cnt
FROM ChargingStation
GROUP BY id
HAVING COUNT(*) > 1;

--Null values/ Negative values 
SELECT COUNT(*) AS invalid_rows
FROM ChargingStation
WHERE power_kw < 0;

--There where 4660 rows with negative and null values in power_kw column
DELETE FROM ChargingStation
WHERE power_kw IS NULL OR power_kw < 0;

--Country_code should be in upper case
UPDATE ChargingStation
SET country_code = UPPER(LTRIM(RTRIM(country_code)));

--For the Country summary file
SELECT DISTINCT *
INTO CountrySummary_Clean
FROM CountrySummary;


--For the World summary file 
SELECT
    SUM(CASE WHEN country_code IS NULL THEN 1 ELSE 0 END) AS column1_nulls,
    SUM(CASE WHEN country  IS NULL THEN 1 ELSE 0 END) AS column2_nulls
FROM WorldSummary;


--For the EV model file 
SELECT model, COUNT(*) AS count_duplicates
FROM EVModels
GROUP BY model
HAVING COUNT(*) > 1;
