{%- set dim_column_name = 'payment_method' -%}
{%- set agg_column_name = 'amount' -%}
{%- set my_query -%}
SELECT DISTINCT {{ dim_column_name }} FROM {{ ref('fct_sales') }} ;
{%- endset -%}
{%- set results = run_query(my_query) -%}
{%- if execute -%}
{%- set items = results.columns[0].values() -%}
{%- endif %}

SELECT 
    c.customer_id,
    first_name || ' ' || last_name AS customer_name,
    sum(amount) AS total_amount,
    {% for item in items %}
    SUM(CASE WHEN {{dim_column_name}} = '{{item}}' THEN {{agg_column_name}} END) AS {{item}}_{{agg_column_name}}
    {%- if not loop.last -%} , {%- endif %}
    {% endfor %}

FROM {{ ref('fct_sales') }} s
JOIN {{ ref('dim_customers') }} c
ON (s.customer_id = c.customer_id)
GROUP BY c.customer_id, customer_name
