WITH total_sales_2015 AS (
    SELECT
        region,
        SUM(sales_volume) AS total_sales_15
    FROM
        car_engine_sales
    WHERE	
        year = 2015 
    GROUP BY 
        region, year
),
total_sales_2025 AS (
    SELECT
        region,
        SUM(sales_volume) AS total_sales_25
    FROM
        car_engine_sales
    WHERE	
        year = 2025 
    GROUP BY 
        region, year
)
SELECT	
    total_sales_2015.region,
    ROUND((1.0 * (total_sales_2025.total_sales_25 - total_sales_2015.total_sales_15)) / (1.0 * total_sales_2015.total_sales_15), 5) * 100 AS sales_growth_percentage_2015_2025
FROM
    total_sales_2025 
JOIN total_sales_2015 ON total_sales_2015.region = total_sales_2025.region;