ARG PY_VER

FROM python:${PY_VER}

ARG AIRFLOW_IMAGE_NAME
ARG DOCKER_DIR
ARG SPARK_VERSION
ARG GIT_CONFIG_DIR
ARG GIT_CONFIG_ADDRESS
ARG GIT_AIRFLOW_ADDRESS

# Java installation
RUN apk upgrade && apk add --upgrade apk-tools && apk upgrade --available && apk add curl rsync openjdk11-jdk gcc openssh-client bash ripgrep git lz4-dev
# RUN apt update && apt upgrade -y && apt install -y gnupg ca-certificates curl rsync
# RUN curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg
# RUN echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list
# RUN apt-get update && apt-get -y install zulu11-jdk
# RUN apt-get -y autoremove && apt-get -y clean

# Set JAVA_HOME environment variable
# ENV JAVA_HOME /usr/lib/jvm/zulu11/
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk/

WORKDIR ${DOCKER_DIR}

# Start scripts
RUN mkdir s_scripts airflow /run/airflow
RUN git clone $GIT_CONFIG_ADDRESS
RUN rsync -avru $GIT_CONFIG_DIR/s_scripts/ s_scripts

COPY requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install uv
RUN uv pip install apache-airflow[redis,celery,postgres]==${AIRFLOW_IMAGE_NAME} -r requirements.txt --system
# pyspark==${SPARK_VERSION} -r requirements.txt

ENV INFRA_ENV="DEV"