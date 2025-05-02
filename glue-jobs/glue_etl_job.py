# glue-jobs/glue_etl_job.py
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

# Setup
args = getResolvedOptions(sys.argv, ['JOB_NAME'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# Read from S3 JSON
datasource = glueContext.create_dynamic_frame.from_options(
    connection_type="s3",
    connection_options={"paths": ["s3://your-bucket-name/transactions/"]},
    format="json"
)

# Transformations (example)
mapped = ApplyMapping.apply(
    frame=datasource,
    mappings=[
        ("transaction_id", "string", "transaction_id", "string"),
        ("product_id", "int", "product_id", "int"),
        ("price", "int", "price", "int")
    ]
)

# Write to S3
glueContext.write_dynamic_frame.from_options(
    frame=mapped,
    connection_type="s3",
    connection_options={"path": "s3://your-bucket-name/processed/"},
    format="parquet"
)

job.commit()
