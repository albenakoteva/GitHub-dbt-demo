from pyspark.sql.functions import *


def check_for_freshness():
    df_orders = spark.read.table("dbt_source.jaffle_shop_orders")
    df_payments = spark.read.table("dbt_source.jaffle_shop_payments")
    new_orders = df_orders.filter(
        col("order_timestamp") >= date_add(current_timestamp(), -1)).count()
    new_payments = df_payments.filter(
        col("created_timestamp") >= date_add(current_timestamp(), -1)).count()

    return new_orders + new_payments


if __name__ == "__main__":
    new_rows = check_for_freshness()
    assert new_rows > 0, "There is no new data for loading."
