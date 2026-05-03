ARG PY_VER

FROM python:${PY_VER}

ARG AIRFLOW_IMAGE_NAME
ARG DOCKER_DIR
ARG SPARK_VERSION
ARG GIT_CONFIG_DIR
ARG GIT_CONFIG_ADDRESS
ARG GIT_AIRFLOW_ADDRESS

# Java installation
RUN apk upgrade && apk add --upgrade apk-tools && apk upgrade --available && apk add curl rsync ripgrep git musl-dev lz4-dev gcc cifs-utils bash librdkafka-dev openssh-client openjdk11-jdk
# openjdk11-jdk openssh-client bash

WORKDIR ${DOCKER_DIR}

# Start scripts
RUN mkdir s_scripts airflow /run/airflow
RUN git clone $GIT_CONFIG_ADDRESS
RUN rsync -avru $GIT_CONFIG_DIR/s_scripts/ s_scripts

COPY requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install uv
RUN uv pip install apache-airflow[redis,celery,postgres]==${AIRFLOW_IMAGE_NAME} -r requirements.txt --system
# pyspark==${SPARK_VERSION}

# Set JAVA_HOME environment variable
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk/
ENV INFRA_ENV="DEV"