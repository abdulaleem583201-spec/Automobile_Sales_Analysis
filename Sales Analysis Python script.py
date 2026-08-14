import os
import pandas as pd
import numpy as np
import mysql.connector

# 1. Database Connection (Using Placeholders/Environment Variables for Security)
DB_HOST = os.getenv('DB_HOST', 'localhost')
DB_USER = os.getenv('DB_USER', 'root')
DB_PASSWORD = os.getenv('DB_PASSWORD', 'YOUR_PASSWORD_HERE')
DB_NAME = os.getenv('DB_NAME', 'mydb')

conn = mysql.connector.connect(
    host=DB_HOST,
    user=DB_USER,
    password=DB_PASSWORD,
    database=DB_NAME
)

# 2. Extract Data
query = "SELECT * FROM sales;"
df = pd.read_sql(query, conn)
conn.close()  # Clean up database connection

# Display initial dataset head
print("--- Sales Dataset Preview ---")
print(df.head())
print("\n")

# 3. Statistical Analysis: Price vs Quantity Correlation
correlation = df['PRICEEACH'].corr(df['QUANTITYORDERED'])
print(f"Correlation between Price Each & Quantity Ordered: {correlation:.4f}\n")

# 4. Aggregations & Cluster Summaries by Product Line
cluster_df = df.groupby('PRODUCTLINE').agg({
    'SALES': 'sum',
    'PRICEEACH': 'mean',
    'QUANTITYORDERED': 'sum',
    'ORDERNUMBER': 'count'
}).reset_index()

cluster_df.columns = ['PRODUCT_LINE', 'Total_Revenue', 'Average_Price', 'Total_Quantity', 'Total_Orders']

print("--- Product Line Performance Aggregations ---")
print(cluster_df)