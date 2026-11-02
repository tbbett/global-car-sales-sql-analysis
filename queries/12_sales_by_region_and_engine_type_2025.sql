SELECT
    region,
    engine_type,
    SUM(sales_volume) AS regional_sales_2025,
    year
FROM
    car_engine_sales
WHERE
    year = 2025
GROUP BY 
    year, region, engine_type
ORDER BY 
    region, regional_sales_2025 DESC;