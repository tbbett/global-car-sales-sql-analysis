SELECT
    ROUND(1.0 * SUM(sales_volume) / (SELECT 1.0 * SUM(sales_volume) FROM car_engine_sales WHERE year = 2025 GROUP BY year) * 100, 2) AS engine_market_share_percentage,
    engine_type
FROM
    car_engine_sales
WHERE
    year = 2025
GROUP BY
    engine_type
ORDER BY 
    engine_market_share_percentage DESC;