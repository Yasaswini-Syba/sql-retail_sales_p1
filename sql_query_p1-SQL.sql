use sql_project_p1;

select * from retail_sales
limit 10;

select count(*) from retail_sales;

alter table retail_sales  
rename column  quantiy to quantity;


-- Data Cleaning --

select * from retail_sales          -- checking null values
where transactions_id is null;

select * from retail_sales          -- checking null values
where
 transactions_id is null
 or sale_date is null
 or sale_time is null
 or customer_id is null
 or  gender is null
 or age is null
 or category is null
 or quantity is null
 or price_per_unit is null
 or cogs is null
 or total_sale is null
 ;

select count(*) from retail_sales where age like 0;

-- Data Exploration 

-- how many sales we have?
select count(*) as total_sale from retail_sales 
where total_sale >0;                               

-- how many unique customers do we have?
select count(distinct customer_id) as total_customers from retail_sales ; 

-- how many categories are there?
select count(distinct category ) from retail_sales;          
 -- what are the category exists?
select distinct category  from retail_sales;   -- beauty, clothing,Electronics

-- Data Analysis & Business key Problems & Answers
-- 
-- Q.1 write a sql query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales
where sale_date like '2022-11-05';

/* Q.2 write a sql query to retrieve all transactions where category is 'Clothing' and the 
quantity sold is more than 3 in the month of nov_2022
*/

select * from retail_sales
where category = 'clothing'
and sale_date between  '2022-11-01' and  '2022-11-30'
and quantity >3
order by sale_date;

-- Q.3 write a sql query to calculate total sales for each category
select 
category, 
sum(total_sale) as net_sale,
count(*) as total_orders from retail_sales
group by category;

-- Q.4 write a Sql query to find the average age of customers who purchased items from beauty category

select round(avg(age),2) from retail_sales        -- 40.34
where category = 'beauty'
;
-- Q.5 write a sql query to find all transactions where the total_sales is greater than 1000
select * from retail_sales 
where total_sale >1000;

-- Q.6 write  a sql query to find the total number of transactions(ids) made by each category and each gender
select category,gender,
count(*) as total_transactions
from retail_sales
group by category, gender
order by 1;
      
 -- Q.7 write a Sql query for average sale for each month. find out best selling month in each year
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
 
 -- Q.8 write a sql Query to find the top 5 customers based on the highest total sales
 select 
  customer_id,
  sum(total_sale) as total_sales
  from retail_sales
  group by 1
  order by 2 desc
  limit 5;
 
 -- Q.9 write a sql query to find the number of unique customers who purchased items frome each category
 select 
    category,
    count( distinct customer_id) as cnt_customers
    from retail_sales
    group by 1;
       
 -- Q.10 write a sql query to create each shift and number of orders (ex morning <=12, Afternoon betwwn 12 & 17, evening> 17)
with hourly_sales as(
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




