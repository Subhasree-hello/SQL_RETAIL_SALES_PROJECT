create database projectsql;
use projectsql;


#CREATING TABLES
create table retail_sales(
   transactions_id	INT,
   sale_date	    DATE,
   sale_time	    TIME,
   customer_id	    INT,
   gender	        VARCHAR(15),
   age	            INT,
   category	        VARCHAR(15),
   quantiy	        INT,
   price_per_unit	FLOAT,
   cogs	            FLOAT,
   total_sale       FLOAT

);

ALTER TABLE retail_sales
MODIFY COLUMN  transactions_id	INT PRIMARY KEY;

#EXPLORATION


select * from retail_sales;

select count(*) from retail_sales;

select * from retail_sales where 
  
   sale_date        IS NULL OR  
   sale_time        IS NULL OR
   customer_id	    IS NULL OR
   gender	        IS NULL OR
   age	            IS NULL OR
   category	        IS NULL OR
   quantiy	        IS NULL OR
   price_per_unit	IS NULL OR
   cogs	            IS NULL OR
   total_sale       IS NULL ;

SELECT COUNT(distinct category) from retail_sales;
SELECT distinct category from retail_sales;

#1.write query to count total salary for each category

select category,sum(total_sale) as net_sales , count(*) as total_orders from retail_sales group by category;

#2.find the avg age of customer who bought from beauty category

select * from retail_sales where category='beauty';
select count(*) from retail_sales where category='beauty';
select round(avg(age),2) as avg_age from retail_sales where category='beauty';

#3. find all the transactions that where the total_sale is greater than 1000

SELECT * FROM retail_sales WHERE total_sale>1000;

#4.find the total no. of transaction made by each gender in each category

SELECT category,gender,count(transactions_id) as total_transaction from retail_sales GROUP BY category,gender ORDER BY category ASC;

#5.calculate avg sale for each month 

SELECT YEAR(sale_date),MONTH(sale_date),ROUND(AVG(total_sale),2) as AVG_SALE FROM retail_sales GROUP BY 1,2 ORDER BY 1,2 ASC;
SELECT YEAR(sale_date),MONTH(sale_date),ROUND(AVG(total_sale),2) as AVG_SALE FROM retail_sales GROUP BY 1,2 ORDER BY 1,3 DESC;

#6.only showing top 2 months of each year
SELECT * FROM
(SELECT YEAR(sale_date),MONTH(sale_date),ROUND(AVG(total_sale),2) as AVG_SALE,
rank() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC ) as RANK_MONTH 
FROM retail_sales GROUP BY 1,2) AS T1 WHERE RANK_MONTH=1 ;

#7. finding top 5 customer based on the highest total sales

SELECT customer_id,SUM(total_sale) from retail_saleS GROUP BY 1 ORDER BY 2 DESC LIMIT 5;

#8. find the no. of unique customers who purchased item for each category

SELECT category, COUNT(DISTINCT customer_id) AS uni_customer from retail_sales GROUP BY 1 ;

#9.Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT *,CASE WHEN HOUR(sale_time)< 12 THEN 'MORNING'
              WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
              ELSE 'EVENING' END AS SHIFT FROM retail_sales;
              
#10. find total_sales in each each shift  

WITH HOURLY AS (SELECT *,CASE WHEN HOUR(sale_time)< 12 THEN 'MORNING'
              WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
              ELSE 'EVENING' END AS SHIFT FROM retail_sales) 
              SELECT SHIFT, SUM(total_sale) as Total_sale FROM HOURLY GROUP BY SHIFT ; 
              
# 11. find total_transaction in each each shift     
 
 WITH HOURLY AS (SELECT *,CASE WHEN HOUR(sale_time)< 12 THEN 'MORNING'
              WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
              ELSE 'EVENING' END AS SHIFT FROM retail_sales) 
              SELECT SHIFT, COUNT(*) as Total_Transaction FROM HOURLY GROUP BY SHIFT ;       





