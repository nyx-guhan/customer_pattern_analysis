USE customer_analysis;

SELECT * FROM customer_data limit 10;

SELECT COUNT(*) FROM customer_data;

-- Total revenue by male vs female customers

SELECT gender, SUM(purchase_amount) AS revenue
FROM customer_data
GROUP BY gender;

-- Find the person used discount and spend more than avg purchase amount

SELECT customer_id, purchase_amount 
FROM  customer_data
WHERE discount_applied = 'Yes' AND purchase_amount >= (SELECT AVG(purchase_amount) FROM customer_data);

-- top 5 review product by avg

SELECT item_purchased, ROUND(AVG(review_rating),2) AS top_5
FROM customer_data
GROUP BY item_purchased 
ORDER BY AVG(review_rating)
LIMIT 5;

-- standard vs express delivery

SELECT * FROM customer_data limit 10;

SELECT shipping_type, AVG(purchase_amount)
FROM customer_data
WHERE shipping_type IN ('Standard','Express')
GROUP BY shipping_type;

-- membership vs normal customers

SELECT subscription_status, COUNT(customer_id), SUM(purchase_amount)
FROM customer_data
GROUP BY subscription_status;

-- customer segment by previous purchase

WITH customer_type AS(
SELECT customer_id, previous_purchases,
CASE
    WHEN previous_purchases = 1 THEN 'New'
    WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
    ELSE 'Loyal'
    END AS customer_segment
FROM customer_data
)

SELECT customer_segment, COUNT(*)
FROM customer_type
GROUP BY customer_segment;



