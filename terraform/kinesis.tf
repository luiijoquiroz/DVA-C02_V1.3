locals {
    stream = {
    stream_name = "kinesis-${local.enviroment}-stream"
        
    }
}
# Creación de un Kinesis Data Stream
resource "aws_kinesis_stream" "demo_stream" {
  name             = local.stream.stream_name
  shard_count      = 1  # Número de shards (unidades de capacidad)
  retention_period = 24 # Retención de datos en horas (mínimo 24, máximo 168)

  shard_level_metrics = [ # Métricas opcionales por shard
    "IncomingBytes",
    "OutgoingBytes"
  ]

  tags = merge(local.default_tags, {
    Name = local.stream.stream_name
  })
}