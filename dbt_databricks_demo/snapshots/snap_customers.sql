{% snapshot snap_customers %}

{{
        config(
          target_schema = 'dbt_target_staging',
          strategy = 'check',
          unique_key = 'id',
          check_cols = ['first_name', 'last_name', 'email'],
          invalidate_hard_deletes = True,
        )
    }}

select id, first_name, last_name, email from {{ source('jaffle_shop', 'jaffle_shop_customers') }}

{% endsnapshot %}