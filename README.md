# Store Management & Sales Analytics System

## Overview
A comprehensive SQL-based analytics system built on a multi-table clothing store 
database. Contains 20 structured queries across 6 analytical categories — from 
basic inventory checks to advanced window functions, transactions, views, and indexes.

## Objective
Simulate a real-world retail analytics environment to answer critical business 
questions around inventory health, sales performance, customer behaviour, 
revenue distribution, and store-level operations.

## Tools & Technologies
- **MySQL** — database creation and query execution
- **SQL Concepts** — Joins, Aggregations, Subqueries, Window Functions, Transactions, Views, Indexes
- **VS Code / MySQL Workbench** — development environment

## Database Schema
The system is built on **8 interconnected tables:**

| Table | Description |
|-------|-------------|
| `products` | Product details and pricing |
| `categories` | Product category master |
| `inventory` | Store-wise stock levels |
| `stores` | Store information |
| `orders` | Customer order headers |
| `order_items` | Line items per order |
| `customers` | Customer master data |
| `payments` | Payment records per order |

## Analysis Sections

### 1. Product & Inventory Analysis
- Products listed with their category names
- Store-wise total available stock
- Low stock alert — products with stock < 10 in any store
- Top 5 most expensive products per category using `ROW_NUMBER()`

### 2. Sales & Orders Analysis
- Total orders per store
- Total revenue per store (quantity × unit price)
- Total items sold per product (ranked)
- High-frequency customers — placed more than 5 orders using `HAVING`

### 3. Intermediate Analytics
- Monthly sales breakdown per store by year and month
- Best-selling product in each store using `ROW_NUMBER()` window function
- Top 3 customers by total purchase amount
- Categories contributing more than 30% of total revenue using subquery

### 4. Business Scenarios
- Products never sold — using `LEFT JOIN` with NULL check
- Customers who purchased from more than one store
- Orders with missing payment records — data quality check

### 5. Advanced SQL — Window Functions
- Products ranked by revenue within their category using `RANK() OVER (PARTITION BY)`
- Running total of store revenue by order date using cumulative `SUM() OVER()`

### 6. Real-World Implementation
- **Transaction:** Stock reduction after a sale with `START TRANSACTION` / `COMMIT`
- **View:** `store_daily_sales` — reusable view for daily sales reporting
- **Index:** `idx_product_name` — optimized index for faster product search

## Key Business Insights Delivered
- Identified categories generating >30% of total revenue
- Flagged low-stock products across all stores for restocking
- Isolated customers with highest purchase frequency and value
- Detected orders with missing payments for finance reconciliation
- Revealed products with zero sales — candidates for discontinuation

## SQL Concepts Used
`JOIN` `LEFT JOIN` `GROUP BY` `HAVING` `ORDER BY` `SUBQUERY`  
`ROW_NUMBER()` `RANK()` `SUM() OVER()` `PARTITION BY`  
`START TRANSACTION` `COMMIT` `CREATE VIEW` `CREATE INDEX`

## Project Structure
```
Store-Management-Sales-Analytics-System/
│
├── Table.sql                              # Database schema — all 8 tables
├── Store Management & Sales               
│   Analytics System.sql                  # All 20 analytical queries
└── README.md                             # Project documentation
```

## How to Run
1. Open MySQL Workbench or any SQL editor
2. Run `Table.sql` first to create the database and all tables
3. Insert sample data into the tables
4. Run `Store Management & Sales Analytics System.sql` to execute all queries

## Author
**Mahima Khare**  
BCA Graduate | Aspiring Data Analyst  
[LinkedIn](https://www.linkedin.com/in/mahima-khare-34a84a375/) | [GitHub](https://github.com/MahimaKhare)
