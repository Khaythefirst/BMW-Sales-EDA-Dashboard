-- Data Cleaning

SELECT *
FROM `bmw sales data (2010-2024)`;

CREATE TABLE bmw_sales_data
LIKE `bmw sales data (2010-2024)`;


SELECT *
FROM bmw_sales_data;

INSERT INTO bmw_sales_data
SELECT *
FROM `bmw sales data (2010-2024)`;

-- Removing Duplicates 

SELECT *,
row_number() OVER (partition by Model, Year, Region, Color, Fuel_Type, Transmission, Engine_Size_L, Mileage_KM, Price_USD,Sales_Volume, Sales_Classification) AS Row_num
FROM bmw_sales_data;


WITH Duplicate_data AS
(
SELECT *,
row_number() OVER (partition by Model, `Year`, Region, Color, Fuel_Type, Transmission, Engine_Size_L, Mileage_KM, Price_USD,Sales_Volume, Sales_Classification) AS Row_num
FROM bmw_sales_data
)
SELECT *
FROM Duplicate_data
WHERE Row_num > 1;


-- Standardizing the Data

SELECT Model, TRIM(Model)
FROM bmw_sales_data
;

UPDATE bmw_sales_data
SET Model = TRIM(Model);

SELECT distinct Model
FROM bmw_sales_data
order by 1;

SELECT *
FROM bmw_sales_data;

-- EXPLORATORY ANALYSIS

-- BASIC AGGRETATIONS --

-- Total sales volume across all years (1)
SELECT SUM(Sales_Volume) AS Total_sales
FROM bmw_sales_data;

-- Total revenue across all years (2)
SELECT SUM( Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data;

-- Yearly sales volume (3)
SELECT Year, SUM(Sales_Volume) AS Total_sales
FROM bmw_sales_data
GROUP BY Year
ORDER BY Year DESC;

-- MODEL PERFORMANCE --

-- Total sales per model (4)
SELECT Model, SUM(Sales_Volume) AS Total_sales
FROM bmw_sales_data
GROUP BY Model
ORDER BY Total_sales desc;

-- Top-selling model per year (5)
WITH ranked AS
(
SELECT Model, Year, SUM(Sales_Volume) AS Total_sales, DENSE_RANK() OVER(PARTITION BY Year ORDER BY SUM(Sales_Volume) desc) AS Ranking
FROM bmw_sales_data
GROUP BY Model, Year
)
SELECT Model, Year, Total_sales
FROM ranked
WHERE Ranking = 1;

-- Revenue per model (6)
 SELECT MODEL, SUM( Price_USD * Sales_Volume) AS Total_revenue
 FROM bmw_sales_data
 GROUP BY MODEL
 ORDER BY Total_revenue desc;


-- Regional Analysis --

-- Sales volume by region (7)
SELECT Region, SUM(Sales_Volume) AS Total_sales
FROM bmw_sales_data
GROUP BY Region
ORDER BY Total_sales desc;

-- Revenue by region (8)
SELECT Region, SUM( Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data
GROUP BY Region
ORDER BY Total_revenue desc;

-- Top 3 models per region by revenue (9)
WITH ranked AS
(
SELECT Region, Model, SUM( Price_USD * Sales_Volume) AS Total_revenue,
DENSE_RANK() OVER(PARTITION BY Region ORDER BY SUM( Price_USD * Sales_Volume) DESC) Ranking
FROM bmw_sales_data
GROUP BY Region, Model
)
SELECT *
FROM ranked
WHERE Ranking <= 3;


-- Trends & Comparisons --

-- Yearly revenue trend per model (10)
SELECT Year, Model, SUM( Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data
GROUP BY Year, Model
ORDER BY Year, Total_revenue desc;

-- Year-over-year growth in sales (11)
SELECT Year, SUM(Sales_Volume) AS Total_sales,
lAG(SUM(Sales_Volume)) OVER(ORDER BY Year) AS Previous_year_sales,
SUM(Sales_Volume) - lAG(SUM(Sales_Volume)) OVER(ORDER BY Year) AS Growth_per_year
FROM bmw_sales_data
GROUP BY Year
ORDER BY Year;

-- Average selling price per model (12)
SELECT Model, AVG(Price_USD) AS Avg_price
FROM bmw_sales_data
GROUP BY Model
ORDER BY Avg_price desc;

-- FOR THE DASHBOARD

-- Top Models by Revenue
SELECT Model, SUM( Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data
GROUP BY Model
ORDER BY Total_revenue desc;

-- Regional Market Share
WITH region_sales AS
(
SELECT Region, Model, SUM(Sales_Volume) AS Model_sales
FROM bmw_sales_data
GROUP BY Region, Model
),
total_region_sales AS
(
SELECT Region, SUM(Model_sales) AS Region_total
FROM region_sales
GROUP BY Region
)
SELECT r.Region, r.Model, r.Model_sales, Round((r.Model_sales * 100 / t.Region_total), 2) AS Market_Share_Percent
FROM region_sales AS r
JOIN total_region_sales AS t
	ON r.Region = t.Region
ORDER BY r.Region, Market_Share_Percent DESC;

-- Average Price by Region
SELECT Region, SUM(Price_USD * Sales_Volume) / SUM(Sales_Volume) AS avg_price
FROM bmw_sales_data
GROUP BY Region
ORDER BY avg_price DESC;

-- Global Bestseller
SELECT Model, SUM(Sales_Volume) AS Total_sales
FROM bmw_sales_data
GROUP BY Model
ORDER BY Total_sales desc;

-- Growth rate YoY per model
WITH yearly_revenue AS
(
SELECT Model, Year, SUM(Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data
GROUP BY Model, Year
)
SELECT Model, Year, Total_revenue,
	LAG(Total_revenue) OVER (PARTITION BY Model ORDER BY year) AS Prev_year_revenue,
    ROUND((Total_revenue - LAG(Total_revenue) OVER (PARTITION BY Model ORDER BY year)) / LAG(Total_revenue) OVER (PARTITION BY Model ORDER BY year) * 100, 2) AS YoY_growth_percentage
FROM yearly_revenue
ORDER BY Model, Year;


-- Yearly Revenue (3)
SELECT Year, SUM( Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data
GROUP BY Year
ORDER BY Total_revenue DESC;

-- Yearly Model Revenue
SELECT Model, Year, SUM( Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data
GROUP BY Model, Year
ORDER BY Total_revenue desc;

-- Highest Revenue Year
SELECT Year, SUM( Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data
GROUP BY Year
ORDER BY Year DESC
LIMIT 1;

-- Revenue per region in percentage
SELECT Region, SUM(Price_USD * Sales_Volume) AS revenue,
    ROUND(SUM(Price_USD * Sales_Volume) / (SELECT SUM(Price_USD * Sales_Volume) FROM bmw_sales_data) * 100, 2) AS revenue_percentage
FROM bmw_sales_data
GROUP BY Region
ORDER BY revenue_percentage DESC;


-- Top revenue year
SELECT Year, SUM( Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data
GROUP BY Year
ORDER BY Total_revenue DESC
LIMIT 1;

-- YOY Per Region and Model
WITH yearly_revenue AS
(
SELECT Region, Model, Year, SUM(Sales_Volume) AS Total_sales, SUM(Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data
GROUP BY Region, Model, Year
)
SELECT Region, Model, Year, Total_revenue,
	LAG(Total_revenue) OVER (PARTITION BY Region ORDER BY year) AS Prev_year_revenue,
    ROUND((Total_revenue - LAG(Total_revenue) OVER (PARTITION BY Region ORDER BY year)) / LAG(Total_revenue) OVER (PARTITION BY Region ORDER BY year) * 100, 2) 
    AS YoY_Per_Region, Total_sales,
    LAG(Total_sales) OVER (PARTITION BY Model ORDER BY year) AS Prev_year_sales,
    ROUND((Total_sales - LAG(Total_sales) OVER (PARTITION BY Model ORDER BY year)) / LAG(Total_sales) OVER (PARTITION BY Model ORDER BY year) * 100, 2) 
    AS YoY_Per_Region
FROM yearly_revenue
ORDER BY Region, Year;

-- FINAL TABLE FOR THE DASHBOARD

WITH base AS
(
    SELECT Region, Model, Year, Fuel_Type, SUM(Price_USD * Sales_Volume) AS Revenue, SUM(Sales_Volume) AS Volume
    FROM bmw_sales_data
    GROUP BY Region, Model, Year, Fuel_Type
),
yoy AS 
(
SELECT Region, Model, Year, SUM(Revenue) AS Total_Revenue, SUM(Volume) AS Total_Volume,
        LAG(SUM(Revenue)) OVER (PARTITION BY Region, Model ORDER BY Year) AS Prev_Revenue,
        LAG(SUM(Volume)) OVER (PARTITION BY Region, Model ORDER BY Year) AS Prev_Volume
    FROM base
    GROUP BY Region, Model, Year
)
SELECT b.Model, b.Region, b.Year, b.Fuel_Type, b.Revenue, b.Volume,
    ROUND((y.Total_Revenue - y.Prev_Revenue) * 100.0 / y.Prev_Revenue, 2) AS YoY_Revenue,
    ROUND((y.Total_Volume - y.Prev_Volume) * 100.0 / y.Prev_Volume, 2) AS YoY_Volume
FROM base b
JOIN yoy y
  ON b.Model = y.Model
 AND b.Region = y.Region
 AND b.Year = y.Year
ORDER BY b.Region, b.Model, b.Year, b.Fuel_Type;