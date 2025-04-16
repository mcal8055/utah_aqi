-- Drop the table in the correct schema if it exists
DROP TABLE IF EXISTS aqi.daily_aqi_by_county;

-- Create the schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS aqi;

-- Create the partitioned table with explicit date type
CREATE TABLE aqi.daily_aqi_by_county (
    "State Name"              varchar(50),
    "county Name"             varchar(50),
    "State Code"              integer,
    "County Code"             integer,
    "Date"                    date,
    "AQI"                     integer,
    "Category"                varchar(50),
    "Defining Parameter"      varchar(50),
    "Defining Site"           varchar(50),
    "Number of Sites Reporting" integer
)
PARTITION BY RANGE ("Date");

-- Create partitions with proper date ranges and explicit casts

DO $$
DECLARE 
  start_year INTEGER := 1999;  -- Change this value to adjust the start year
  end_year   INTEGER := 2024;  -- Change this value to adjust the end year
  yr         INTEGER;
  start_date TEXT;
  end_date   TEXT;
BEGIN
  FOR yr IN start_year..end_year LOOP
      start_date := yr::TEXT || '-01-01';
      end_date := (yr + 1)::TEXT || '-01-01';
      EXECUTE format(
          'CREATE TABLE IF NOT EXISTS aqi.daily_aqi_by_county_%s
           PARTITION OF aqi.daily_aqi_by_county
           FOR VALUES FROM (DATE %L) TO (DATE %L);',
          yr,
          start_date,
          end_date
      );
  END LOOP;
END $$;

