{{
    config(
        materialized = 'incremental',
        unique_key = 'order_id'
    )
}}


with orders as (
    
    select
        id as order_id,
        user_id as customer_id,
        order_date,
        order_timestamp,
        status
    from {{ source('jaffle_shop', 'jaffle_shop_orders') }}
    {% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    -- new rows are inserted, existing rows (regarding the unique_key value) are updated
    where order_timestamp >= (select dateadd(max(order_timestamp), {{ var('days_offset_incr_load') }} ) from {{ this }})

    {% endif %}
)

select * from orders