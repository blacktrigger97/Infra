ARG PY_VER

FROM python:${PY_VER}

ARG DOCKER_USR
ARG DOCKER_DIR
ARG DOCKER_PASS
ARG GIT_DIR
ARG GIT_CONFIG_ADDRESS
ARG AIRFLOW_VER
ARG GIT_AIRFLOW_ADDRESS


# OS required package installation
RUN apt update && apt upgrade -y && apt install -y gnupg ca-certificates curl rsync
RUN apt-get -y install make net-tools wget gcc git openssh-server which procps libpq-dev libsqlite3-dev libssl-dev libbz2-dev libffi-dev zlib1g-dev
RUN systemctl enable ssh

# Pip & other Python library installation
RUN pip3 install --upgrade pip
RUN pip3 install importlib-metadata
RUN pip3 install apache-airflow==${AIRFLOW_VER}
RUN pip3 install apache-airflow[celery]==${AIRFLOW_VER}
RUN pip3 install apache-airflow[rabbitmq]==${AIRFLOW_VER}
RUN pip3 install psycopg2

# SSH configuration
RUN echo ${DOCKER_USR}:${DOCKER_PASS} | chpasswd
RUN < /dev/zero ssh-keygen -q -N '' && cat ${DOCKER_DIR}.ssh/id_rsa.pub >> ${DOCKER_DIR}.ssh/authorized_keys && cat ${DOCKER_DIR}.ssh/id_rsa > ${DOCKER_DIR}.ssh/known_keys && chmod 600 ${DOCKER_DIR}.ssh/*_keys

WORKDIR ${DOCKER_DIR}

# Start Scripts config
RUN mkdir -p logs/airflow logs/airflow/dag_processor_manager logs/airflow/webserver logs/airflow/scheduler logs/airflow/triggerer logs/airflow/flower /run/airflow

RUN git clone $GIT_CONFIG_ADDRESS
RUN rsync -avru $GIT_DIR/s_scripts/ s_scripts
RUN git clone $GIT_AIRFLOW_ADDRESS

RUN useradd -m -d /root/airflow airflow
RUN echo airflow:airflow | chpasswd
RUN usermod -aG sudo airflow

# Bashrc entries
RUN echo "export DOCKER_DATANODE_DIR=$DOCKER_DATANODE_DIR" >> .bashrc
RUN echo "afl () { \nairflow \$@ -l=/root/logs/airflow/\$@/\$@.log --stderr=/root/logs/airflow/\$@/\$@.err --stdout=/root/logs/airflow/\$@/\$@.out --pid=/run/airflow/airflow-\$@.pid -D \n\
}" >> .bashrc
RUN echo "aflc () { \nairflow celery \$@ -l=/root/logs/airflow/\$@/\$@.log --stderr=/root/logs/airflow/\$@/\$@.err --stdout=/root/logs/airflow/\$@/\$@.out --pid=/run/airflow/airflow-\$@.pid -D \n\
}" >> .bashrc
RUN echo "########Airflow Exports########" >> .bashrc
RUN echo "export AIRFLOW_HOME=/root/airflow/" >> .bashrc
RUN echo "" >> .bashrc


CMD ["/root/s_scripts/air-flow.sh"]