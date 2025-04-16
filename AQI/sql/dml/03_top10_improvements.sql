-- Top 10 Locations with Best AQI Improvement (2004 → 2024)
WITH yearly_aqi AS (
  SELECT
    EXTRACT(YEAR FROM "Date") AS year,
    "county Name",
    "State Name",
    AVG("AQI") AS avg_aqi
  FROM daily_aqi_by_county dabc
  GROUP BY year, "county Name", "State Name"
),
location_improvement AS (
  SELECT
    "county Name" AS county_name,
    "State Name" AS state_name,
    FIRST_VALUE(avg_aqi) OVER (
      PARTITION BY "county Name", "State Name"
      ORDER BY year ASC
    ) AS aqi_2004,
    FIRST_VALUE(avg_aqi) OVER (
      PARTITION BY "county Name", "State Name"
      ORDER BY year DESC
    ) AS aqi_2024
  FROM yearly_aqi
)
SELECT DISTINCT
  county_name,
  state_name,
  ROUND(aqi_2004, 2) AS aqi_2004,
  ROUND(aqi_2024, 2) AS aqi_2024,
  ROUND((aqi_2004 - aqi_2024), 2) AS improvement
FROM location_improvement
ORDER BY improvement DESC
LIMIT 10;
