-- Check if 'raw' and 'product' tables exist in the database
SELECT name 
FROM sqlite_master 
WHERE type = 'table';

-- Check the structure of the 'raw' table
PRAGMA table_info(raw);

-- Check the structure of the 'product' table
PRAGMA table_info(product);

-- Basic join to test if the tables can be joined successfully
SELECT 
    r.nowtime, 
    p.vendor
FROM 
    raw AS r
INNER JOIN 
    product AS p ON r.product_id = p.id
LIMIT 10;

-- Full join query to create a combined view of raw and product tables
SELECT 
    r.nowtime, 
    p.vendor, 
    r.product_id, 
    p.product_name, 
    p.brand, 
    r.current_price, 
    r.old_price, 
    p.units, 
    r.price_per_unit, 
    r.other 
FROM 
    raw AS r
INNER JOIN 
    product AS p ON r.product_id = p.id
ORDER BY 
    r.nowtime;
