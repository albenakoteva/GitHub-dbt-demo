{{
    config(
        materialized = 'incremental',
        unique_key = 'customer_id'
    )
}}

with customers as (

    select dbt_scd_id as customer_id,
        dbt_updated_at as updated_at,
        dbt_valid_from as valid_from,
        coalesce(dbt_valid_to, '{{ var('valid_to_timestamp') }}' ) as valid_to,
        id as customer_source_id,
        first_name,
        last_name,
        email 
    from {{ ref('snap_customers') }}
    {% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    -- new rows are inserted, existing rows (regarding the unique_key value) are updated
    where dbt_updated_at >= (select dateadd(max(updated_at), {{ var('days_offset_incr_load') }} ) from {{ this }})

    {% endif %}

)

select * from customers