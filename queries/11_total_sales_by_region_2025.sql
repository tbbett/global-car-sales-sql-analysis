SELECT
    region,
    SUM(sales_volume) AS total_regional_sales_2025
FROM 
    car_engine_sales
WHERE	
    year = 2025
GROUP BY
    region
ORDER BY
    total_regional_sales_2025 DESC;