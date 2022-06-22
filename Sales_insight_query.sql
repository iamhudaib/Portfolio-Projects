SELECT * FROM sales.transactions where currency="USD";

Select * From sales.transactions where order_date like '2020%'
order by product_code;

Select distinct product_code From sales.transactions where market_code = "Mark001";

Select sum(sales_amount) From sales.transactions where order_date like '2020%' and market_code="Mark001";

Select * From sales.transactions INNER JOIN sales.date ON sales.transactions.order_date = sales.date.date;

SELECT SUM(transactions.sales_amount) FROM transactions INNER JOIN date ON 
transactions.order_date=date.date where date.year=2020 and transactions.currency="INR\r" or transactions.currency="USD\r";

SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON 
sales.transactions.order_date= sales.date.date where sales.date.year=2020 and sales.date.month_name="January" and (sales.transactions.currency="INR\r");

SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON 
sales.transactions.order_date=sales.date.date where sales.date.year=2020 and sales.transactions.market_code="Mark001";
