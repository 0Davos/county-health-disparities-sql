DROP TABLE IF EXISTS tract;
DROP TABLE IF EXISTS county;
-- @block
CREATE TABLE county (
    FIPS INT PRIMARY KEY,
    State VARCHAR(50),
    County VARCHAR(100),
    METRO23 TINYINT,
    FOODINSEC_21_23 DECIMAL(5, 2),
    VLFOODSEC_21_23 DECIMAL(5, 2),
    PCT_LACCESS_POP19 DECIMAL(10, 4),
    LACCESS_POP19 DECIMAL(12, 4),
    GROCPTH20 DECIMAL(8, 6),
    CONVSPTH20 DECIMAL(8, 6),
    SUPERCPTH20 DECIMAL(8, 6),
    POVRATE21 DECIMAL(5, 2),
    MEDHHINC21 INT,
    CHILDPOVRATE21 DECIMAL(5, 2),
    PCT_DIABETES_ADULTS19 DECIMAL(5, 2),
    PCT_OBESE_ADULTS22 DECIMAL(5, 2),
    Population DECIMAL(12, 4)
);
CREATE TABLE tract (
    TractFIPS VARCHAR(11) PRIMARY KEY,
    county_FIPS INT,
    StateAbbr VARCHAR(2),
    PlaceName VARCHAR(100),
    PlaceFIPS VARCHAR(10),
    Population2010 INT,
    ACCESS2_Prev DECIMAL(5, 2),
    DIABETES_Prev DECIMAL(5, 2),
    OBESITY_Prev DECIMAL(5, 2),
    CSMOKING_Prev DECIMAL(5, 2),
    BPHIGH_Prev DECIMAL(5, 2),
    MHLTH_Prev DECIMAL(5, 2),
    PCT_65OLDER20 DECIMAL(5, 2),
    FOREIGN KEY (county_FIPS) REFERENCES county(FIPS)
);
-- @block
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/food_enviro_county.csv' INTO TABLE county FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS (
    FIPS,
    State,
    County,
    @METRO23,
    @FOODINSEC_21_23,
    @VLFOODSEC_21_23,
    @CH_FOODINSEC_20_23,
    @CH_VLFOODSEC_20_23,
    @PCT_LACCESS_POP19,
    @LACCESS_POP19,
    @PCT_LACCESS_LOWI19,
    @LACCESS_LOWI19,
    @LACCESS_SNAP19,
    @PCT_LACCESS_SNAP19,
    @GROCPTH20,
    @CONVSPTH20,
    @SUPERCPTH20,
    @POVRATE21,
    @MEDHHINC21,
    @CHILDPOVRATE21,
    @DEEPCHILDPOVRATE21,
    @SNAP_PART_RATE19,
    @SNAPS23,
    @SNAPSPTH23,
    @PCT_SNAP22,
    @PCT_WIC21,
    @LACCESS_CHILD19,
    @PCT_LACCESS_CHILD19,
    @LACCESS_SENIORS19,
    @PCT_LACCESS_SENIORS19,
    @LACCESS_BLACK19,
    @PCT_LACCESS_BLACK19,
    @LACCESS_HISP19,
    @PCT_LACCESS_HISP19,
    @PCT_18YOUNGER20,
    @PCT_65OLDER20,
    @PCT_DIABETES_ADULTS19,
    @PCT_OBESE_ADULTS22,
    @PCH_LACCESS_POP_15_19,
    @Population
)
SET METRO23 = NULLIF(@METRO23, ''),
    FOODINSEC_21_23 = NULLIF(@FOODINSEC_21_23, ''),
    VLFOODSEC_21_23 = NULLIF(@VLFOODSEC_21_23, ''),
    PCT_LACCESS_POP19 = NULLIF(@PCT_LACCESS_POP19, ''),
    LACCESS_POP19 = NULLIF(@LACCESS_POP19, ''),
    GROCPTH20 = NULLIF(@GROCPTH20, ''),
    CONVSPTH20 = NULLIF(@CONVSPTH20, ''),
    SUPERCPTH20 = NULLIF(@SUPERCPTH20, ''),
    POVRATE21 = NULLIF(@POVRATE21, ''),
    MEDHHINC21 = NULLIF(@MEDHHINC21, ''),
    CHILDPOVRATE21 = NULLIF(@CHILDPOVRATE21, ''),
    PCT_DIABETES_ADULTS19 = NULLIF(@PCT_DIABETES_ADULTS19, ''),
    PCT_OBESE_ADULTS22 = NULLIF(@PCT_OBESE_ADULTS22, ''),
    Population = NULLIF(@Population, '');
-- @block
SET FOREIGN_KEY_CHECKS = 0;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cities.csv' IGNORE INTO TABLE tract FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (
    StateAbbr,
    PlaceName,
    PlaceFIPS,
    TractFIPS,
    @Place_TractID,
    Population2010,
    ACCESS2_Prev,
    @ARTHRITIS_Prev,
    @BINGE_Prev,
    BPHIGH_Prev,
    @BPMED_Prev,
    @CANCER_Prev,
    @CASTHMA_Prev,
    @CHD_Prev,
    @CHECKUP_Prev,
    @CHOLSCREEN_Prev,
    @COLON_SCREEN_Prev,
    @COPD_Prev,
    @COREM_Prev,
    @COREW_Prev,
    CSMOKING_Prev,
    @DENTAL_Prev,
    DIABETES_Prev,
    @HIGHCHOL_Prev,
    @KIDNEY_Prev,
    @LPA_Prev,
    @MAMMOUSE_Prev,
    MHLTH_Prev,
    OBESITY_Prev,
    @PAPTEST_Prev,
    @PHLTH_Prev,
    @SLEEP_Prev,
    @STROKE_Prev,
    @TEETHLOST_Prev,
    @Geolocation,
    @ACCESS2_CI_LOW,
    @ACCESS2_CI_HIGH,
    @ARTHRITIS_CI_LOW,
    @ARTHRITIS_CI_HIGH,
    @BINGE_CI_LOW,
    @BINGE_CI_HIGH,
    @BPHIGH_CI_LOW,
    @BPHIGH_CI_HIGH,
    @BPMED_CI_LOW,
    @BPMED_CI_HIGH,
    @CANCER_CI_LOW,
    @CANCER_CI_HIGH,
    @CASTHMA_CI_LOW,
    @CASTHMA_CI_HIGH,
    @CHD_CI_LOW,
    @CHD_CI_HIGH,
    @CHECKUP_CI_LOW,
    @CHECKUP_CI_HIGH,
    @CHOLSCREEN_CI_LOW,
    @CHOLSCREEN_CI_HIGH,
    @COLON_SCREEN_CI_LOW,
    @COLON_SCREEN_CI_HIGH,
    @COPD_CI_LOW,
    @COPD_CI_HIGH,
    @COREM_CI_LOW,
    @COREM_CI_HIGH,
    @COREW_CI_LOW,
    @COREW_CI_HIGH,
    @CSMOKING_CI_LOW,
    @CSMOKING_CI_HIGH,
    @DENTAL_CI_LOW,
    @DENTAL_CI_HIGH,
    @DIABETES_CI_LOW,
    @DIABETES_CI_HIGH,
    @HIGHCHOL_CI_LOW,
    @HIGHCHOL_CI_HIGH,
    @KIDNEY_CI_LOW,
    @KIDNEY_CI_HIGH,
    @LPA_CI_LOW,
    @LPA_CI_HIGH,
    @MAMMOUSE_CI_LOW,
    @MAMMOUSE_CI_HIGH,
    @MHLTH_CI_LOW,
    @MHLTH_CI_HIGH,
    @OBESITY_CI_LOW,
    @OBESITY_CI_HIGH,
    @PAPTEST_CI_LOW,
    @PAPTEST_CI_HIGH,
    @PHLTH_CI_LOW,
    @PHLTH_CI_HIGH,
    @SLEEP_CI_LOW,
    @SLEEP_CI_HIGH,
    @STROKE_CI_LOW,
    @STROKE_CI_HIGH,
    @TEETHLOST_CI_LOW,
    @TEETHLOST_CI_HIGH
)
SET county_FIPS = CAST(LEFT(TractFIPS, 5) AS UNSIGNED),
    PCT_65OLDER20 = NULLIF(@PCT_65OLDER20, '');
SET FOREIGN_KEY_CHECKS = 1;
-- @block orphan cleanup - tracts that don't exist in parent data county
SELECT COUNT(*)
FROM tract;
DELETE FROM tract
WHERE county_FIPS NOT IN (
        SELECT FIPS
        FROM county
    );
-- @block How does each county's diabetes rate rank within its state?
SELECT State,
    County,
    PCT_DIABETES_ADULTS19,
    DENSE_RANK() OVER(
        PARTITION BY State
        ORDER BY PCT_DIABETES_ADULTS19 DESC
    ) AS Diabetes_Rate
FROM county;
-- @block Which counties have the largest gap between their low access rate and their state average?
WITH gap_food_insec AS (
    SELECT State,
        AVG(PCT_LACCESS_POP19) AS avg_pct_laccess
    FROM county
    GROUP BY State
)
SELECT c.State,
    c.County,
    c.PCT_LACCESS_POP19,
    s.avg_pct_laccess,
    c.PCT_LACCESS_POP19 - s.avg_pct_laccess AS gap
FROM county c
    LEFT JOIN gap_food_insec s ON c.state = s.state
ORDER BY gap DESC
LIMIT 10;
-- @block Which states have the greatest disparity in child poverty rate between their best and worst counties?
-- Make a CTE with State, Max and Min
-- We specifically ignore missing values
WITH state_child_pov AS (
    SELECT State,
        MAX(CHILDPOVRATE21) AS max_rate,
        MIN(CHILDPOVRATE21) AS min_rate
    FROM county
    GROUP BY State
)
SELECT State,
    (max_rate - min_rate) AS Disparity
FROM state_child_pov
ORDER BY Disparity DESC
LIMIT 10;
-- @block On average, how spread out are county child poverty rates within each state?
SELECT State,
    STDDEV(CHILDPOVRATE21) AS child_pov_stddev
FROM county
GROUP BY State
ORDER BY child_pov_stddev DESC;
-- @block How do food access metrics differ between counties with high vs. low senior populations?
-- Get average for later
WITH avg_senior AS (
    SELECT AVG(PCT_65OLDER20) AS avg_val
    FROM tract
),
-- Join seniors into county
county_seniors AS (
    SELECT c.State,
        c.County,
        c.PCT_LACCESS_POP19,
        c.GROCPTH20,
        c.SUPERCPTH20,
        c.CONVSPTH20,
        AVG(t.PCT_65OLDER20) AS county_pct_seniors
    FROM county c
        LEFT JOIN tract t ON c.FIPS = t.county_FIPS
    GROUP BY c.State,
        c.County,
        c.PCT_LACCESS_POP19,
        c.GROCPTH20,
        c.SUPERCPTH20,
        c.CONVSPTH20
),
-- Split into above average % seniors and below
senior_groups AS (
    SELECT *,
        CASE
            WHEN county_pct_seniors >= (
                SELECT avg_val
                FROM avg_senior
            ) THEN 'High % Seniors'
            ELSE 'Low % Seniors'
        END AS senior_group
    FROM county_seniors
) -- Final select, get averages grouped by senior %
SELECT senior_group,
    ROUND(AVG(PCT_LACCESS_POP19), 2) AS pct_low_access,
    ROUND(AVG(GROCPTH20), 4) AS grocery_density,
    ROUND(AVG(SUPERCPTH20), 4) AS supermarket_density,
    ROUND(AVG(CONVSPTH20), 4) AS convenience_store_density
FROM senior_groups
GROUP BY senior_group
ORDER BY senior_group DESC;
-- @block Which counties show unexpectedly poor health outcomes relative to their poverty rate?
-- Create deciles
WITH poverty_deciles AS (
    SELECT *,
        NTILE(10) OVER (
            ORDER BY POVRATE21
        ) AS poverty_tier
    FROM county
),
-- Get averages from each tier
tier_averages AS (
    SELECT poverty_tier,
        AVG(PCT_DIABETES_ADULTS19) AS avg_diabetes,
        AVG(PCT_OBESE_ADULTS22) AS avg_obesity
    FROM poverty_deciles
    GROUP BY poverty_tier
),
-- Flag specific counties
flagged_counties AS (
    SELECT p.State,
        p.County,
        p.POVRATE21,
        p.poverty_tier,
        p.PCT_DIABETES_ADULTS19,
        p.PCT_OBESE_ADULTS22,
        t.avg_diabetes,
        t.avg_obesity
    FROM poverty_deciles p
        JOIN tier_averages t ON p.poverty_tier = t.poverty_tier
    WHERE p.PCT_DIABETES_ADULTS19 > t.avg_diabetes
        AND p.PCT_OBESE_ADULTS22 > t.avg_obesity
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (
            PARTITION BY poverty_tier
            ORDER BY PCT_DIABETES_ADULTS19 DESC
        ) AS tier_rank
    FROM flagged_counties
)
SELECT *
FROM ranked
WHERE tier_rank <= 3
ORDER BY poverty_tier,
    tier_rank;
-- @block Which counties deviate most from their poverty tier's expected diabetes rate?
WITH poverty_quintiles AS (
    SELECT *,
        NTILE(5) OVER (
            ORDER BY POVRATE21
        ) AS poverty_tier
    FROM county
),
tier_averages AS (
    SELECT poverty_tier,
        AVG(PCT_DIABETES_ADULTS19) AS avg_diabetes,
        AVG(PCT_OBESE_ADULTS22) AS avg_obesity
    FROM poverty_quintiles
    GROUP BY poverty_tier
),
deviations AS (
    SELECT p.State,
        p.County,
        p.POVRATE21,
        p.poverty_tier,
        p.PCT_DIABETES_ADULTS19,
        p.PCT_OBESE_ADULTS22,
        t.avg_diabetes,
        t.avg_obesity,
        ROUND(p.PCT_DIABETES_ADULTS19 - t.avg_diabetes, 2) AS diabetes_deviation,
        ROUND(p.PCT_OBESE_ADULTS22 - t.avg_obesity, 2) AS obesity_deviation
    FROM poverty_quintiles p
        JOIN tier_averages t ON p.poverty_tier = t.poverty_tier
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (
            PARTITION BY poverty_tier
            ORDER BY diabetes_deviation DESC
        ) AS deviation_rank
    FROM deviations
)
SELECT poverty_tier,
    deviation_rank,
    State,
    County,
    POVRATE21,
    PCT_DIABETES_ADULTS19,
    avg_diabetes,
    diabetes_deviation
FROM ranked
WHERE deviation_rank <= 3
ORDER BY poverty_tier,
    deviation_rank;
-- @block 
SELECT *
FROM county;
-- @block 
SELECT *
FROM tract;
