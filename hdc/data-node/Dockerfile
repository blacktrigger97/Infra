FROM hdc

ARG GIT_CONFIG_DIR
ARG GIT_CONFIG_ADDRESS
ARG DOCKER_DIR
ARG DOCKER_DATANODE_DIR
ARG GIT_AIRFLOW_ADDRESS

WORKDIR $DOCKER_DIR

RUN echo "export DOCKER_DATANODE_DIR=$DOCKER_DATANODE_DIR" >> .bashrc

RUN mkdir -p $DOCKER_DATANODE_DIR logs/airflow/worker /run/airflow 
RUN chown root:root -R $DOCKER_DATANODE_DIR
RUN chmod 777 -R $DOCKER_DATANODE_DIR

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

RUN useradd -m -d /root/airflow airflow
RUN echo airflow:airflow | chpasswd
RUN usermod -aG sudo airflow 

CMD ["/root/s_scripts/data-node.sh"]