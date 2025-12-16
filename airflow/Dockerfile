FROM apache/airflow:slim-3.1.4rc2-python3.11

ARG SPARK_VERSION

USER root

# Java installation
RUN apt update && apt upgrade -y && apt install -y gnupg ca-certificates curl rsync
RUN curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list
RUN apt-get update && apt-get -y install zulu11-jdk
RUN apt-get -y autoremove && apt-get -y clean

# Set JAVA_HOME environment variable
ENV JAVA_HOME /usr/lib/jvm/zulu11/

RUN mkdir -p /opt/airflow/jobs /opt/airflow/logs
RUN chmod -R 777 /opt/airflow/logs
RUN chmod u+s /opt/airflow/jobs

USER airflow

RUN pip3 install --upgrade pip
RUN pip3 install apache-airflow apache-airflow-providers-apache-spark pyspark==${SPARK_VERSION} psycopg2-binary asyncpg apache-airflow-providers-fab