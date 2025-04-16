-- Top 10 Worst AQI Locations by Year
WITH worst_aqi_location AS (
  SELECT
    EXTRACT(YEAR FROM "Date") AS year,
    "county Name" AS county_name,
    "State Name" AS state_name,
    MAX("AQI") AS worst_aqi
  FROM daily_aqi_by_county dabc
  GROUP BY year, "county Name", "State Name"
)
SELECT
  year,
  county_name,
  state_name,
  worst_aqi
FROM (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY year ORDER BY worst_aqi DESC) AS ranking
  FROM worst_aqi_location
) subq
WHERE ranking <= 10
ORDER BY year, worst_aqi DESC;
