FROM registry.bdc.home:5000/hdc

WORKDIR $DOCKER_DIR

RUN git clone $GIT_CONFIG_ADDRESS
RUN rsync -avru $GIT_CONFIG_DIR/s_scripts/ s_scripts

# Start Scripts config
RUN mkdir -p logs/airflow/dag_processor_manager logs/airflow/webserver logs/airflow/scheduler logs/airflow/triggerer logs/airflow/flower /run/airflow

RUN useradd -m -d /root/airflow airflow
RUN echo airflow:airflow | chpasswd
RUN usermod -aG sudo airflow

CMD ["/root/s_scripts/air-flow.sh"]