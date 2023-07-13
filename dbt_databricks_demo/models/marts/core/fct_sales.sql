{{
    config(
        materialized = 'incremental',
        unique_key = 'sale_id'
    )
}}

WITH order_payments AS (
    SELECT 
        order_id,
        customer_id,
        order_date,
        order_timestamp,
        payment_id,
        payment_method,
        amount,
        payment_date,
        payment_timestamp
    FROM {{ ref('v_order_payments') }}
    WHERE payment_status = 'success'
    AND order_status = 'completed'
    {% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    -- new rows are inserted, existing rows (regarding the unique_key value) are updated
    AND order_timestamp >= (select dateadd(max(order_timestamp), {{ var('days_offset_incr_load') }} ) from {{ this }})

    {% endif %}

)

SELECT 
    {{ dbt_utils.generate_surrogate_key([
                'order_id',
                'payment_id'
            ])
    }} as sale_id,
    order_id,
    customer_id,
    order_date,
    order_timestamp,
    payment_id,
    payment_method,
    amount,
    payment_date,
    payment_timestamp
FROM order_payments