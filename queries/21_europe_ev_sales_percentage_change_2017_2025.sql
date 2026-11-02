WITH total_sales_2017 AS (
    SELECT
        region,
        engine_type,
        SUM(sales_volume) AS total_sales_17
    FROM
        car_engine_sales
    WHERE	
        year = 2017 AND engine_type = 'EV' AND region = 'Europe'
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
        year = 2025 AND engine_type = 'EV' AND region = 'Europe'
    GROUP BY 
        region, engine_type, year
)
SELECT	
    total_sales_2025.region,
    total_sales_2025.engine_type,
    ROUND((1.0 * (total_sales_2025.total_sales_25 - total_sales_2017.total_sales_17)) / (1.0 * total_sales_2017.total_sales_17), 5) * 100 AS sales_growth_percentage_2017_2025
FROM
    total_sales_2025
LEFT JOIN total_sales_2017 ON total_sales_2017.region = total_sales_2025.region AND total_sales_2017.engine_type = total_sales_2025.engine_type
GROUP BY
    total_sales_2025.region, total_sales_2025.engine_type
ORDER BY
    total_sales_2025.region, sales_growth_percentage_2017_2025 DESC;