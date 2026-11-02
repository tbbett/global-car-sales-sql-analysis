WITH total_sales_2017 AS (
    SELECT
        region,
        engine_type,
        SUM(sales_volume) AS total_sales_17  
    FROM
        car_engine_sales
    WHERE	
        year = 2017 AND region = 'Europe' AND engine_type = 'EV' 
    GROUP BY 
        region, engine_type, year
),
total_sales_2025 AS (
    SELECT
        region,
        engine_type,
        SUM(sales_volume) AS total_sales_25
    FROM
        car_engine_sales
    WHERE	
        year = 2025 AND region = 'Europe' AND engine_type = 'EV' 
    GROUP BY 
        region, engine_type, year
)
SELECT	
    total_sales_2025.region AS region,
    total_sales_2025.engine_type AS engine_type,
    total_sales_2025.total_sales_25 - COALESCE(total_sales_2017.total_sales_17, 0) AS sales_difference_2017_2025
FROM
    total_sales_2025
LEFT JOIN total_sales_2017 ON total_sales_2017.region = total_sales_2025.region AND total_sales_2017.engine_type = total_sales_2025.engine_type
GROUP BY
    total_sales_2025.region, total_sales_2025.engine_type
ORDER BY
    total_sales_2025.region, sales_difference_2017_2025 DESC;