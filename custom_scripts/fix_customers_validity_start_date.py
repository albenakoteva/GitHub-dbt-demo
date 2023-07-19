from pyspark.sql.functions import *


def fix_customers_validity_start_date():
    df_customers = spark.read.table("dbt_target_bronze.snap_customers")
    total_rows = df_customers.count()
    recent_rows = df_customers.filter(
        (datediff(current_timestamp(), col("dbt_updated_at")) < 1)).count()
    # print(recent_rows)
    if total_rows == recent_rows:
        df_customers = df_customers.withColumn("dbt_updated_at", lit(
            '2023-03-16T00:00:00.000+0000')).withColumn("dbt_valid_from", lit('2023-03-16T00:00:00.000+0000'))
        df_customers.write.format("delta").mode("overwrite").option(
            "overwriteSchema", "true").saveAsTable("dbt_target_bronze.snap_customers")

    return


if __name__ == "__main__":
    fix_customers_validity_start_date()
