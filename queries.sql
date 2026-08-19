-- E-Commerce Sales & Customer Insights Analytical Queries

-- 1. Revenue & Profit Margin by Product Category
-- Aligns with "Total Sales and Total Profit by Product Category"
SELECT 
    p.Category,
    ROUND(SUM(o.Quantity * p.UnitPrice * (1 - o.Discount)), 2) AS TotalRevenue,
    ROUND(SUM((o.Quantity * p.UnitPrice * (1 - o.Discount)) - (o.Quantity * p.UnitCost)), 2) AS TotalProfit,
    ROUND(
        (SUM((o.Quantity * p.UnitPrice * (1 - o.Discount)) - (o.Quantity * p.UnitCost)) / 
         SUM(o.Quantity * p.UnitPrice * (1 - o.Discount))) * 100, 
        2
    ) AS ProfitMarginPercentage
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalProfit DESC;

-- 2. Customer Cohort & RFM Metrics (Recency, Frequency, Monetary)
-- Identifies high-value customers and their buying behavior
SELECT 
    c.CustomerName,
    c.Segment,
    MAX(o.OrderDate) AS LastPurchaseDate,
    COUNT(o.OrderID) AS OrderCount,
    ROUND(SUM(o.Quantity * p.UnitPrice * (1 - o.Discount)), 2) AS TotalMonetaryValue,
    ROUND(AVG(o.Quantity * p.UnitPrice * (1 - o.Discount)), 2) AS AverageOrderValue
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerName, c.Segment
ORDER BY TotalMonetaryValue DESC;

-- 3. Regional Performance Analysis
-- Highlights underperforming sales states and regions
SELECT 
    r.City,
    r.State,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.Quantity) AS UnitsSold,
    ROUND(SUM(o.Quantity * p.UnitPrice * (1 - o.Discount)), 2) AS TotalSales
FROM Orders o
JOIN Regions r ON o.RegionID = r.RegionID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY r.City, r.State
ORDER BY TotalSales DESC;
