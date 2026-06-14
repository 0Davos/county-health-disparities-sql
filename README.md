# Geographic Disparities in Food Access and Public Health

## Overview
A SQL-driven analysis of U.S. county-level food access and public health outcomes. Explores whether food environment factors like grocery density and low-access population rates predict health outcomes beyond what poverty alone explains. 

## Highlights
- Two-table MySQL schema linking USDA county-level food environment data to CDC census tract-level health data via FIPS code, with orphaned tract cleanup on load
- Window functions throughout: DENSE_RANK() for within-state rankings and deviation ranking, NTILE() for poverty tier segmentation
- CTEs used to break multi-step analytical logic into readable layers — averaging tract-level senior data up to county level, computing per-tier health baselines, and isolating deviations from expected outcomes
- Handles real data quality issues: NULLIF() on every loaded column, throwaway @variables for unused source fields, foreign key constraint ordering on load

## Data Sources
- [USDA Food Environment Atlas](https://www.ers.usda.gov/data-products/food-environment-atlas/data-access-and-documentation-downloads) — county-level food access, store density, poverty, and demographic data
- [CDC 500 Cities Census Tract-level Data](https://chronicdata.cdc.gov/500-Cities-Places/500-Cities-Census-Tract-level-Data-GIS-Friendly-Fo/k86t-wghb/about_data) — tract-level health outcome prevalence

## Database Schema
USDA county-level data (3,000+ counties) has a one-to-many relationship with CDC tract-level data, joined on FIPS code. County table holds food environment and socioeconomic metrics; tract table holds health outcome prevalence rates.

## Questions Explored
- How does each county's diabetes rate rank within its state?
  (DENSE_RANK, PARTITION BY state)
- Which counties have the largest gap between their low access rate and their state average?
  (CTE aggregation, LEFT JOIN, computed gap column)
- Which states have the greatest disparity in child poverty between their best and worst counties?
  (CTE with MAX/MIN, computed spread)
- How spread out are county child poverty rates within each state?
  (STDDEV aggregation)
- How do food access metrics differ between counties with high vs. low senior populations?
  (multi-CTE pipeline, LEFT JOIN tract aggregation, CASE-based group labeling)
- Which counties show unexpectedly poor health outcomes relative to their poverty rate?
  (NTILE decile tiering, per-tier baseline averages, dual-condition outlier flagging)
- Which counties deviate most from their poverty tier's expected diabetes rate?
  (DENSE_RANK within NTILE quintiles, computed deviation column, top-N per tier)

## Key Findings
- Highland, VA, Mercer, MO, and Buena Vista, VA have the largest gap between their low access rate and their state's average — 80.18%, 77.13%, and 76.42% respectively.
-  Texas, South Dakota, and New Mexico have the largest disparity of child poverty rates between their highest percentage counties and their lowest.
-  But, when looking at child poverty rate standard deviations, South Dakota, Mississippi and Alabama are the highest, with Texas in 13th, and New Mexico in 8th.
- When comparing counties of above and below the national average percentage for senior populations, on average the higher percentage of seniors means more people with lower access (by 1.47%), fewer grocery stores, supermarkets, and convenience stores.
- While diabetes and obesity generally increase as poverty rate increases generally, unexpected poor health outcomes did not appear in any meaningful pattern when paired with poverty tier, with outliers appearing in all 10 deciles.
- Diabetes deviations from poverty-tier baselines were non-linear in quantile poverty tiers — tier 2 and tier 4 counties showed larger gaps than tier 3, suggesting poverty is not the only driving factor.
- Oglala Lakota County, SD (Entirely within the Sioux reservation) posted the largest diabetes deviation in the dataset at +7.70 points above its tier average, despite having a poverty rate nearly double other tier 5 outliers.

## How to Run
1. Install MySQL 8.0 and create a local database
2. Run `usda_project.sql` to create the `county` and `tract` tables, and populate them
3. Download source CSVs from the links above, or use the provided sample CSVs in this repository, and update the file paths in the script accordingly.
