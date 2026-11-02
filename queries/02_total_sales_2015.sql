SELECT
    SUM(sales_volume) AS total_sales_2015
FROM
    car_engine_sales
WHERE	
    year = 2015
GROUP BY 
    year;