#1. Total Revenue and Profitability per Order
SELECT 
    COUNT(DISTINCT `Order Customer Id`) AS "Number of Customers",
    COUNT(DISTINCT `Order Id`) AS "Distinct Orders",
    COUNT(DISTINCT `Order Item Id`) AS "Distinct Items",
    COUNT(DISTINCT `Order City`) AS "Total Order Cities",
    COUNT(DISTINCT `Order Country`) AS "Total Order Country",
    SUM(`Order Item Product Price` * `Order Item Quantity`) AS "Total Revenue",
    SUM(`Order Item Discount`) AS "Total Discount",
    SUM((`Order Item Product Price` * `Order Item Quantity`) * `Order Item Profit Ratio`) AS "Total Profit",
    SUM(`Benefit per order`) AS "Total Benefit Per Order",
    AVG(`Benefit per order`) AS "Average Benefit Per Order"
FROM 
    `supply_chain`.`supplychaindata`
    
# 2. Impact Analysis 
SELECT 
    COUNT(DISTINCT `Order Customer Id`) AS "Number of Customers",
    COUNT(DISTINCT `Order Id`) AS "Distinct Orders",
    COUNT(DISTINCT `Order Item Id`) AS "Distinct Items",
    COUNT(DISTINCT `Order City`) AS "Total Order Cities",
    SUM(`Order Item Product Price` * `Order Item Quantity`) AS "Total Sales",
    SUM((`Order Item Product Price` * `Order Item Quantity`) * `Order Item Profit Ratio`) AS "Total Profit",
    SUM(`Benefit per order`) AS "Total Benefit Per Order",
    AVG(`Benefit per order`) AS "Average Benefit Per Order"
FROM 
    `supply_chain`.`supplychaindata`
# 3. Profitability by Product
SELECT 
    `Product Name`, 
    COUNT(DISTINCT `Order Customer Id`) AS "Number of Customers",
    COUNT(DISTINCT `Order Id`) AS "Distinct Orders",
    COUNT(DISTINCT `Order Item Id`) AS "Distinct Items",
    SUM((`Order Item Product Price` * `Order Item Quantity`) * `Order Item Profit Ratio`) AS "Total Profit",
    SUM(`Order Item Quantity`) AS "Total Quantity Sold",  -- Fixed the line here
    SUM(`Benefit per order`) AS "Total Benefit Per Order",
    AVG(`Benefit per order`) AS "Average Benefit Per Order"
FROM 
    `supply_chain`.`supplychaindata`
GROUP BY 
    `Product Name`
ORDER BY 
    `Total Profit` DESC;

    
#4. Demand Forecasting (Top Selling Products)
SELECT 
    `Product Name`, 
    COUNT(DISTINCT `Order Id`) AS "Distinct Orders",
    COUNT(DISTINCT `Order Item Id`) AS "Distinct Items",
    COUNT(DISTINCT `Order City`) AS "Total Order Cities",
    SUM(`Order Item Quantity`) AS "Total Quantity Sold",
    SUM(`Order Item Product Price` * `Order Item Quantity`) AS "Total Sales",
    SUM(`Benefit per order`) AS "Total Benefit Per Order",
    AVG(`Benefit per order`) AS "Average Benefit Per Order"
FROM 
    `supply_chain`.`supplychaindata`
GROUP BY 
    `Product Name`
ORDER BY 
    `Total Quantity Sold` DESC;

#5. Discount Rate Effectiveness
SELECT 
    `Order Item Discount`,
    `Order Item Discount Rate`,
    COUNT(DISTINCT `Order Customer Id`) AS "Number of Customers",
    COUNT(DISTINCT `Order Id`) AS "Distinct Orders",
    COUNT(DISTINCT `Order Item Id`) AS "Distinct Items",
    COUNT(DISTINCT `Order City`) AS "Total Order Cities",
    SUM(`Order Item Product Price` * `Order Item Quantity`) AS "Total Sales",
    AVG(`Order Item Product Price` * `Order Item Quantity`) AS "Average Sales Per Order",
    SUM((`Order Item Product Price` * `Order Item Quantity`) * `Order Item Profit Ratio`) AS "Total Profit",
    SUM(`Benefit per order`) AS "Total Benefit Per Order",
    AVG(`Benefit per order`) AS "Average Benefit Per Order"
FROM 
    `supply_chain`.`supplychaindata`
GROUP BY 
    `Order Item Discount`, 
    `Order Item Discount Rate`;

#. Customer-Level Analysis
SELECT 
    `Customer Full Name`,
    `Customer Id`,
    COUNT(DISTINCT `Order Id`) AS "Distinct Orders",
    COUNT(DISTINCT `Order City`) AS "Total Order Cities",
    SUM(`Order Item Product Price` * `Order Item Quantity`) AS "Total Spending",
    AVG(`Order Item Discount`) AS "Average Discount",
    SUM((`Order Item Product Price` * `Order Item Quantity`) * `Order Item Profit Ratio`) AS "Total Profit",
    SUM(`Benefit per order`) AS "Total Benefit Per Order",
    AVG(`Benefit per order`) AS "Average Benefit Per Order"
FROM 
    `supply_chain`.`supplychaindata`
GROUP BY 
	`Customer Full Name`,
   `Customer Id`
ORDER BY 
    `Total Spending` DESC;  

# Numbers
SELECT 
    COUNT(DISTINCT `Customer Id`) AS `Number of  Customers`, 
    COUNT(DISTINCT `Order Id`) AS `Number of Total Orders`, 
    COUNT(DISTINCT `Order Item Id`) AS `Number of Total Products`, 
    COUNT(DISTINCT `Department Id`) AS `Number of Total Departments`, 
    COUNT(DISTINCT `Customer City`) AS `Number of Total Cities`, 
    COUNT(DISTINCT `Customer Country`) AS `Number of Total Countries`, 
    COUNT(DISTINCT `Market`) AS `Number of Total Markets`
FROM 
    `supply_chain`.`supplychaindata`;
    
SELECT 
    COUNT(DISTINCT `Customer Id`) AS `Number of Unique Customers`, 
    SUM(`Sales`) AS `Total Sales`, 
    AVG(`Sales`) AS `Average Sales per Order`, 
    SUM(`Benefit per order`) AS `Total Benefit`, 
    AVG(`Days for shipping (real)`) AS `Average Real Shipping Days`, 
    AVG(`Days for shipment (scheduled)`) AS `Average Scheduled Shipping Days`, 
    (SUM(CASE WHEN `Delivery Status` = 'Delivered' THEN 1 ELSE 0 END) / COUNT(`Order Id`)) * 100 AS `On-Time Delivery Rate`, 
    COUNT(DISTINCT `Order Id`) AS `Total Orders`, 
    COUNT(DISTINCT `Order Item Id`) AS `Number of Total Products`, 
    `Delivery Status`,
    AVG(DATEDIFF(`shipping date (DateOrders)`, `order date (DateOrders)`)) AS `Average Delivery Time`
FROM 
    `supply_chain`.`supplychaindata`
GROUP BY 
    `Delivery Status`;


