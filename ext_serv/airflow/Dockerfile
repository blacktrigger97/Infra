FROM registry.bdc.home:5000/hdc

# Start Scripts config
RUN mkdir -p logs/airflow/dag_processor_manager logs/airflow/webserver logs/airflow/scheduler logs/airflow/triggerer logs/airflow/flower /run/airflow

RUN useradd -m -d /root/airflow airflow
RUN echo airflow:airflow | chpasswd
RUN usermod -aG sudo airflow

CMD ["/root/s_scripts/air-flow.sh"]