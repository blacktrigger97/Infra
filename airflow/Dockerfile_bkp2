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

ARG DOCKER_DIR
ARG SPARK_VERSION
ARG GIT_CONFIG_DIR
ARG GIT_CONFIG_ADDRESS

# Java installation
RUN apt update && apt upgrade -y && apt install -y gnupg ca-certificates curl rsync
RUN curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list
RUN apt-get update && apt-get -y install zulu11-jdk
RUN apt-get -y autoremove && apt-get -y clean

# Pip & other Python library installation
RUN pip3 install --upgrade pip
RUN pip3 install apache-airflow apache-airflow-providers-apache-spark pyspark==${SPARK_VERSION} psycopg2-binary asyncpg apache-airflow-providers-fab

WORKDIR ${DOCKER_DIR}

# RUN git clone $GIT_AIRFLOW_ADDRESS
RUN mkdir s_scripts airflow
RUN git clone $GIT_CONFIG_ADDRESS
RUN rsync -avru $GIT_CONFIG_DIR/s_scripts/ s_scripts

# JAVA HOMe Configuration
ENV JAVA_HOME /usr/lib/jvm/zulu11/
