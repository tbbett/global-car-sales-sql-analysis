WITH total_sales_2015 AS (
    SELECT
        region,
        engine_type,
        SUM(sales_volume) AS total_sales_15
    FROM
        car_engine_sales
    WHERE	
        year = 2015 
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
        year = 2025 
    GROUP BY 
        region, engine_type, year
)
SELECT	
    total_sales_2025.region,
    total_sales_2025.engine_type,
    CASE 
        WHEN COALESCE(total_sales_2015.total_sales_15, 0) = 0 THEN 'Undefined'
        ELSE ROUND((1.0 * (total_sales_2025.total_sales_25 - total_sales_2015.total_sales_15)) / (1.0 * total_sales_2015.total_sales_15), 5) * 100 
    END AS sales_growth_percentage_2015_2025
FROM
    total_sales_2025
LEFT JOIN total_sales_2015 ON total_sales_2015.region = total_sales_2025.region AND total_sales_2015.engine_type = total_sales_2025.engine_type
GROUP BY
    total_sales_2025.region, total_sales_2025.engine_type
ORDER BY
    total_sales_2025.region, sales_growth_percentage_2015_2025 DESC;