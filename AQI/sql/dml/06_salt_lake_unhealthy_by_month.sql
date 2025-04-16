-- Salt Lake County “Unhealthy” Days by Month & Year
WITH monthly_data AS (
  SELECT
    EXTRACT(YEAR FROM "Date") AS year,
    EXTRACT(MONTH FROM "Date") AS month,
    COUNT(*) AS unhealthy_days
  FROM daily_aqi_by_county dabc
  WHERE
    dabc."county Name" = 'Salt Lake'
    AND dabc."Category" = 'Unhealthy'
  GROUP BY year, month
)
SELECT
  year,
  month,
  unhealthy_days
FROM monthly_data
ORDER BY year, month;
