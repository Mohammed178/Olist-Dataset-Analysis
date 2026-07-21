-- Late Delivery Rate by Month.
-- What percentage of orders arrived after their estimated delivery date, broken down by month?
SELECT
  DATE_TRUNC('month', order_purchase_timestamp) AS month,
  COUNT(*) AS total_orders,
  COUNT (*)FILTER ( WHERE order_delivered_customer_date::date > order_estimated_delivery_date::date) as late_orders,
  ROUND (100.0 * COUNT(*) FILTER( WHERE order_delivered_customer_date::date > order_estimated_delivery_date::date) / COUNT(*), 2) as late_perc
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY month
ORDER BY late_perc DESC;

