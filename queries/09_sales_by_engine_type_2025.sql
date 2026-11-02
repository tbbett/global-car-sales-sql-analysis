SELECT
    SUM(sales_volume) AS total_sales_by_engine,
    engine_type
FROM
    car_engine_sales
WHERE
    year = 2025
GROUP BY
    engine_type, year;