# FROM registry.bdc.home:5000/hdc

# ARG GIT_CONFIG_DIR
# ARG AIRFLOW_DIR
# ARG GIT_CONFIG_ADDRESS
# ARG GIT_AIRFLOW_ADDRESS
# ARG DOCKER_DIR

# WORKDIR $DOCKER_DIR

# RUN git clone $GIT_CONFIG_ADDRESS
# # RUN git clone $GIT_AIRFLOW_ADDRESS
# RUN rsync -avru $GIT_CONFIG_DIR/s_scripts/ s_scripts

# # Start Scripts config
# RUN mkdir -p airflow /run/airflow

# RUN useradd -m -d /root/airflow airflow
# RUN echo airflow:airflow | chpasswd
# RUN usermod -aG sudo airflow

# ENTRYPOINT ["/root/s_scripts/air-flow.sh"]

ARG PY_VER

FROM python:${PY_VER}

ARG AWS_SPARK
ARG COMMON_POOL_VER
ARG DOCKER_DIR
ARG ICEBERG_SPARK_VER
ARG ICEBERG_VER
ARG KAFKA_CLIENT_VER
ARG NESSIE_SPARK_VER
ARG NESSIE_VER
ARG SCALA_VERSION
ARG SPARK_VERSION
ARG SPARK_SQL_KAFKA_VER
ARG GIT_CONFIG_DIR
ARG AIRFLOW_DIR
ARG GIT_CONFIG_ADDRESS
ARG GIT_AIRFLOW_ADDRESS

# Java installation
RUN apt update && apt upgrade -y && apt install -y gnupg ca-certificates curl rsync
RUN curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list
RUN apt-get update && apt-get -y install zulu11-jdk
RUN apt-get -y autoremove && apt-get -y clean

# Pip & other Python library installation
RUN pip3 install --upgrade pip
RUN pip3 install uv

WORKDIR ${DOCKER_DIR}

# RUN git clone $GIT_AIRFLOW_ADDRESS
RUN mkdir s_scripts airflow
RUN git clone $GIT_CONFIG_ADDRESS
RUN rsync -avru $GIT_CONFIG_DIR/s_scripts/ s_scripts

# Start Scripts config
# RUN mkdir -p /mnt/devCode 
# RUN chmod -R 777 /mnt/devCode

RUN echo "" >> .bashrc
RUN echo "########JAVA Export########" >> .bashrc
RUN echo "export JAVA_HOME=/usr/lib/jvm/zulu11/" >> .bashrc
RUN echo "" >> .bashrc

RUN wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-${ICEBERG_SPARK_VER}_${SCALA_VERSION}/${ICEBERG_VER}/iceberg-spark-runtime-${ICEBERG_SPARK_VER}_${SCALA_VERSION}-${ICEBERG_VER}.jar -P /root/spark/jars/
RUN wget https://repo.maven.apache.org/maven2/org/projectnessie/nessie-integrations/nessie-spark-extensions-${NESSIE_SPARK_VER}_${SCALA_VERSION}/${NESSIE_VER}/nessie-spark-extensions-${NESSIE_SPARK_VER}_${SCALA_VERSION}-${NESSIE_VER}.jar -P /root/spark/jars/
RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-sql-kafka-${SPARK_SQL_KAFKA_VER}_${SCALA_VERSION}/${SPARK_VERSION}/spark-sql-kafka-${SPARK_SQL_KAFKA_VER}_${SCALA_VERSION}-${SPARK_VERSION}.jar -P /root/spark/jars/
RUN wget https://repo1.maven.org/maven2/org/apache/commons/commons-pool2/${COMMON_POOL_VER}/commons-pool2-${COMMON_POOL_VER}.jar -P /root/spark/jars/
RUN wget https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/${KAFKA_CLIENT_VER}/kafka-clients-${KAFKA_CLIENT_VER}.jar -P /root/spark/jars/
RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-token-provider-kafka-${SPARK_SQL_KAFKA_VER}_${SCALA_VERSION}/${SPARK_VERSION}/spark-token-provider-kafka-${SPARK_SQL_KAFKA_VER}_${SCALA_VERSION}-${SPARK_VERSION}.jar -P /root/spark/jars/
RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-avro_${SCALA_VERSION}/${SPARK_VERSION}/spark-avro_${SCALA_VERSION}-${SPARK_VERSION}.jar -P /root/spark/jars/
# RUN wget https://repo1.maven.org/maven2/software/amazon/awssdk/bundle/${AWS_SPARK}/bundle-${AWS_SPARK}.jar -P /root/spark/jars/
# RUN wget https://repo1.maven.org/maven2/software/amazon/awssdk/url-connection-client/${AWS_SPARK}/url-connection-client-${AWS_SPARK}.jar -P /root/spark/jars/


ENTRYPOINT ["/root/s_scripts/air-flow.sh"]