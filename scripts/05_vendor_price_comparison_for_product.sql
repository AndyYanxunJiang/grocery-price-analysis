-- 05_vendor_price_comparison_for_product.sql

SELECT 
    p.vendor,
    p.product_name,
    p.brand,
    r.current_price,
    r.nowtime
FROM 
    hammer_db.product AS p
INNER JOIN 
    hammer_db.raw AS r ON p.id = r.product_id
WHERE 
    p.product_name LIKE '%milk%'  -- Replace 'milk' with any specific product name
ORDER BY 
    p.vendor, r.nowtime;
