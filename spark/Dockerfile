ARG SPARK_VERSION

FROM bitnami/spark:${SPARK_VERSION}

ARG AWS_SPARK
ARG COMMON_POOL_VER
ARG ICEBERG_SPARK_VER
ARG ICEBERG_VER
ARG KAFKA_CLIENT_VER
ARG NESSIE_SPARK_VER
ARG NESSIE_VER
ARG SCALA_VERSION
ARG SPARK_VERSION
ARG SPARK_SQL_KAFKA_VER

USER root
RUN install_packages curl
USER 1001
RUN mkdir /opt/bitnami/spark/extraJars
RUN curl https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-${ICEBERG_SPARK_VER}_${SCALA_VERSION}/${ICEBERG_VER}/iceberg-spark-runtime-${ICEBERG_SPARK_VER}_${SCALA_VERSION}-${ICEBERG_VER}.jar --output /opt/bitnami/spark/jars/iceberg-spark-runtime-${ICEBERG_SPARK_VER}_${SCALA_VERSION}-${ICEBERG_VER}.jar
RUN curl https://repo.maven.apache.org/maven2/org/projectnessie/nessie-integrations/nessie-spark-extensions-${NESSIE_SPARK_VER}_${SCALA_VERSION}/${NESSIE_VER}/nessie-spark-extensions-${NESSIE_SPARK_VER}_${SCALA_VERSION}-${NESSIE_VER}.jar --output /opt/bitnami/spark/jars/nessie-spark-extensions-${NESSIE_SPARK_VER}_${SCALA_VERSION}-${NESSIE_VER}.jar
RUN curl https://repo1.maven.org/maven2/org/apache/spark/spark-sql-kafka-${SPARK_SQL_KAFKA_VER}_${SCALA_VERSION}/${SPARK_VERSION}/spark-sql-kafka-${SPARK_SQL_KAFKA_VER}_${SCALA_VERSION}-${SPARK_VERSION}.jar --output /opt/bitnami/spark/jars/spark-sql-kafka-${SPARK_SQL_KAFKA_VER}_${SCALA_VERSION}-${SPARK_VERSION}.jar
RUN curl https://repo1.maven.org/maven2/org/apache/commons/commons-pool2/${COMMON_POOL_VER}/commons-pool2-${COMMON_POOL_VER}.jar --output /opt/bitnami/spark/jars/commons-pool2-${COMMON_POOL_VER}.jar
RUN curl https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/${KAFKA_CLIENT_VER}/kafka-clients-${KAFKA_CLIENT_VER}.jar --output /opt/bitnami/spark/jars/kafka-clients-${KAFKA_CLIENT_VER}.jar 
RUN curl https://repo1.maven.org/maven2/org/apache/spark/spark-token-provider-kafka-${SPARK_SQL_KAFKA_VER}_${SCALA_VERSION}/${SPARK_VERSION}/spark-token-provider-kafka-${SPARK_SQL_KAFKA_VER}_${SCALA_VERSION}-${SPARK_VERSION}.jar --output /opt/bitnami/spark/jars/spark-token-provider-kafka-${SPARK_SQL_KAFKA_VER}_${SCALA_VERSION}-${SPARK_VERSION}.jar
RUN curl https://repo1.maven.org/maven2/org/apache/spark/spark-avro_${SCALA_VERSION}/${SPARK_VERSION}/spark-avro_${SCALA_VERSION}-${SPARK_VERSION}.jar --output /opt/bitnami/spark/jars/spark-avro_${SCALA_VERSION}-${SPARK_VERSION}.jar
# RUN curl https://repo1.maven.org/maven2/software/amazon/awssdk/bundle/${AWS_SPARK}/bundle-${AWS_SPARK}.jar --output /opt/bitnami/spark/jars/bundle-${AWS_SPARK}.jar
# RUN curl https://repo1.maven.org/maven2/software/amazon/awssdk/url-connection-client/${AWS_SPARK}/url-connection-client-${AWS_SPARK}.jar --output /opt/bitnami/spark/jars/url-connection-client-${AWS_SPARK}.jar