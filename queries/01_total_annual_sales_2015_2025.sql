SELECT
    ROUND(SUM(sales_volume), 2) AS total_annual_sales,
    year
FROM 
    car_engine_sales
GROUP BY
    year
ORDER BY 
    year DESC;