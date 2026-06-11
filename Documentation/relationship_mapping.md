# Relationship Mapping

## Overview

The Olist dataset is a relational database consisting of customer, order, product, seller, payment, review, and geographic information.

The central business process is the customer placing an order.

---

# Entity Relationship Flow

Customers
│
└── customer_id
│
▼
Orders
│
├── order_id
│
├──────────────► Order Payments
│                 (order_id)
│
├──────────────► Order Reviews
│                 (order_id)
│
└──────────────► Order Items
│
├── product_id
│
▼
Products
│
└── product_category_name
│
▼
Category Translation

Order Items
│
└── seller_id
│
▼
Sellers

Customers
│
└── customer_zip_code_prefix
│
▼
Geolocation

Sellers
│
└── seller_zip_code_prefix
│
▼
Geolocation

---

# Primary Relationships

| Parent Table | Child Table          | Join Column           |
| ------------ | -------------------- | --------------------- |
| customers    | orders               | customer_id           |
| orders       | order_items          | order_id              |
| orders       | payments             | order_id              |
| orders       | reviews              | order_id              |
| products     | order_items          | product_id            |
| sellers      | order_items          | seller_id             |
| products     | category_translation | product_category_name |

---

# Relationship Cardinality

## Customers → Orders

One customer can place multiple orders.

Relationship:

1 → Many

---

## Orders → Order Items

One order can contain multiple products.

Relationship:

1 → Many

---

## Orders → Payments

One order can have multiple payment records.

Relationship:

1 → Many

---

## Orders → Reviews

One order can have a review.

Relationship:

1 → 1 (mostly)

---

## Products → Order Items

One product can appear in many orders.

Relationship:

1 → Many

---

## Sellers → Order Items

One seller can sell many products.

Relationship:

1 → Many

---

# Core Analytical Path

Customer
→ Order
→ Order Item
→ Product
→ Seller

This path will be used for:

* Revenue Analysis
* Customer Analysis
* Product Analysis
* Regional Analysis
* Delivery Analysis

---

# Tables Expected for Final Analytics Model

## Fact Table

Fact_Orders

Source Tables:

* orders
* order_items
* payments

Measures:

* Revenue
* Freight Cost
* Order Count
* Delivery Days

---

## Dimension Tables

Dim_Customers

Source:

* customers

Dim_Products

Source:

* products
* category_translation

Dim_Geography

Source:

* customers
* geolocation

Dim_Date

Source:

* generated date table

Dim_Sellers (Optional)

Source:

* sellers
