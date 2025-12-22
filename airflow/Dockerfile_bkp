ARG AIRFLOW_VER

FROM apache/airflow:${AIRFLOW_VER}

# ARG DOCKER_DIR
ARG GIT_CONFIG_DIR
ARG GIT_CONFIG_ADDRESS
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

USER airflow

# WORKDIR ${DOCKER_DIR}

# Configuration Scripts
# WORKDIR /opt
# RUN mkdir s_scripts
# RUN git clone $GIT_CONFIG_ADDRESS
# RUN rsync -avru $GIT_CONFIG_DIR/s_scripts/ s_scripts
# RUN chmod -R +x s_scripts

# Install PY Packages
RUN pip3 install --upgrade pip
RUN pip3 install apache-airflow[redis,celery,postgres] "flask-appbuilder<5.0.0" apache-airflow-providers-apache-spark apache-airflow-providers-trino apache-airflow-providers-git pyspark==${SPARK_VERSION} psycopg2-binary
