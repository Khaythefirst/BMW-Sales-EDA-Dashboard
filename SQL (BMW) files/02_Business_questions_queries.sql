-- Advanced / Business Questions --

-- Most profitable model (highest revenue overall) (1)
SELECT Model, SUM( Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data
GROUP BY Model
ORDER BY Total_revenue DESC
LIMIT 1;

-- Which region buys the most premium cars (highest avg price)? (2)
SELECT Region, AVG(Price_USD) AS Avg_price
FROM bmw_sales_data
GROUP BY Region
ORDER BY Avg_price DESC
LIMIT 1;

-- Which year had the highest total sales revenue? (3)
SELECT Year, SUM( Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data
GROUP BY Year
ORDER BY Total_revenue DESC
LIMIT 1;

-- Which model dominates each region? (market share %) (4)
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
SELECT r.Region, r.Model, r.Model_sales, Round((r.Model_sales * 100.0 / t.Region_total), 2) AS Market_Share_Percent
FROM region_sales AS r
JOIN total_region_sales AS t
	ON r.Region = t.Region
ORDER BY r.Region, Market_Share_Percent DESC;

-- Which model had the fastest growth between years? (5)
WITH yearly_sales AS
(
SELECT Model, Year, SUM(Sales_Volume) AS Total_sales
FROM bmw_sales_data
GROUP BY Model, Year 
),
growth_calc AS
(
SELECT Model,Year, Total_sales, LAG(Total_sales) OVER(PARTITION BY Model ORDER BY Year) AS Prev_year_sales,
Total_sales - LAG(Total_sales) OVER(PARTITION BY Model ORDER BY Year) AS Growth
FROM yearly_sales
)
SELECT *
FROM growth_calc
WHERE growth is not null
ORDER BY Growth desc
LIMIT 1;

-- Which model declined the most in sales? (6)
WITH yearly_sales AS
(
SELECT Model, Year, SUM(Sales_Volume) AS Total_sales
FROM bmw_sales_data
GROUP BY Model, Year 
),
decline_calc AS
(
SELECT Model,Year, Total_sales, LAG(Total_sales) OVER(PARTITION BY Model ORDER BY Year) AS Prev_year_sales,
Total_sales - LAG(Total_sales) OVER(PARTITION BY Model ORDER BY Year) AS Decline
FROM yearly_sales
)
SELECT *
FROM decline_calc
WHERE decline is not null
ORDER BY decline asc
LIMIT 1;

-- Which region contributes the most to global revenue? (7)
SELECT Region, SUM( Price_USD * Sales_Volume) AS Total_revenue
FROM bmw_sales_data
GROUP BY Region
ORDER BY Total_revenue desc
LIMIT 1;

-- Which model is the global bestseller across all years? (8)
SELECT Model, SUM(Sales_Volume) AS Total_sales
FROM bmw_sales_data
GROUP BY Model
ORDER BY Total_sales desc
LIMIT 1;