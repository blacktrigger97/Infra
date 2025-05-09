FROM hdc

ARG GIT_CONFIG_DIR
ARG GIT_CONFIG_ADDRESS
ARG DOCKER_DIR
ARG DOCKER_DATANODE_DIR

WORKDIR $DOCKER_DIR

RUN echo "export DOCKER_DATANODE_DIR=$DOCKER_DATANODE_DIR" >> .bashrc

RUN git clone $GIT_CONFIG_ADDRESS
RUN rsync -avru $GIT_CONFIG_DIR/s_scripts/ s_scripts

RUN mkdir -p $DOCKER_DATANODE_DIR logs/airflow/worker /run/airflow 
RUN chown root:root -R $DOCKER_DATANODE_DIR
RUN chmod 777 -R $DOCKER_DATANODE_DIR

CMD ["/root/s_scripts/data-node.sh"]