
UPDATE coffee_shop_sales
SET temp_transaction_date = STR_TO_DATE(transaction_date, '%m/%d/%Y');

ALTER TABLE coffee_shop_sales
DROP COLUMN transaction_date;

ALTER TABLE coffee_shop_sales
CHANGE COLUMN temp_transaction_date transaction_date DATE;


UPDATE coffee_shop_sales
SET transaction_time = STR_TO_DATE(transaction_time, '%H:%i:%s');
 ALTER TABLE coffee_shop_sales
 MODIFY COLUMN transaction_time TIME;
 

 Describe coffee_shop_sales;
 
 -- TOTAL SALES FOR EACH MONTH --
Select ROUND(SUM(unit_price*transaction_qty)) AS total_sales 
FROM coffee_shop_sales
WHERE MONTH (transaction_date)=5;



SELECT 
  MONTH(transaction_date) AS month,
  ROUND(SUM(unit_price * transaction_qty)) AS total_sales,
  ROUND(
    (SUM(unit_price * transaction_qty) - 
     LAG(SUM(unit_price * transaction_qty)) OVER(ORDER BY MONTH(transaction_date))) / 
     LAG(SUM(unit_price * transaction_qty)) OVER(ORDER BY MONTH(transaction_date)) * 100, 
    1
  ) AS month_increase_percentage
FROM coffee_shop_sales
WHERE MONTH(transaction_date) IN (4, 5)
GROUP BY MONTH(transaction_date)
ORDER BY month;

ALTER TABLE coffee_shop_sales 
ADD COLUMN month_increase_percentages DECIMAL(5,2);


SELECT COUNT(transaction_id) AS total_orders
FROM coffee_shop_sales
WHERE 
month(transaction_date)=3;