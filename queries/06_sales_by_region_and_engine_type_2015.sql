SELECT
    region,
    engine_type,
    SUM(sales_volume) AS regional_sales_2015,
    year
FROM
    car_engine_sales
WHERE
    year = 2015
GROUP BY 
    year, region, engine_type
ORDER BY 
    region, regional_sales_2015 DESC;