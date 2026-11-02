WITH regional_sales_2015_query AS (
    SELECT
        main_q.region,
        SUM(sales_volume) AS total_regional_sales_2015,
        year
    FROM
        car_engine_sales AS main_q
    WHERE
        year = 2015
    GROUP BY 
        year, main_q.region
)
SELECT
    main_q.region,
    main_q.engine_type,
    ROUND((1.0 * SUM(main_q.sales_volume)) / (1.0 * helper_q.total_regional_sales_2015), 2) * 100 AS regional_sales_percentage_2015,
    main_q.year
FROM
    car_engine_sales AS main_q
JOIN regional_sales_2015_query AS helper_q ON main_q.region = helper_q.region
WHERE
    main_q.year = 2015
GROUP BY 
    main_q.year, main_q.region, main_q.engine_type
ORDER BY 
    main_q.region, regional_sales_percentage_2015 DESC;