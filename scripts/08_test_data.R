library(DBI)
library(RSQLite)

# Create a temporary SQLite database
con <- dbConnect(SQLite(), ":memory:")

# Step 1: Create the 'product' table
dbExecute(con, "
CREATE TABLE product (
    id INTEGER PRIMARY KEY,
    product_name TEXT,
    brand TEXT,
    vendor TEXT
);
")

# Insert data into the 'product' table
dbExecute(con, "
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
")

# Step 2: Create the 'raw' table
dbExecute(con, "
CREATE TABLE raw (
    nowtime DATETIME,
    product_id INTEGER,
    current_price REAL,
    old_price REAL,
    price_per_unit REAL,
    other TEXT
);
")

# Insert data into the 'raw' table using a recursive query
dbExecute(con, "
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
    ABS(RANDOM() % 10) + 1 AS product_id,
    ROUND(RANDOM() % 100 + 1, 2) AS current_price,
    ROUND(RANDOM() % 100 + 1, 2) AS old_price,
    ROUND(RANDOM() % 10 + 0.1, 2) AS price_per_unit,
    CASE (RANDOM() % 3)
        WHEN 0 THEN 'Info A'
        WHEN 1 THEN 'Info B'
        ELSE 'Info C'
    END AS other
FROM series;
")

# Step 3: Perform the analysis
result <- dbGetQuery(con, "
SELECT 
    p.vendor,
    ROUND(AVG(r.current_price), 2) AS avg_price
FROM raw r
JOIN product p
    ON r.product_id = p.id
GROUP BY p.vendor
ORDER BY avg_price DESC;
")

# View the result
print(result)

# Disconnect
dbDisconnect(con)
