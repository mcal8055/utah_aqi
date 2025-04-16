# AQI Project

Twenty‑year SQL analysis of national and Utah air quality trends using EPA AQI data.

---

## Project Structure

```
AQI/
├── analysis/
│   └── Executive Summary.pdf        # project overview and key findings
├── data/
│   └── 20_yr_daily_aqi_by_zcode.zip # raw daily AQI data
├── sql/
│   ├── ddl/
│   │   └── create_table.sql         # DDL for daily_aqi_by_county
│   └── dml/
│       ├── 01_seasonal_avg_aqi.sql
│       ├── 02_top10_worst_locations.sql
│       ├── 03_top10_improvements.sql
│       ├── 04_top10_declines.sql.txt  # rename to .sql for consistency
│       ├── 05_utah_unhealthy_days.sql
│       └── 06_salt_lake_unhealthy_by_month.sql
└── README.md                         # this file
```

---

## Introduction

This project examines 20 years of EPA Air Quality Index (AQI) to identify national trends and Utah‑specific challenges through SQL queries.

---

## Files

### analysis
- **Executive Summary.pdf**: Detailed project background and key findings.

### data
- **20_yr_daily_aqi_by_zcode.zip**: Compressed CSVs of daily AQI by ZIP code.

### sql/ddl
- **create_table.sql**  
  Defines the `daily_aqi_by_county` table schema.

### sql/dml
1. **01_seasonal_avg_aqi.sql**  
   Calculate average AQI by season and year.  
2. **02_top10_worst_locations.sql**  
   Identify top 10 counties with highest AQI each year.  
3. **03_top10_improvements.sql**  
   Find top 10 locations with greatest AQI reduction (2004 → 2024).  
4. **04_top10_declines.sql.txt**  
   Find top 10 locations with greatest AQI increase (2004 → 2024).  
5. **05_utah_unhealthy_days.sql**  
   Count “Unhealthy” air days in Utah by year.  
6. **06_salt_lake_unhealthy_by_month.sql**  
   Count monthly “Unhealthy” days in Salt Lake County.

---

## How to Run

1. **Load Data**  
   Import the CSV files from `data/` into your SQL database as `daily_aqi_by_county`.

2. **Run DDL**  
   ```bash
   psql -d your_db -f sql/ddl/create_table.sql
   ```

3. **Execute DML Scripts** (in numeric order)  
   ```bash
   for script in sql/dml/*; do
     psql -d your_db -f "$script"
   done
   ```

---

## Key Findings

- **National Improvements**  
  - Summer AQI: 62.17 → 47.12  
  - Winter AQI: 45.47 → 37.19  

- **Persistent Hotspots**  
  Counties like Inyo, CA and Utah’s Wasatch Front still experience high AQI peaks.

- **Utah “Unhealthy” Days**  
  Slight decrease from 7 to 6 days/year (2014 → 2024), suggesting room for policy enhancements.

---

## Next Steps
- Benchmark against other Western states to isolate regional wildfire impacts.  
