{{
    config(
        materialized = 'view'
    )
}}

with payments as (
    
    select
        payment_id,
        order_id,
        payment_method,
        status,
        amount/100 as amount_USD,
        created

    from {{ ref('stg_payments')}}
)

select * from payments