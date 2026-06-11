# Data Dictionary

## Project Dataset

Dataset: Brazilian E-Commerce Public Dataset by Olist

Purpose: Analyze customer behavior, sales performance, product performance, regional trends, and delivery operations.

---

# Dataset Inventory

| Table Name                        | Description                                 | Primary Key              |
| --------------------------------- | ------------------------------------------- | ------------------------ |
| olist_customers_dataset           | Customer information and location details   | customer_id              |
| olist_orders_dataset              | Order lifecycle and delivery information    | order_id                 |
| olist_order_items_dataset         | Products sold within each order             | order_id + order_item_id |
| olist_order_payments_dataset      | Payment information for orders              | order_id                 |
| olist_order_reviews_dataset       | Customer reviews and ratings                | review_id                |
| olist_products_dataset            | Product metadata and category information   | product_id               |
| olist_sellers_dataset             | Seller information and location details     | seller_id                |
| olist_geolocation_dataset         | Geographic coordinates and location mapping | No unique key            |
| product_category_name_translation | Portuguese to English category translation  | product_category_name    |

---

# Table Details

## 1. olist_customers_dataset

### Purpose

Stores customer identification and location information.

### Columns

| Column Name              | Description                                  |
| ------------------------ | -------------------------------------------- |
| customer_id              | Unique customer identifier                   |
| customer_unique_id       | Unique identifier for an individual customer |
| customer_zip_code_prefix | ZIP code prefix                              |
| customer_city            | Customer city                                |
| customer_state           | Customer state                               |

### Primary Key

customer_id

---

## 2. olist_orders_dataset

### Purpose

Stores order lifecycle information from purchase to delivery.

### Columns

| Column Name                   | Description                |
| ----------------------------- | -------------------------- |
| order_id                      | Unique order identifier    |
| customer_id                   | Customer identifier        |
| order_status                  | Current order status       |
| order_purchase_timestamp      | Purchase date and time     |
| order_approved_at             | Order approval timestamp   |
| order_delivered_carrier_date  | Date sent to carrier       |
| order_delivered_customer_date | Date delivered to customer |
| order_estimated_delivery_date | Expected delivery date     |

### Primary Key

order_id

### Foreign Key

customer_id

---

## 3. olist_order_items_dataset

### Purpose

Stores products included in each order.

### Columns

| Column Name         | Description                |
| ------------------- | -------------------------- |
| order_id            | Order identifier           |
| order_item_id       | Item sequence within order |
| product_id          | Product identifier         |
| seller_id           | Seller identifier          |
| shipping_limit_date | Shipping deadline          |
| price               | Product price              |
| freight_value       | Shipping cost              |

### Composite Primary Key

order_id + order_item_id

### Foreign Keys

* order_id
* product_id
* seller_id

---

## 4. olist_order_payments_dataset

### Purpose

Stores payment details for each order.

### Columns

| Column Name          | Description             |
| -------------------- | ----------------------- |
| order_id             | Order identifier        |
| payment_sequential   | Payment sequence number |
| payment_type         | Payment method          |
| payment_installments | Number of installments  |
| payment_value        | Payment amount          |

### Foreign Key

order_id

---

## 5. olist_order_reviews_dataset

### Purpose

Stores customer feedback and review ratings.

### Columns

| Column Name             | Description               |
| ----------------------- | ------------------------- |
| review_id               | Review identifier         |
| order_id                | Order identifier          |
| review_score            | Customer rating (1-5)     |
| review_comment_title    | Review title              |
| review_comment_message  | Review text               |
| review_creation_date    | Review creation date      |
| review_answer_timestamp | Review response timestamp |

### Primary Key

review_id

### Foreign Key

order_id

---

## 6. olist_products_dataset

### Purpose

Stores product information and physical attributes.

### Columns

| Column Name                | Description         |
| -------------------------- | ------------------- |
| product_id                 | Product identifier  |
| product_category_name      | Product category    |
| product_name_length        | Product name length |
| product_description_length | Description length  |
| product_photos_qty         | Number of photos    |
| product_weight_g           | Product weight      |
| product_length_cm          | Product length      |
| product_height_cm          | Product height      |
| product_width_cm           | Product width       |

### Primary Key

product_id

---

## 7. olist_sellers_dataset

### Purpose

Stores seller information and locations.

### Columns

| Column Name            | Description       |
| ---------------------- | ----------------- |
| seller_id              | Seller identifier |
| seller_zip_code_prefix | ZIP code prefix   |
| seller_city            | Seller city       |
| seller_state           | Seller state      |

### Primary Key

seller_id

---

## 8. olist_geolocation_dataset

### Purpose

Stores geographical coordinates for mapping and regional analysis.

### Columns

| Column Name                 | Description     |
| --------------------------- | --------------- |
| geolocation_zip_code_prefix | ZIP code prefix |
| geolocation_lat             | Latitude        |
| geolocation_lng             | Longitude       |
| geolocation_city            | City            |
| geolocation_state           | State           |

### Primary Key

No unique primary key

---

## 9. product_category_name_translation

### Purpose

Translates Portuguese category names into English.

### Columns

| Column Name                   | Description              |
| ----------------------------- | ------------------------ |
| product_category_name         | Portuguese category name |
| product_category_name_english | English category name    |

### Primary Key

product_category_name
