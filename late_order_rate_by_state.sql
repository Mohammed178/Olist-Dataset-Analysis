SELECT customer_state , COUNT(*) AS total_orders, COUNT(*) FILTER (WHERE order_delivered_customer_date > order_estimated_delivery_date) AS late_orders, 
ROUND(100.0 * COUNT(*) FILTER (WHERE order_delivered_customer_date >  order_estimated_delivery_date) / COUNT(*),2) AS late_rate_perc
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY customer_state HAVING COUNT(*) >= 100
ORDER BY late_rate_perc DESC
