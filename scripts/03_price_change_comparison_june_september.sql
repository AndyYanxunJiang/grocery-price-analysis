-- 03_price_change_comparison_june_september.sql

WITH startend_diffrows AS (
    SELECT
        p.id,
        p.vendor,
        p.product_name,
        p.brand,
        p.units,
        r.nowtime,
        CASE 
            WHEN r.nowtime LIKE '2024-06-11%' THEN r.current_price 
        END AS start_price,
        CASE
            WHEN r.nowtime LIKE '2024-09-17%' THEN r.current_price 
        END AS end_price
    FROM
        hammer_db.product AS p
    INNER JOIN 
        hammer_db.raw AS r ON r.product_id = p.id
    WHERE
        r.nowtime LIKE '2024-06-11%' OR r.nowtime LIKE '2024-09-17%'
),
startend_pivoted AS (
    SELECT 
        id, 
        vendor, 
        product_name, 
        units, 
        brand, 
        MAX(start_price) AS june_price, 
        MAX(end_price) AS sept_price 
    FROM
        startend_diffrows
    GROUP BY 
        id
)
SELECT 
    vendor,
    product_name,
    brand,
    units,
    june_price,
    sept_price,
    (sept_price - june_price) AS price_change
FROM 
    startend_pivoted
WHERE 
    june_price IS NOT NULL AND sept_price IS NOT NULL;
