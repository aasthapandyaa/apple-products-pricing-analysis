SELECT COUNT(*) FROM dbo.apple_products;

-- Basic overview: total records, average price, average rating
SELECT 
    COUNT(*) AS Total_Records,
    AVG(Current_Price_USD) AS Avg_Current_Price,
    AVG(Discount_Pct) AS Avg_Discount_Pct,
    AVG(Rating) AS Avg_Rating
FROM apple_products;

-- Which platform has lower average prices, by product category
SELECT 
    Platform,
    Product_Category,
    AVG(Current_Price_USD) AS Avg_Price,
    AVG(Discount_Pct) AS Avg_Discount
FROM apple_products
GROUP BY Platform, Product_Category
ORDER BY Product_Category, Avg_Price;

-- Are discounts during named sale events actually bigger than regular days?
SELECT 
    CASE WHEN Sale_Event IS NULL THEN 'Regular Day' ELSE Sale_Event END AS Event_Type,
    AVG(Discount_Pct) AS Avg_Discount,
    COUNT(*) AS Num_Records
FROM apple_products
GROUP BY CASE WHEN Sale_Event IS NULL THEN 'Regular Day' ELSE Sale_Event END
ORDER BY Avg_Discount DESC;

-- How much cheaper is Renewed/Refurbished, and does the gap change by model?
SELECT 
    Model_Name,
    Condition,
    AVG(Current_Price_USD) AS Avg_Price
FROM apple_products
GROUP BY Model_Name, Condition
ORDER BY Model_Name, Condition;

-- Track how much each model's price has dropped from its launch price, ranked
SELECT 
    Model_Name,
    Platform,
    Launch_Price_USD,
    Current_Price_USD,
    (Launch_Price_USD - Current_Price_USD) AS Price_Drop,
    ROUND(((Launch_Price_USD - Current_Price_USD) * 100.0 / Launch_Price_USD), 2) AS Price_Drop_Pct,
    RANK() OVER (ORDER BY (Launch_Price_USD - Current_Price_USD) DESC) AS Drop_Rank
FROM apple_products
GROUP BY Model_Name, Platform, Launch_Price_USD, Current_Price_USD
ORDER BY Drop_Rank;

-- Does deeper discounting actually correlate with products going Out of Stock?
SELECT 
    Stock_Status,
    AVG(Discount_Pct) AS Avg_Discount,
    COUNT(*) AS Num_Records
FROM apple_products
GROUP BY Stock_Status
ORDER BY Avg_Discount DESC;

SELECT 
    YEAR(Date) AS Year,
    Platform,
    AVG(Discount_Pct) AS Avg_Discount
FROM apple_products
GROUP BY YEAR(Date), Platform
ORDER BY Year, Platform;

-- Has average discount changed over the years? (Trend analysis by platform)
SELECT 
    YEAR(Date) AS Year,
    Platform,
    AVG(Discount_Pct) AS Avg_Discount
FROM apple_products
GROUP BY YEAR(Date), Platform
ORDER BY Year, Platform;

-- Does higher price actually mean higher customer satisfaction? (Price tier vs rating)
SELECT 
    Product_Category,
    CASE 
        WHEN Current_Price_USD < 500 THEN 'Budget'
        WHEN Current_Price_USD BETWEEN 500 AND 1000 THEN 'Mid-range'
        ELSE 'Premium'
    END AS Price_Tier,
    AVG(Rating) AS Avg_Rating,
    COUNT(*) AS Num_Records
FROM apple_products
GROUP BY Product_Category, 
    CASE 
        WHEN Current_Price_USD < 500 THEN 'Budget'
        WHEN Current_Price_USD BETWEEN 500 AND 1000 THEN 'Mid-range'
        ELSE 'Premium'
    END
ORDER BY Product_Category, Price_Tier;

