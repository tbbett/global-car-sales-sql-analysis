SELECT
    region,
    engine_type,
    SUM(sales_volume) AS total_sales_2017
FROM
    car_engine_sales
WHERE	
    year = 2017 AND region = 'Europe'
GROUP BY 
    engine_type, region, year
ORDER BY 
    region, total_sales_2017 DESC;