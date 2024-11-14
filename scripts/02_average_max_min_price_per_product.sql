-- 02_average_max_min_price_per_product.sql

WITH uniquedates AS (
    SELECT DISTINCT 
        DATE(r.nowtime) AS date, 
        r.current_price, 
        r.product_id 
    FROM
        hammer_db.raw AS r
),
stats AS (
    SELECT
        product_id,
        MAX(current_price) AS max_price,
        MIN(current_price) AS min_price,
        AVG(current_price) AS avg_price,
        COUNT(current_price) AS price_count
    FROM
        uniquedates
    GROUP BY
        product_id
)
SELECT
    p.id,
    p.vendor,
    p.product_name,
    p.units,
    p.brand,
    s.max_price,
    s.min_price,
    s.avg_price,
    s.price_count
FROM
    stats AS s
INNER JOIN
    hammer_db.product AS p ON s.product_id = p.id;
