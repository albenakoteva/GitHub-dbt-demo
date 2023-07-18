{{
    config(
        materialized = 'incremental',
        unique_key = 'payment_id'
    )
}}

with payments as (
    
    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,
        amount,
        created,
        created_timestamp
    from {{ source('jaffle_shop', 'jaffle_shop_payments') }}
    {% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    -- new rows are inserted, existing rows (regarding the unique_key value) are updated
    where created_timestamp >= (select dateadd(max(created_timestamp), {{ var('days_offset_incr_load') }} ) from {{ this }})

    {% endif %}
)

select * from payments