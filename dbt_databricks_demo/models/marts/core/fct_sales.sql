WITH order_payments AS (
    SELECT 
        order_id,
        customer_id,
        order_date,
        payment_id,
        payment_method,
        amount,
        payment_date 
    FROM {{ ref('v_order_payments') }}
    WHERE payment_status = 'success'
    AND order_status = 'completed'

)

SELECT 
    order_id,
    customer_id,
    order_date,
    payment_id,
    payment_method,
    amount,
    payment_date 
FROM order_payments