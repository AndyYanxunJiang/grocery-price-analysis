-- 00_load_hammer_db.sql

-- Attach the SQLite database file using the full path to your Downloads folder
ATTACH DATABASE '/Users/y4nxunj/Downloads/hammer-2-processed.sqlite' AS hammer_db;

-- Verify that tables are loaded correctly
SELECT name 
FROM hammer_db.sqlite_master 
WHERE type = 'table';

-- Check the structure of the 'raw' table
PRAGMA table_info(hammer_db.raw);

-- Check the structure of the 'product' table
PRAGMA table_info(hammer_db.product);

-- Display the first 10 rows of 'raw' to preview data
SELECT * 
FROM hammer_db.raw 
LIMIT 10;

-- Display the first 10 rows of 'product' to preview data
SELECT * 
FROM hammer_db.product 
LIMIT 10;
