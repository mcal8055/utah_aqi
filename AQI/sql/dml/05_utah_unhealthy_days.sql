-- Utah “Unhealthy” Air Days by Year
WITH yearly_data AS (
  SELECT
    EXTRACT(YEAR FROM "Date") AS year,
    COUNT(*) AS unhealthy_days
  FROM daily_aqi_by_county dabc
  WHERE
    dabc."State Name" = 'Utah'
    AND dabc."Category" = 'Unhealthy'
  GROUP BY year
)
SELECT
  year,
  unhealthy_days
FROM yearly_data
ORDER BY year;
