locals {
    s3 = {
        data_bucket_name = "data-bucket-${local.project}-${local.enviroment}"
        query_results_bucket_name = "query-results-${local.project}-${local.enviroment}"
    }
    
    table_name = "sales-${local.enviroment}-table"
    database_name = "sales-${local.enviroment}-db"
}

# 1. Bucket S3 para datos de entrada
resource "aws_s3_bucket" "data_bucket" {
  bucket = local.s3.data_bucket_name
  force_destroy = true  # Permite borrar el bucket con contenido (solo para pruebas)
}

# 2. Bucket S3 para resultados de Athena
resource "aws_s3_bucket" "query_results" {
  bucket = local.s3.query_results_bucket_name
  force_destroy = true
}

# 3. Subir datos de ejemplo al bucket
resource "aws_s3_object" "sales_demo_data" {
  bucket = aws_s3_bucket.data_bucket.id
  key    = "data/sales_data.csv"
  source = "data/sales_data.csv"
  etag   = filemd5("data/sales_data.csv")
}

# 4. Glue Catalog Database
resource "aws_glue_catalog_database" "example_db" {
  name = local.database_name
}

# 5. Glue Catalog Table (esquema de datos)
resource "aws_glue_catalog_table" "sales_table" {
  name          = local.table_name
  database_name = aws_glue_catalog_database.example_db.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL              = "TRUE"
    "skip.header.line.count" = "1"  # Ignorar cabecera del CSV
  }

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.data_bucket.bucket}/data/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "csv"
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"
      parameters = {
        "separatorChar" = ","
      }
    }

    # Definición de columnas (ejemplo: id,product,amount)
    columns {
      name = "id"
      type = "int"
    }
    columns {
      name = "product"
      type = "string"
    }
    columns {
      name = "amount"
      type = "double"
    }
  }
}

# 6. Rol IAM para ejecutar queries en Athena
resource "aws_iam_role" "athena_role" {
  name = "athena_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "athena.amazonaws.com"
        }
      }
    ]
  })
}

# 7. Política para acceder a los buckets S3
resource "aws_iam_policy" "s3_access" {
  name = "athena_s3_access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads",
          "s3:ListMultipartUploadParts",
          "s3:AbortMultipartUpload",
          "s3:PutObject"
        ]
        Resource = [
          aws_s3_bucket.data_bucket.arn,
          "${aws_s3_bucket.data_bucket.arn}/*",
          aws_s3_bucket.query_results.arn,
          "${aws_s3_bucket.query_results.arn}/*"
        ]
      }
    ]
  })
}

# 8. Adjuntar política al rol
resource "aws_iam_role_policy_attachment" "athena_s3" {
  role       = aws_iam_role.athena_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}

# 9. Crear una tabla en Athena
resource "aws_athena_workgroup" "demo_athena_workgroup" {
  name = "athena-workgroup-${local.enviroment}"

  configuration {
    enforce_workgroup_configuration = true
    result_configuration {
      output_location = "s3://${aws_s3_bucket.query_results.bucket}/output/"
    }
  }
}

# 10. Crear una consulta en Athena
resource "aws_athena_named_query" "sales_query" {
  name = "sales-query-${local.enviroment}"
  database = aws_glue_catalog_database.example_db.name
  query = "SELECT * FROM ${aws_glue_catalog_table.sales_table.name}"
}

# Ejecutar una Query en Athena
#- Ve a la consola de [Amazon Athena](https://us-east-1.console.aws.amazon.com/athena/home?region=us-east-1#).
#- Selecciona la base de datos sales-develop-db.
#- Ejecuta una consulta de prueba:
#```sql
#SELECT * FROM sales_data WHERE amount > 500;
# ```
#- Los resultados se guardarán en: s3://query-results-demo-develop/output/