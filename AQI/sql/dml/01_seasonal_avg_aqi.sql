-- Average AQI by Year and Season
SELECT
  ROUND(AVG(dabc."AQI"), 2) AS average_aqi,
  EXTRACT(YEAR FROM "Date") AS year,
  CASE
    WHEN EXTRACT(MONTH FROM "Date") IN (12, 1, 2) THEN 'Winter'
    WHEN EXTRACT(MONTH FROM "Date") IN (3, 4, 5) THEN 'Spring'
    WHEN EXTRACT(MONTH FROM "Date") IN (6, 7, 8) THEN 'Summer'
    WHEN EXTRACT(MONTH FROM "Date") IN (9, 10, 11) THEN 'Fall'
  END AS season
FROM daily_aqi_by_county dabc
GROUP BY season, year
ORDER BY year, season;
