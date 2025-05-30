# Análisis: 
## [Amazon Athena](https://docs.aws.amazon.com/es_es/athena/latest/ug/what-is.html):
es un servicio de consultas interactivas sin servidor que te permite analizar datos almacenados en Amazon S3 utilizando SQL estándar. Funciona directamente con los datos en S3, sin necesidad de cargarlos ni administrar infraestructura. Athena permite ejecutar consultas ad-hoc, analizar logs, y realizar análisis de datos sin estructurar, semiestructurados o estructurados. 
### Funcionalidades clave:
- Análisis interactivo:
Puedes realizar consultas SQL sobre tus datos en S3 de forma rápida e interactiva. 
- Sin servidor:
No necesitas configurar ni administrar ningún servidor, lo que facilita el análisis de datos. 
- SQL estándar:
Utiliza SQL estándar para realizar tus consultas, lo que facilita la integración con otras herramientas y sistemas. 
- Compatibilidad con múltiples formatos:
Athena soporta formatos de datos como CSV, JSON, Parquet y ORC, entre otros. 
- Facturación por uso:
Solo pagas por los datos que escaneas en tus consultas, lo que optimiza los costos. 
### Casos de uso:
- Análisis de registros:
Puedes analizar logs de VPC, CloudTrail, Apache y Nginx, entre otros, para obtener información valiosa sobre tu infraestructura y aplicaciones. 
- Análisis de datos semiestructurados:
Puedes analizar datos semiestructurados almacenados en S3, como logs de aplicaciones y datos web. 
- Análisis de datos estructurados:
Puedes utilizar Athena para analizar datos estructurados almacenados en S3, como bases de datos relacionales o archivos CSV. 
- Análisis de big data:
Athena puede utilizarse para el análisis de datos de gran tamaño almacenados en S3. 
### Ventajas:
- Rapidez: Las consultas son rápidas y fáciles de ejecutar.
- Facilidad de uso: No requiere conocimientos técnicos complejos.
- Ahorro de costos: Solo pagas por lo que utilizas.
- Escalabilidad: Puedes escalar el servicio según tus necesidades. 
Para empezar a utilizar Athena, simplemente debes apuntar a tus datos en S3, definir el esquema de las tablas y comenzar a realizar consultas SQL estándar. 


## [Amazon Kinesis](https://docs.aws.amazon.com/es_es/whitepapers/latest/how-aws-pricing-works/amazon-kinesis.html#:~:text=Amazon%20Kinesis%20le%20permite%20procesar,para%20obtener%20informaci%C3%B3n%20al%20respecto.):
 procesar datos en tiempo real a gran escala. Permite la ingesta, almacenamiento y procesamiento de datos de streaming, lo que facilita la obtención de información rápida y la respuesta a nuevas situaciones. Ofrece diferentes servicios como Kinesis Data Streams, Kinesis Data Firehose y Kinesis Data Analytics, cada uno con capacidades específicas para diferentes casos de uso. 
### En detalle:
- [Amazon Kinesis Data Streams](https://docs.aws.amazon.com/es_es/whitepapers/latest/how-aws-pricing-works/amazon-kinesis.html#amazon-kinesis-video-streams):
Es un servicio de streaming de datos de larga duración y escalable para procesar y almacenar datos en tiempo real. Permite capturar gigabytes de datos por segundo de cientos de miles de fuentes. 
- Amazon Kinesis Data Firehose:
Facilita la entrega de datos en tiempo real directamente a almacenes de datos de AWS como S3, Redshift, Elasticsearch o Splunk. Es útil para necesidades de entrega de datos más sencillas sin procesamiento personalizado. 
- Amazon Kinesis Data Analytics:
Simplifica el procesamiento de datos de streaming en tiempo real con SQL o Apache Flink, sin necesidad de aprender nuevos lenguajes o marcos de procesamiento. 
Amazon Kinesis Video Streams:
Es un servicio para capturar, procesar y almacenar transmisiones de video de forma segura para análisis y aprendizaje automático. 
En resumen: Kinesis es una plataforma integral para el procesamiento de datos en tiempo real, que ofrece opciones para la ingesta, el almacenamiento, la entrega y el análisis de datos de streaming, lo que permite obtener información rápidamente y responder a los cambios en tiempo real. 
## Amazon OpenSearch Service 

# Integración de aplicaciones: 
## AWS AppSync 
## Amazon EventBridge 
## Amazon Simple Notification Service (Amazon SNS) 
## Amazon Simple Queue Service (Amazon SQS) 
## AWS Step Functions 