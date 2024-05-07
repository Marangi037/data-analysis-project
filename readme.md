#Sales Data Analysis Project

## Table of contents

- [Project Overview](#project-overview)
- [Data source](#data-source)
- [Tools](#tools)
- [Data Cleaning](#data-cleaning)
- [Exploratory Data Analysis(EDA)](#exploratory-data-analysis)
- [Data Analysis](data-analysis)
- [Results](#results)
- [Recommendations](#recommendation)


###Project Overview


###Data source
The sales data used in this project is sourced from [Kaggle.com](http://www.kaggle.com).The dataset contains records of sales transactions from January 2003 to December 2005.



###Tools
- Excel - Data Visualization [Download here](http://www.Excel.com)
- SQL Server - Data cleaning and data analysis[Download here](http://www.SQLServer.com)
- Tableau - Creating reports[Download here](htttp://www.Tableau.com)

###Data cleaning
In the initial preparation phase, i performed the following tasks:
1. Data loading and inspection
2. Handling missing values
3. Data cleaning and formatting 

###Exploratory Data Analysis
- Which Country has most sales?
- Which city has most sales
- What percentage does each customer contribute to the company's revenue
- 


###Data Analysis 

```SQL
with customer_sales AS (
    select CUSTOMERNAME, sum(SALES) as total_sales
    from sales
    group by CUSTOMERNAME
), total_revenue AS (
    SELECT sum(SALES) as total_amount
    from sales
)
select 
case 
    when cumulative_percentage <= 20 THEN 'top 20% customers'
    else 'Remaining customers'
end as customer_category,sum(total_sales)
from (select CUSTOMERNAME, total_sales, 100* sum(total_sales) over (order by total_sales desc)/(select total_amount from total_revenue)as cumulative_percentage from customer_sales) as subquery
group by
CASE 
    when cumulative_percentage <= 20 THEN 'top 20% customers'
    else 'Remaining customers'
END;
```
###Results
The analysis results are summarized as follows:
- The company has its Peak sales in November and October.
- The company had increase in sales from 2003 to 2004 and then a decrease in sales in 2005.
- Large goods had a higher sales than other good sizes.
- United States had the highest sales among all countries.
- Madrid City had the highest sales among the cities.
- Classic Cars are the best performing product in terms of sales.
- Euro Shopping Channel contributed the highest percentage to the Company's revenue.

###Recommendation
Based on the analysis, i recommend yhe following actions:
- Invest in marketing and promotions during peak sales seasons to maximize revenue.
- Invest in transportation of large goods to customers since they have the highest sales.
- Focus on expanding and promoting Classic cars since they are the highest selling product
- Develop targeted marketing campaigns to reach specific customer segments. Tailor the messaging to highlight the unique features and benefits of each product model.
- Implement a customer segmentation strategy to target the top 20% customer who contribute highly to the company's revenue.
- Partner with financial institutions or ofeer in-house financing options to make it easier for customers to purchase products. Flexible financing options can expand the customer base and increase sales.
- Focus on providing excellent after-sale service and support.
- Focus on achieve a 100% delivery rate of goods to the customers.
###Limitation
I had to remove all null values and replace them with zeros because the nulls would have interrupted with the accuracy of the analysis. 











