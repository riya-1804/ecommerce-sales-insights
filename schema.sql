-- E-Commerce Sales & Customer Insights Database Setup
-- Compatible with SQLite, MySQL, and PostgreSQL

-- Drop tables if they exist to allow clean re-runs
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Regions;

-- 1. Create Dimension Tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Segment VARCHAR(50), -- Corporate, Consumer, Home Office
    JoinDate DATE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    SubCategory VARCHAR(50),
    UnitPrice DECIMAL(10, 2) NOT NULL,
    UnitCost DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Regions (
    RegionID INT PRIMARY KEY,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100),
    Country VARCHAR(100)
);

-- 2. Create Fact Table (Orders)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT,
    ProductID INT,
    RegionID INT,
    Quantity INT NOT NULL,
    Discount DECIMAL(4, 2) DEFAULT 0.00,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

-- 3. Insert Sample Data
INSERT INTO Customers (CustomerID, CustomerName, Email, Segment, JoinDate) VALUES 
(101, 'Aarav Sharma', 'aarav.sharma@email.com', 'Consumer', '2025-01-15'),
(102, 'Priya Patel', 'priya.patel@email.com', 'Corporate', '2025-03-20'),
(103, 'Amit Verma', 'amit.verma@email.com', 'Consumer', '2025-05-10'),
(104, 'Ananya Iyer', 'ananya.iyer@email.com', 'Home Office', '2025-06-01'),
(105, 'Vikram Singh', 'vikram.singh@email.com', 'Corporate', '2025-07-15'),
(106, 'Kavita Rao', 'kavita.rao@email.com', 'Consumer', '2025-08-11');

INSERT INTO Products (ProductID, ProductName, Category, SubCategory, UnitPrice, UnitCost) VALUES 
(501, 'Ergonomic Office Chair', 'Furniture', 'Chairs', 150.00, 90.00),
(502, 'Mechanical Wireless Keyboard', 'Technology', 'Accessories', 45.00, 20.00),
(503, 'Noise Cancelling Headphones', 'Technology', 'Audio', 200.00, 110.00),
(504, 'Adjustable Standing Desk', 'Furniture', 'Tables', 350.00, 210.00),
(505, 'UltraWide 34-Inch Monitor', 'Technology', 'Monitors', 400.00, 260.00);

INSERT INTO Regions (RegionID, City, State, Country) VALUES 
(1, 'Bengaluru', 'Karnataka', 'India'),
(2, 'Mumbai', 'Maharashtra', 'India'),
(3, 'Delhi', 'NCR', 'India'),
(4, 'Hyderabad', 'Telangana', 'India');

INSERT INTO Orders (OrderID, OrderDate, CustomerID, ProductID, RegionID, Quantity, Discount) VALUES 
(1001, '2026-01-10', 101, 501, 1, 2, 0.10),
(1002, '2026-01-12', 102, 502, 2, 5, 0.00),
(1003, '2026-02-15', 103, 503, 3, 1, 0.05),
(1004, '2026-02-18', 101, 504, 1, 1, 0.00),
(1005, '2026-03-01', 104, 502, 2, 3, 0.15),
(1006, '2026-03-05', 102, 503, 2, 2, 0.00),
(1007, '2026-03-12', 105, 505, 4, 1, 0.10),
(1008, '2026-04-02', 106, 501, 1, 1, 0.00),
(1009, '2026-04-15', 103, 502, 3, 2, 0.00),
(1010, '2026-05-01', 101, 505, 1, 1, 0.05);
