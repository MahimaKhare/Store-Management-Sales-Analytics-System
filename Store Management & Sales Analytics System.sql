-- DATABASE: Clothing Store Management System
-- Project Type: SQL Analytics & Business Insights

USE clothing_store;

-- 1️. PRODUCT & INVENTORY ANALYSIS

-- 1. Show all products with their category name.
SELECT 
    p.product_name, 
    c.category_name
FROM products p
JOIN categories c 
    ON p.category_id = c.category_id;


-- 2. Show store-wise total available stock.
SELECT 
    s.store_name,
    SUM(i.stock_quantity) AS total_stock
FROM inventory i
JOIN stores s
    ON i.store_id = s.store_id
GROUP BY s.store_name;


-- 3. Find products whose stock is less than 10 in any store.
SELECT 
    p.product_name, 
    i.stock_quantity,
    s.store_name
FROM products p
JOIN inventory i
    ON p.product_id = i.product_id
JOIN stores s
    ON i.store_id = s.store_id
WHERE i.stock_quantity < 10;


-- 4. Find top 5 most expensive products in each category.
SELECT *
FROM (
    SELECT 
        c.category_name,
        p.product_name,
        p.price,
        ROW_NUMBER() OVER (
            PARTITION BY c.category_id 
            ORDER BY p.price DESC
        ) AS price_rank
    FROM products p
    JOIN categories c
        ON p.category_id = c.category_id
) ranked_products
WHERE price_rank <= 5;



-- 2️. SALES & ORDERS ANALYSIS

-- 5. Show total number of orders per store.
SELECT 
    s.store_name, 
    COUNT(o.order_id) AS total_orders
FROM stores s
JOIN orders o
    ON s.store_id = o.store_id
GROUP BY s.store_name;


-- 6. Show total revenue per store.
SELECT 
    s.store_name, 
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM stores s
JOIN orders o
    ON s.store_id = o.store_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY s.store_name
ORDER BY total_revenue DESC;


-- 7. Find total items sold for each product.
SELECT 
    p.product_name, 
    SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;


-- 8. Find customers who have placed more than 5 orders.
SELECT 
    c.customer_name, 
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 5;



-- 3️. INTERMEDIATE ANALYTICS


-- 9. Show monthly sales amount for each store.
SELECT 
    s.store_name,
    YEAR(o.order_date) AS year,
    MONTH(o.order_date) AS month,
    SUM(oi.quantity * oi.unit_price) AS monthly_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN stores s
    ON o.store_id = s.store_id
GROUP BY s.store_name, YEAR(o.order_date), MONTH(o.order_date)
ORDER BY year, month;


-- 10. Find the best-selling product in each store.
SELECT *
FROM (
    SELECT 
        s.store_name,
        p.product_name,
        SUM(oi.quantity) AS total_sold,
        ROW_NUMBER() OVER (
            PARTITION BY s.store_id
            ORDER BY SUM(oi.quantity) DESC
        ) AS sales_rank
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    JOIN stores s
        ON o.store_id = s.store_id
    GROUP BY s.store_id, s.store_name, p.product_name
) ranked_sales
WHERE sales_rank = 1;


-- 11. Show top 3 customers by total purchase amount.
SELECT 
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_purchase
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_purchase DESC
LIMIT 3;


-- 12. Find categories that generate more than 30% of total revenue.
SELECT *
FROM (
    SELECT 
        c.category_name,
        SUM(oi.quantity * oi.unit_price) AS category_revenue,
        ROUND(
            SUM(oi.quantity * oi.unit_price) * 100.0 /
            (SELECT SUM(quantity * unit_price) FROM order_items),
            2
        ) AS revenue_percentage
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    JOIN categories c
        ON p.category_id = c.category_id
    GROUP BY c.category_name
) revenue_data
WHERE revenue_percentage > 30;


-- 4️. BUSINESS SCENARIOS

-- 13. Find products that were never sold.
SELECT p.product_name
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;


-- 14. Find customers who purchased from more than one store.
SELECT 
    c.customer_name,
    COUNT(DISTINCT o.store_id) AS stores_visited
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT o.store_id) > 1;


-- 15. Find orders where payment is missing.
SELECT o.order_id
FROM orders o
LEFT JOIN payments p
    ON o.order_id = p.order_id
WHERE p.order_id IS NULL;



-- 5️. PERFORMANCE & ADVANCED SQL


-- 16. Rank products by total revenue within their category.
SELECT 
    c.category_name,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    RANK() OVER (
        PARTITION BY c.category_name
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS product_rank
FROM order_items oi
JOIN products p 
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id
GROUP BY c.category_name, p.product_name;


-- 17. Show running total of store revenue by order date.
SELECT
    s.store_name,
    o.order_date,
    SUM(oi.quantity * oi.unit_price) AS daily_revenue,
    SUM(SUM(oi.quantity * oi.unit_price)) 
    OVER (PARTITION BY s.store_id 
          ORDER BY o.order_date) AS running_total
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN stores s
    ON o.store_id = s.store_id
GROUP BY s.store_id, s.store_name, o.order_date;



-- 6️. REAL-WORLD IMPLEMENTATION


-- 18. Transaction: Reduce inventory after product sale.
START TRANSACTION;

UPDATE inventory
SET stock_quantity = stock_quantity - 2
WHERE product_id = 5;

COMMIT;


-- 19. Create a view for daily sales summary.
CREATE VIEW store_daily_sales AS
SELECT 
    s.store_id,
    s.store_name,
    o.order_date,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN stores s
    ON o.store_id = s.store_id
GROUP BY s.store_id, s.store_name, o.order_date;

SELECT * FROM store_daily_sales;


-- 20. Create an index for faster product search.
CREATE INDEX idx_product_name
ON products(product_name);
