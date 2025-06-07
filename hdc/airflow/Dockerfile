FROM registry.bdc.home:5000/hdc

ARG GIT_CONFIG_DIR
ARG AIRFLOW_DIR
ARG GIT_CONFIG_ADDRESS
ARG GIT_AIRFLOW_ADDRESS
ARG DOCKER_DIR

WORKDIR $DOCKER_DIR

RUN git clone $GIT_CONFIG_ADDRESS
# RUN git clone $GIT_AIRFLOW_ADDRESS
RUN rsync -avru $GIT_CONFIG_DIR/s_scripts/ s_scripts
# RUN rsync -avru $AIRFLOW_DIR/ airflow

# Start Scripts config
RUN mkdir -p airflow /run/airflow logs/airflow/worker

RUN useradd -m -d /root/airflow airflow
RUN echo airflow:airflow | chpasswd
RUN usermod -aG sudo airflow

ENTRYPOINT ["/root/s_scripts/air-flow.sh"]