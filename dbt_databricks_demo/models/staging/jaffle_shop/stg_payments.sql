with payments as (
    
    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,
        amount,
        created
    from {{ source('dbt_source', 'jaffle_shop_payments') }}
)

select * from payments