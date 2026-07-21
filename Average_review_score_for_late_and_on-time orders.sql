-- Average review score for late vs on-time orders

SELECT CASE WHEN  order_delivered_customer_date::date > order_estimated_delivery_date::date THEN 'late' ELSE 'on_time' END AS delivery_status, 
COUNT(*) AS order_count,
ROUND(AVG(review_score),2)AS avg_review FROM orders
JOIN order_reviews ON orders.order_id = order_reviews.order_id
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status
