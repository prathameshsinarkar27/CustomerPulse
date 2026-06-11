-- =====================================================
-- CustomerPulse Database Schema
-- Project: CustomerPulse
-- Database: customerpulse
-- =====================================================
--
-- Tables:
-- customers
-- orders
-- order_items
-- payments
-- reviews
-- products
-- sellers
-- geolocation
-- category_translation
--
-- Purpose:
-- Centralized analytical database for
-- customer, product, sales, regional,
-- and delivery analytics.
-- =====================================================

-- Customers Table

CREATE TABLE customers (
customer_id VARCHAR(50) PRIMARY KEY,
customer_unique_id VARCHAR(50),
customer_zip_code_prefix INTEGER,
customer_city VARCHAR(100),
customer_state VARCHAR(10)
);

-- Orders Table

CREATE TABLE orders (
order_id VARCHAR(50) PRIMARY KEY,
customer_id VARCHAR(50),
order_status VARCHAR(50),
order_purchase_timestamp TIMESTAMP,
order_approved_at TIMESTAMP,
order_delivered_carrier_date TIMESTAMP,
order_delivered_customer_date TIMESTAMP,
order_estimated_delivery_date TIMESTAMP
);

-- Order Items Table

CREATE TABLE order_items (
order_id VARCHAR(50),
order_item_id INTEGER,
product_id VARCHAR(50),
seller_id VARCHAR(50),
shipping_limit_date TIMESTAMP,
price NUMERIC(12,2),
freight_value NUMERIC(12,2)
);

-- Payments Table

CREATE TABLE payments (
order_id VARCHAR(50),
payment_sequential INTEGER,
payment_type VARCHAR(50),
payment_installments INTEGER,
payment_value NUMERIC(12,2)
);

-- Reviews Table

CREATE TABLE reviews (
review_id VARCHAR(50),
order_id VARCHAR(50),
review_score INTEGER,
review_comment_title TEXT,
review_comment_message TEXT,
review_creation_date TIMESTAMP,
review_answer_timestamp TIMESTAMP
);

-- Products Table

CREATE TABLE products (
product_id VARCHAR(50) PRIMARY KEY,
product_category_name VARCHAR(100),
product_name_lenght NUMERIC,
product_description_lenght NUMERIC,
product_photos_qty NUMERIC,
product_weight_g NUMERIC,
product_length_cm NUMERIC,
product_height_cm NUMERIC,
product_width_cm NUMERIC
);

-- Sellers Table

CREATE TABLE sellers (
seller_id VARCHAR(50) PRIMARY KEY,
seller_zip_code_prefix INTEGER,
seller_city VARCHAR(100),
seller_state VARCHAR(10)
);

-- Geolocation Table

CREATE TABLE geolocation (
geolocation_zip_code_prefix INTEGER,
geolocation_lat NUMERIC,
geolocation_lng NUMERIC,
geolocation_city VARCHAR(100),
geolocation_state VARCHAR(10)
);

-- Category Translation Table

CREATE TABLE category_translation (
product_category_name VARCHAR(100),
product_category_name_english VARCHAR(100)
);
