SELECT
    SUM(sales_volume) AS total_sales, 
    year
FROM
    car_engine_sales
WHERE	
    year = 2015 OR year = 2025
GROUP BY 
    year
ORDER BY 
    total_sales DESC;