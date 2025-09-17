USE EV_Project
GO;
USE EV_Project;
GO

-- 1) Drop staging table if exists
IF OBJECT_ID('ChargingStation_Staging', 'U') IS NOT NULL
    DROP TABLE ChargingStation_Staging;
GO

-- 2) Create staging table (all columns as VARCHAR)
CREATE TABLE ChargingStation_Staging
(
    id VARCHAR(MAX),
    name VARCHAR(MAX),
    city VARCHAR(MAX),
    country_code VARCHAR(MAX),
    state_province VARCHAR(MAX),
    latitude VARCHAR(MAX),
    longitude VARCHAR(MAX),
    ports VARCHAR(MAX),
    power_kw VARCHAR(MAX),
    power_class VARCHAR(MAX),
    is_fast_dc VARCHAR(MAX)
);
GO

-- 3) Bulk insert into staging table
BULK INSERT ChargingStation_Staging
FROM 'C:\Users\ADITYA\OneDrive\Desktop\EVProject\ChargingStations.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '0x0d0a', 
    TABLOCK,
    FORMAT = 'CSV'
);
GO

-- 4) Drop final table if exists
IF OBJECT_ID('ChargingStation', 'U') IS NOT NULL
    DROP TABLE ChargingStation;
GO

-- 5) Create final table with proper types
CREATE TABLE ChargingStation
(
    id INT NULL,
    name VARCHAR(500) NULL,
    city VARCHAR(200) NULL,
    country_code VARCHAR(20) NULL,
    state_province VARCHAR(300) NULL,
    latitude FLOAT NULL,
    longitude FLOAT NULL,
    ports FLOAT NULL,
    power_kw FLOAT NULL,
    power_class VARCHAR(100) NULL,
    is_fast_dc BIT NULL
);
GO

-- 6) Insert clean data from staging to final table
INSERT INTO ChargingStation
    (
    id, name, city, country_code, state_province,
    latitude, longitude, ports, power_kw, power_class, is_fast_dc
    )
SELECT
    TRY_CAST(id AS INT),
    LEFT(name, 500),
    LEFT(city, 200),
    -- Clean country_code
    LEFT(REPLACE(REPLACE(country_code, '"', ''), ' ', ''), 20),
    -- Clean state_province
    CASE 
        WHEN state_province IS NULL OR LTRIM(RTRIM(state_province)) = '' 
            THEN 'Unknown'
        WHEN state_province IN ('GJ', 'gujarat', 'Guj') 
            THEN 'Gujarat'
        WHEN state_province IN ('MH', 'maharashtra', 'Maha') 
            THEN 'Maharashtra'
        WHEN state_province IN ('CA', 'california', 'Calif') 
            THEN 'California'
        ELSE LTRIM(RTRIM(state_province))
    END,
    TRY_CAST(latitude AS FLOAT),
    TRY_CAST(longitude AS FLOAT),
    TRY_CAST(ports AS FLOAT),
    TRY_CAST(power_kw AS FLOAT),
    LEFT(power_class, 100),
    CASE WHEN is_fast_dc IN ('1','0') THEN CAST(is_fast_dc AS BIT) ELSE NULL END
FROM ChargingStation_Staging;
GO

-- 7) Quick check
SELECT TOP 20
    country_code, city, state_province
FROM ChargingStation;
SELECT COUNT(*) AS total_rows, COUNT(country_code) AS country_code_filled
FROM ChargingStation;





--For creating the table for the WorldSummary.CSV file
-- Step 1: Create final table with proper types
CREATE TABLE WorldSummary
(
    country_code NVARCHAR(10),
    country NVARCHAR(100),
    count INT,
    max_power_kw_max FLOAT
);
-- Step 2: Bulk insert the data
BULK INSERT WorldSummary
FROM 'C:\Users\ADITYA\OneDrive\Desktop\EVProject\WorldSummary.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);


--For creating the table for the EVMOdels.CSV file
-- Step 1: Create table for EVModel
CREATE TABLE EV_Models
(
    ModelID INT PRIMARY KEY,
    ModelName NVARCHAR(100),
    Manufacturer NVARCHAR(100),
    Year INT,
    Price DECIMAL(10,2)
);
-- Step 2: Bul Insert the data 
BULK INSERT EV_Models
FROM 'C:\Data\EV_project\EV_Models.csv'
WITH (
    FIRSTROW = 2,  -- skips header row
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',
    TABLOCK
);

--For creating the table for the CountrySummary.CSV file 
-- Step 1: Create country summary table with proper types
CREATE TABLE CountrySummary
(
    country_code NVARCHAR(10),
    stations INT
);
-- Step 2: Bulk insert the data 
BULK INSERT CountrySummary
FROM 'C:\Users\ADITYA\OneDrive\Desktop\EVProject\CountrySummary.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
