SELECT 
    c.customer_id,
    c.customer_name,
--    (SELECT MAX(email) FROM {{ ref('dim_customers') }} d WHERE d.customer_id = c.customer_id GROUP BY d.customer_id) AS customer_email,
    COUNT(s.sale_id) AS number_of_orders,
    SUM(s.amount) AS total_amount,
    MIN(s.amount) AS min_amount,
    MAX(s.amount) AS max_amount,
    ROUND(AVG(s.amount), 2) AS avg_amount
FROM 
(SELECT sale_id, customer_id, amount FROM {{ ref('fct_sales') }} ) s
JOIN 
(SELECT customer_id, first_name || ' ' || last_name AS customer_name FROM {{ ref('dim_customers') }} ) c 
ON (s.customer_id = c.customer_id) 
--WHERE EXISTS (SELECT 1 FROM {{ ref('dim_customers') }} d WHERE d.customer_id = c.customer_id GROUP BY customer_source_id HAVING COUNT(1) = 1)
GROUP BY 
    c.customer_id,
    c.customer_name
--    ,customer_email
--HAVING total_amount = (SELECT MAX(sum) FROM (SELECT SUM(amount) AS sum FROM {{ ref('fct_sales') }} GROUP BY customer_id))
ORDER BY total_amount DESC
