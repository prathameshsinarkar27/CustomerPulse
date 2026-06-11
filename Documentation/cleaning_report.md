# Data Cleaning Report

## Project

CustomerPulse: E-Commerce Customer Intelligence Platform

Dataset: Olist Brazilian E-Commerce Dataset

---

# Data Quality Assessment Summary

The dataset was assessed for:

* Missing values
* Duplicate records
* Data type consistency
* Potential data quality issues

---

# Table Assessment

## Customers

Rows: 99,441

Findings:

* No missing values
* No duplicate rows

Action:

* No cleaning required

---

## Geolocation

Rows: 1,000,163

Findings:

* No missing values
* 261,831 duplicate rows identified

Action:

* Remove exact duplicate records

---

## Order Items

Rows: 112,650

Findings:

* No missing values
* No duplicate rows

Action:

* No cleaning required

---

## Payments

Rows: 103,886

Findings:

* No missing values
* No duplicate rows

Action:

* No cleaning required

---

## Reviews

Rows: 99,224

Findings:

* Missing values in review_comment_title
* Missing values in review_comment_message

Business Interpretation:

Many customers submit ratings without textual feedback.

Action:

* Retain missing values
* No imputation required

---

## Orders

Rows: 99,441

Findings:

Missing values detected in:

* order_approved_at
* order_delivered_carrier_date
* order_delivered_customer_date

Business Interpretation:

Missing values are expected for canceled or unavailable orders.

Action:

* Retain missing values

---

## Products

Rows: 32,951

Findings:

Missing values detected in:

* product_category_name
* product_name_lenght
* product_description_lenght
* product_photos_qty
* product_weight_g
* product_length_cm
* product_height_cm
* product_width_cm

Action:

* Investigate further during cleaning phase

Additional Investigation:

610 products contain missing category and product metadata fields.

This represents approximately 1.85% of all product records.

Decision:

* Retain these products.
* Replace missing product_category_name with "Unknown".
* Retain associated sales transactions to avoid revenue loss.

Reason:

Removing these records would exclude valid sales from analysis and negatively impact category reporting.


---

## Sellers

Rows: 3,095

Findings:

* No missing values
* No duplicate rows

Action:

* No cleaning required

---

## Category Translation

Rows: 71

Findings:

* No missing values
* No duplicate rows

Action:

* No cleaning required

---

# Planned Cleaning Actions

1. Remove duplicate records from geolocation dataset.
2. Convert date columns to datetime format.
3. Investigate missing product information.
4. Standardize text fields where necessary.
5. Create cleaned datasets for analysis.

---

# Conclusion

The dataset quality is generally good.

Most missing values are business-driven and should not be treated as errors.

The primary cleaning effort will focus on duplicate removal, datatype conversion, and handling missing product attributes.



# Cleaning Actions Performed

## Action 1: Remove Geolocation Duplicates

Problem:

261,831 exact duplicate records were identified in the geolocation dataset.

Solution:

Removed duplicates using Pandas drop_duplicates().

Result:

* Original Rows: 1,000,163
* Cleaned Rows: 738,332
* Duplicates Remaining: 0

---

## Action 2: Handle Missing Product Categories

Problem:

610 products had missing category names.

Solution:

Replaced missing category values with "Unknown".

Reason:

Removing these products would exclude valid sales transactions from analysis.

Result:

* Missing Categories Before: 610
* Missing Categories After: 0

---

## Action 3: Datetime Conversion

Problem:

Order date fields were stored as text data types.

Affected Columns:

* order_purchase_timestamp
* order_approved_at
* order_delivered_carrier_date
* order_delivered_customer_date
* order_estimated_delivery_date

Solution:

Converted columns to datetime format using Pandas pd.to_datetime().

Result:

All order date fields are now stored as datetime64[ns] and ready for time-based analysis.
