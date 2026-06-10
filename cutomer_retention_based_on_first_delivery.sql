WITH order_history AS (
  SELECT
    c.customer_unique_id,
    o.order_purchase_timestamp,
    CASE
      WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'late'
      ELSE 'on_time'
    END AS delivery_status,
    ROW_NUMBER() OVER (
      PARTITION BY c.customer_unique_id
      ORDER BY o.order_purchase_timestamp
    ) AS order_seq,
    COUNT(*) OVER (
      PARTITION BY c.customer_unique_id
    ) AS total_orders
  FROM orders o
  JOIN customers c ON o.customer_id = c.customer_id
  WHERE o.order_delivered_customer_date IS NOT NULL
)
SELECT
  delivery_status AS first_order_status,
  COUNT(*) AS num_customers,
  COUNT(*) FILTER (WHERE total_orders >= 2) AS returned,
  ROUND(
    100.0 * COUNT(*) FILTER (WHERE total_orders >= 2) / COUNT(*),
    2
  ) AS return_rate_pct
FROM order_history
WHERE order_seq = 1   
GROUP BY delivery_status
ORDER BY delivery_status;
