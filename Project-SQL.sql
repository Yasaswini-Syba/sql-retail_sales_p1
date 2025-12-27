-- SQL Retail Sales Analysis -P1
create database sql_project_p1;

use sql_project_p1;

-- Create Table 
drop table if exists retail_sales;
Create table retail_sales(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(20),
age int,
category varchar(20),
quantiy int,
price_per_unit float,
cogs float,
total_sale float);

select * from retail_sales;


