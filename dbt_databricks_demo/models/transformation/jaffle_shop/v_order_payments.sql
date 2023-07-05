with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as ( 
    select * from {{ ref('stg_payments') }}
)

select 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status as order_status,
    p.payment_id,
    p.payment_method,
    p.status as payment_status,
    p.amount,
    p.created as payment_date

from orders o
join payments p on (o.order_id = p.order_id) 