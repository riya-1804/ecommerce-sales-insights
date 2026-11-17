-- Adds 500 synthetic orders (OrderID 2001-2500) to the 10 sample orders in schema.sql.
-- Run once, after schema.sql. Data is randomly generated for practice only.
WITH RECURSIVE seq(n) AS (
  SELECT 1 UNION ALL SELECT n + 1 FROM seq WHERE n < 500
)
INSERT INTO Orders (OrderID, OrderDate, CustomerID, ProductID, RegionID, Quantity, Discount)
SELECT
  2000 + n,
  date('2026-01-01', '+' || (abs(random()) % 320) || ' days'),
  (SELECT CustomerID FROM Customers WHERE n > 0 ORDER BY random() LIMIT 1),
  (SELECT ProductID FROM Products WHERE n > 0 ORDER BY random() LIMIT 1),
  (SELECT RegionID FROM Regions WHERE n > 0 ORDER BY random() LIMIT 1),
  1 + (abs(random()) % 5),
  CASE abs(random()) % 4 WHEN 0 THEN 0.00 WHEN 1 THEN 0.05 WHEN 2 THEN 0.10 ELSE 0.15 END
FROM seq;