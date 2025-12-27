# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **write a sql query to retrieve all columns for sales made on '2022-11-05'
**:
```sql
select * from retail_sales
where sale_date like '2022-11-05';
```

2. **write a sql query to retrieve all transactions where category is 'Clothing' and the 
quantity sold is more than 3 in the month of nov_2022
**:
```sql
select * from retail_sales
where category = 'clothing'
and sale_date between  '2022-11-01' and  '2022-11-30'
and quantity >3
order by sale_date;
```

3. **write a sql query to calculate total sales for each category
**:
```sql
select 
category, 
sum(total_sale) as net_sale,
count(*) as total_orders from retail_sales
group by category;
```

4. **write a Sql query to find the average age of customers who purchased items from beauty category
**:
```sql
select round(avg(age),2) from retail_sales        
where category = 'beauty'
;
```

5. ** write a sql query to find all transactions where the total_sales is greater than 1000
**:
```sql
select * from retail_sales 
where total_sale >1000;
```

6. **write  a sql query to find the total number of transactions(ids) made by each category and each gender
**:
```sql
select category,gender,
count(*) as total_transactions
from retail_sales
group by category, gender
order by 1;
```

7. **write a Sql query for average sale for each month. find out best selling month in each year
**:
```sql
select 
year,month,avg_sale from (select 
     year (sale_date) as year,
     month(sale_date) as month,
     AVG(total_sale) as avg_sale,
     rank() over(partition by Year(sale_date) order by avg(total_sale) Desc) as Ranks
from retail_sales
 group by year,month
 ) as t1
 where ranks=1;
```

8. **write a sql Query to find the top 5 customers based on the highest total sales
 **:
```sql
select 
  customer_id,
  sum(total_sale) as total_sales
  from retail_sales
  group by 1
  order by 2 desc
  limit 5;
```

9. **write a sql query to find the number of unique customers who purchased items frome each category
 **:
```sql
 select 
    category,
    count( distinct customer_id) as cnt_customers
    from retail_sales
    group by 1;
```

10. **write a sql query to create each shift and number of orders (ex morning <=12, Afternoon betwwn 12 & 17, evening> 17)
**:
```sql
select *,
case 
when extract(hour from sale_time) < 12 then 'Morning'
when (extract(hour from sale_time) >= 12 and extract(hour from sale_time) < 17 ) then 'Afternoon' 
Else 'Evening'
end as shift
 from retail_sales ) 
 select shift,count(*) as total_orders from hourly_sales 
 group by shift
 ;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Yasaswini Syba

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:

- **LinkedIn**: [Connect with me professionally]([https://www.linkedin.com/in/yasaswini-syba-b3037a239/})


Thank you for your support, and I look forward to connecting with you!
