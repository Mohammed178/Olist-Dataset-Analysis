-- calculating delay in days
WITH delays AS (
  SELECT
    review_score,
    EXTRACT(DAY FROM order_delivered_customer_date - order_estimated_delivery_date) AS days_late
  FROM orders
  JOIN order_reviews ON orders.order_id = order_reviews.order_id
  WHERE order_delivered_customer_date IS NOT NULL
)
SELECT
CASE
  WHEN days_late <= 0  THEN 'early/on-time'
  WHEN days_late <= 3  THEN '1-3 days late'
  WHEN days_late <= 7  THEN '4-7 days late'
  WHEN days_late <= 15 THEN '8-15 days late'
  ELSE '16+ days late'
END AS bucket,
  COUNT(*) AS order_count,
  ROUND(AVG(review_score), 2) AS avg_review_score
FROM delays
GROUP BY bucket
ORDER BY MIN(days_late);
