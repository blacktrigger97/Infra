FROM registry.bdc.home:5000/hdc

ARG GIT_CONFIG_DIR
ARG AIRFLOW_DIR
ARG GIT_CONFIG_ADDRESS
ARG GIT_AIRFLOW_ADDRESS
ARG DOCKER_DIR

RUN pip3 install pandas Flask-AppBuilder

WORKDIR $DOCKER_DIR

RUN git clone $GIT_CONFIG_ADDRESS
# RUN git clone $GIT_AIRFLOW_ADDRESS
RUN rsync -avru $GIT_CONFIG_DIR/s_scripts/ s_scripts
# RUN rsync -avru $AIRFLOW_DIR/ airflow

# Start Scripts config
RUN mkdir -p airflow logs/airflow/dag_processor logs/airflow/api-server logs/airflow/scheduler logs/airflow/triggerer logs/airflow/flower /run/airflow

RUN useradd -m -d /root/airflow airflow
RUN echo airflow:airflow | chpasswd
RUN usermod -aG sudo airflow

ENTRYPOINT ["/root/s_scripts/air-flow.sh"]