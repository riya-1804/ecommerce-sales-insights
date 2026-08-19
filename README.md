# E-Commerce Sales & Customer Insights Dashboard

An end-to-end data analytics project using a relational SQL database and Power BI to analyze customer purchase behavior, regional performance, and product profitability.

## 📊 Project Overview
This project contains a normalized database schema representing an e-commerce platform. Using the data, I built a relational model in Power BI, created custom measures using DAX, and designed a dashboard to unlock insights for business executives.

## 🗄️ Database Schema & Star Schema
The project uses a **Star Schema** to optimize query performance and reporting speeds:
* **Fact Table:** `Orders` (OrderID, OrderDate, CustomerID, ProductID, RegionID, Quantity, Discount)
* **Dimension Tables:**
  * `Customers` (CustomerID, CustomerName, Email, Segment, JoinDate)
  * `Products` (ProductID, ProductName, Category, SubCategory, UnitPrice, UnitCost)
  * `Regions` (RegionID, City, State, Country)

## 📈 Power BI Measures (DAX)
Key metrics calculated using DAX:
* **Total Revenue:**
  `Total Revenue = SUMX(Orders, Orders[Quantity] * RELATED(Products[UnitPrice]) * (1 - Orders[Discount]))`
* **Total Profit:**
  `Total Profit = [Total Revenue] - SUMX(Orders, Orders[Quantity] * RELATED(Products[UnitCost]))`
* **Profit Margin (%):**
  `Profit Margin = DIVIDE([Total Profit], [Total Revenue], 0)`

## ⚙️ How to Setup
1. **SQL Database:** Run the scripts in `schema.sql` to build the tables and load sample data. Run queries in `queries.sql` to see raw analysis.
2. **Power BI:** Load the SQL tables into Power BI Desktop. Ensure relationships are configured as 1-to-many from dimensions to the fact table. Copy and paste the DAX formulas into your measures.
