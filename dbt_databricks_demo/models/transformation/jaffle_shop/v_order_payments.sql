with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as ( 
    select * from {{ ref('stg_payments') }}
),

customers as ( 
    select * from {{ ref('dim_customers') }}
)

select 
    o.order_id,
    c.customer_id,
    o.order_date,
    o.order_timestamp,
    o.status as order_status,
    p.payment_id,
    p.payment_method,
    p.status as payment_status,
    p.amount,
    p.created as payment_date,
    p.created_timestamp as payment_timestamp

from orders o
join payments p on (o.order_id = p.order_id) 
join customers c on (o.customer_id = c.customer_source_id and o.order_timestamp >= c.valid_from and o.order_timestamp < c.valid_to)