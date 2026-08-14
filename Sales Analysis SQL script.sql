-- Retrieve all records from sales table
SELECT * FROM sales;

-- Performance by Product Line (with Grand Total)
SELECT PRODUCTLINE, SUM(SALES) AS Total_Sales, AVG(SALES) AS Average_Sales, COUNT(ORDERNUMBER) AS Number_of_Orders
FROM sales 
GROUP BY PRODUCTLINE
UNION ALL
SELECT 'Grand Total', SUM(SALES), AVG(SALES), COUNT(ORDERNUMBER) 
FROM sales;

-- Year-wise Performance (with Grand Total)
SELECT CAST(YEAR_ID AS CHAR) AS YEAR_ID, SUM(SALES) AS Total_Sales, AVG(SALES) AS Average_Sales, COUNT(ORDERNUMBER) AS Number_of_Orders
FROM sales 
GROUP BY YEAR_ID
UNION ALL
SELECT 'Grand Total', SUM(SALES), AVG(SALES), COUNT(ORDERNUMBER) 
FROM sales;

-- Quarterly Sales Trend 
SELECT YEAR_ID, QTR_ID, ROUND(SUM(SALES), 3) AS Total_Sales, ROUND(AVG(SALES), 3) AS Average_Sales, COUNT(ORDERNUMBER) AS Number_of_Orders
FROM sales 
GROUP BY YEAR_ID, QTR_ID 
ORDER BY YEAR_ID, QTR_ID;

-- Quarterly and Status-wise Sales Trend
SELECT YEAR_ID, QTR_ID, STATUS, ROUND(SUM(SALES), 3) AS Total_Sales, ROUND(AVG(SALES), 3) AS Average_Sales, COUNT(ORDERNUMBER) AS Number_of_Orders
FROM sales 
GROUP BY YEAR_ID, QTR_ID, STATUS 
ORDER BY YEAR_ID, QTR_ID, STATUS;

-- Top 5 Customers by Revenue
SELECT CUSTOMERNAME, SUM(SALES) AS Sales_Amount, COUNT(ORDERNUMBER) AS Orders 
FROM sales 
GROUP BY CUSTOMERNAME 
ORDER BY Sales_Amount DESC 
LIMIT 5;

-- Number of Orders based on Deal Size
SELECT DEALSIZE, COUNT(ORDERNUMBER) AS Orders 
FROM sales 
GROUP BY DEALSIZE;

-- Average Price vs Quantity Ordered
SELECT QUANTITYORDERED, AVG(PRICEEACH) AS Avg_Price 
FROM sales 
GROUP BY QUANTITYORDERED 
ORDER BY QUANTITYORDERED;

-- Top 3 Best Selling Product Lines (Shipped Status)
SELECT PRODUCTLINE, COUNT(ORDERNUMBER) AS Shipped_Orders 
FROM sales 
WHERE STATUS = 'Shipped' 
GROUP BY PRODUCTLINE 
ORDER BY Shipped_Orders DESC 
LIMIT 3;

-- Top 5 Countries by Revenue
SELECT COUNTRY, SUM(SALES) AS Total_Revenue, AVG(SALES) AS Average_Revenue, COUNT(ORDERNUMBER) AS Orders_Quantity
FROM sales 
GROUP BY COUNTRY 
ORDER BY Total_Revenue DESC 
LIMIT 5;

-- Top 10 Cities by Revenue
SELECT CITY, SUM(SALES) AS Total_Revenue, AVG(SALES) AS Average_Revenue, COUNT(ORDERNUMBER) AS Orders_Quantity
FROM sales 
GROUP BY CITY 
ORDER BY Total_Revenue DESC 
LIMIT 10;

-- Region-wise Customer Distribution
SELECT COUNTRY, COUNT(DISTINCT CUSTOMERNAME) AS Customer_Count 
FROM sales 
GROUP BY COUNTRY 
ORDER BY Customer_Count DESC;

-- Order Status Analysis: Counts
SELECT STATUS, COUNT(*) AS Order_Count 
FROM sales 
GROUP BY STATUS;

-- Order Status Analysis: Percentage Distribution
SELECT 
    a.STATUS, 
    COUNT(a.ORDERNUMBER) AS Status_Count,
    ROUND((COUNT(a.ORDERNUMBER) / b.Total_Orders) * 100, 2) AS Percentage_Share
FROM sales a
CROSS JOIN (SELECT COUNT(*) AS Total_Orders FROM sales) b 
GROUP BY a.STATUS, b.Total_Orders;