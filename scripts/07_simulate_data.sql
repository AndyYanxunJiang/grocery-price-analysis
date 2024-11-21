-- Create the `raw` table
CREATE TABLE raw (
    nowtime DATETIME,
    product_id INTEGER,
    current_price REAL,
    old_price REAL,
    price_per_unit REAL,
    other TEXT
);

-- Create the `product` table
CREATE TABLE product (
    id INTEGER PRIMARY KEY,
    product_name TEXT,
    brand TEXT,
    vendor TEXT
);

-- Populate the `product` table
INSERT INTO product (id, product_name, brand, vendor) VALUES
(1, 'Product 1', 'Brand X', 'Vendor A'),
(2, 'Product 2', 'Brand Y', 'Vendor B'),
(3, 'Product 3', 'Brand Z', 'Vendor C'),
(4, 'Product 4', 'Brand X', 'Vendor D'),
(5, 'Product 5', 'Brand Y', 'Vendor A'),
(6, 'Product 6', 'Brand Z', 'Vendor B'),
(7, 'Product 7', 'Brand X', 'Vendor C'),
(8, 'Product 8', 'Brand Y', 'Vendor D'),
(9, 'Product 9', 'Brand Z', 'Vendor A'),
(10, 'Product 10', 'Brand X', 'Vendor B');

-- Populate the `raw` table using recursive CTE
WITH RECURSIVE series(x) AS (
    SELECT 1
    UNION ALL
    SELECT x + 1
    FROM series
    WHERE x <= 1000
)
INSERT INTO raw (nowtime, product_id, current_price, old_price, price_per_unit, other)
SELECT 
    DATETIME('2024-01-01 00:00:00', '+' || (x - 1) || ' hours') AS nowtime,
    ABS(RANDOM() % 10) + 1 AS product_id,  -- Random product_id between 1 and 10
    ROUND((RANDOM() % 100 + 1) * 1.0, 2) AS current_price,  -- Random price between 1 and 100
    ROUND((RANDOM() % 100 + 1) * 1.0, 2) AS old_price,  -- Random price between 1 and 100
    ROUND((RANDOM() % 10 + 1) * 1.0, 2) AS price_per_unit,  -- Random price per unit between 0.1 and 10
    CASE (RANDOM() % 3)
        WHEN 0 THEN 'Info A'
        WHEN 1 THEN 'Info B'
        ELSE 'Info C'
    END AS other
FROM series;

-- Analysis query: Calculate average price by vendor
SELECT 
    p.vendor,
    ROUND(AVG(r.current_price), 2) AS avg_price
FROM raw r
JOIN product p
    ON r.product_id = p.id
GROUP BY p.vendor
ORDER BY avg_price DESC;
