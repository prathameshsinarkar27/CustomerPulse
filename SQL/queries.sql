-- =====================================================
-- KPI ANALYSIS
-- =====================================================

-- Total Revenue

SELECT
    ROUND(SUM(price), 2) AS total_revenue
FROM order_items;

-- Total Orders

SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- Total Customers

SELECT
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers;

-- Average Order Value

SELECT
    ROUND(
        SUM(price)
        /
        COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM order_items;

-- Total Freight Cost

SELECT
    ROUND(
        SUM(freight_value),
        2
    ) AS total_freight_cost
FROM order_items;


-- =====================================================
-- CUSTOMER ANALYSIS
-- =====================================================

-- Top 10 Customers by Revenue

SELECT
    c.customer_unique_id,
    ROUND(
        SUM(oi.price),
        2
    ) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_unique_id
ORDER BY
    revenue DESC
LIMIT 10;

-- Repeat Customers

SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_unique_id
    HAVING COUNT(o.order_id) > 1
) t;

-- Customer Order Frequency

SELECT
    order_count,
    COUNT(*) AS customer_count
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_unique_id
) t
GROUP BY
    order_count
ORDER BY
    order_count;


-- =====================================================
-- PRODUCT ANALYSIS
-- =====================================================

-- Top Product Categories by Revenue

SELECT
    COALESCE(
        ct.product_category_name_english,
        'Unknown'
    ) AS category,
    ROUND(
        SUM(oi.price),
        2
    ) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name =
       ct.product_category_name
GROUP BY
    category
ORDER BY
    revenue DESC
LIMIT 10;

-- Top Products by Revenue

SELECT
    oi.product_id,
    ROUND(
        SUM(oi.price),
        2
    ) AS revenue
FROM order_items oi
GROUP BY
    oi.product_id
ORDER BY
    revenue DESC
LIMIT 10;

-- Most Sold Products

SELECT
    product_id,
    COUNT(*) AS quantity_sold
FROM order_items
GROUP BY
    product_id
ORDER BY
    quantity_sold DESC
LIMIT 10;

-- Category Performance Summary

SELECT
    COALESCE(
        ct.product_category_name_english,
        'Unknown'
    ) AS category,
    COUNT(DISTINCT oi.product_id) AS unique_products,
    COUNT(*) AS units_sold,
    ROUND(
        SUM(oi.price),
        2
    ) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name =
       ct.product_category_name
GROUP BY
    category
ORDER BY
    revenue DESC
LIMIT 10;


-- =====================================================
-- REGIONAL ANALYSIS
-- =====================================================

-- Revenue by State

SELECT
    c.customer_state,
    ROUND(
        SUM(oi.price),
        2
    ) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_state
ORDER BY
    revenue DESC;

-- Top 10 States by Revenue

SELECT
    c.customer_state,
    ROUND(
        SUM(oi.price),
        2
    ) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_state
ORDER BY
    revenue DESC
LIMIT 10;

-- Top Cities by Revenue

SELECT
    c.customer_city,
    ROUND(
        SUM(oi.price),
        2
    ) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_city
ORDER BY
    revenue DESC
LIMIT 10;

-- Orders by State

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_state
ORDER BY
    total_orders DESC;

-- Orders by State

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_state
ORDER BY
    total_orders DESC;

-- Average Order Value by State

SELECT
    c.customer_state,
    ROUND(
        SUM(oi.price)
        /
        COUNT(DISTINCT o.order_id),
        2
    ) AS avg_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_state
ORDER BY
    avg_order_value DESC;


-- =====================================================
-- OPERATIONS ANALYSIS
-- =====================================================

-- Average Delivery Days

SELECT
    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (
                    order_delivered_customer_date
                    -
                    order_purchase_timestamp
                )
            ) / 86400
        ),
        2
    ) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- Delivery Statistics

SELECT
    ROUND(
        MIN(
            EXTRACT(
                EPOCH FROM (
                    order_delivered_customer_date
                    -
                    order_purchase_timestamp
                )
            ) / 86400
        ),
        2
    ) AS min_days,

    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (
                    order_delivered_customer_date
                    -
                    order_purchase_timestamp
                )
            ) / 86400
        ),
        2
    ) AS avg_days,

    ROUND(
        MAX(
            EXTRACT(
                EPOCH FROM (
                    order_delivered_customer_date
                    -
                    order_purchase_timestamp
                )
            ) / 86400
        ),
        2
    ) AS max_days

FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- Delayed Deliveries

SELECT
    COUNT(*) AS delayed_orders
FROM orders
WHERE
    order_delivered_customer_date
    >
    order_estimated_delivery_date;

-- Delay Percentage

SELECT
    ROUND(
        (
            COUNT(*) FILTER (
                WHERE order_delivered_customer_date
                      >
                      order_estimated_delivery_date
            )::NUMERIC
            /
            COUNT(*) FILTER (
                WHERE order_delivered_customer_date
                      IS NOT NULL
            )
        ) * 100,
        2
    ) AS delay_percentage
FROM orders;

-- States with Highest Order Volume

SELECT
    c.customer_state,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_state
ORDER BY
    total_orders DESC
LIMIT 10;

