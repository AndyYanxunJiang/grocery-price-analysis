-- 04_sales_frequency_by_product.sql

SELECT 
    p.product_name,
    p.vendor,
    COUNT(r.old_price) AS sale_count
FROM 
    hammer_db.product AS p
INNER JOIN 
    hammer_db.raw AS r ON p.id = r.product_id
WHERE 
    r.old_price IS NOT NULL
GROUP BY 
    p.product_name, p.vendor
ORDER BY 
    sale_count DESC;
