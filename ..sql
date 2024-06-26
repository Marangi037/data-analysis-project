select *
from sales

--data cleaning
--checking for duplicates(used a cte)

with rownum as (
select *, ROW_NUMBER() OVER( PARTITION BY PRICEEACH, SALES, STATUS, YEAR_ID, PRODUCTLINE, CUSTOMERNAME, CITY, POSTALCODE ORDER BY ORDERNUMBER) row_num
from sales)
select *
from rownum
where row_num >=2

--no duplicates found

--Standardize date format(i created a new column and added the correct date format to it)
alter table sales
add ORDER_DATE date

select
    CASE MONTH_ID
        when '1' then 'January'
        when '2' then 'February'
        when '3' then 'March'
        when '4' then 'April'
        when '5' then 'May'
        when '6' then 'June'
        when '7' then 'July'
        when '8' then 'August'
        when '9' then 'September'
        when '10' then 'October'
        when '11' then 'November'
        when '12' then 'December'
        else 'Invalid month'
    END AS month_name
from sales

 --changing month name from  numerical values 1,2,3.. to their actual names(i created a new month column and added the new month format to it)   

alter table sales 
add month_name nvarchar(255)

update sales
set month_name = CASE MONTH_ID
        when '1' then 'January'
        when '2' then 'February'
        when '3' then 'March'
        when '4' then 'April'
        when '5' then 'May'
        when '6' then 'June'
        when '7' then 'July'
        when '8' then 'August'
        when '9' then 'September'
        when '10' then 'October'
        when '11' then 'November'
        when '12' then 'December'
        else 'Invalid month'
    END
from sales



update sales
set ORDER_DATE = convert(date, ORDERDATE)

--Removing useless columns
alter table sales
DROP COLUMN ADDRESSLINE2, MONTH_ID, ORDERDATE, TERRITORY, PHONE


--E.D.A

--Looking at the sales per month

select month_name, sum(SALES) [total sales]
from sales
group by month_name
order by 2 desc


--Checking the total sales per year

select YEAR_ID, SUM(SALES) as total_sales
from sales
group by YEAR_ID
order by 2 desc;


--Looking at the total sales per country

select COUNTRY, sum(SALES) total_sales
from sales
group by COUNTRY
order by 2 desc

--Looking at sales per city

select CITY, SUM(SALES) [Total sales]
from sales 
group by CITY
order by 2 desc

--checking the number of products bought

select  PRODUCTLINE , count(PRODUCTLINE) as [Number of products buyed]
from sales
group by PRODUCTLINE
order by 2 desc

 -- Size of goods and sum of sales per good's size
select DEALSIZE, sum(SALES) total_sales
from sales
group by DEALSIZE

--Status of goods in the company
select STATUS, count(STATUS) [count goods delivery]
from sales
group by STATUS
order by 2 desc



--Amount of revenue the customer contributes to the total company's revenue
select DISTINCT(CUSTOMERNAME), SUM(SALES) as[Customer revenue],(SUM(SALES)/ (SELECT SUM(SALES) FROM sales))*100 [Customer revenue to the company]
from sales
GROUP BY CUSTOMERNAME
order by 3 desc;


--calculating the top 20% customers
select TOP 20 PERCENT sum(SALES)[Sum of sales], (CUSTOMERNAME)
from sales
group by CUSTOMERNAME
order by 1 desc






