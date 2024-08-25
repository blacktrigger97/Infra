FROM hdc

ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS
ARG DOCKER_DIR
ARG DOCKER_DATANODE_DIR

WORKDIR $DOCKER_DIR

#RUN echo "export DOCKER_DIR=$DOCKER_DIR" >> .bashrc
RUN echo "export DOCKER_DATANODE_DIR=$DOCKER_DATANODE_DIR" >> .bashrc
RUN echo "afl () { \nairflow \$@ -l=/root/logs/airflow/\$@/\$@.log --stderr=/root/logs/airflow/\$@/\$@.err --stdout /root/logs/airflow/\$@/\$@.out -D \n\
}" >> .bashrc

RUN git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru $GIT_DIR/s_scripts/ s_scripts
# RUN rsync -avru $GIT_DIR/hadoop/ hadoop
# RUN rsync -avru $GIT_DIR/spark/ spark

RUN mkdir -p $DOCKER_DATANODE_DIR
RUN chown root:root -R $DOCKER_DATANODE_DIR
RUN chmod 777 -R $DOCKER_DATANODE_DIR

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

CMD ["/root/s_scripts/data-node.sh"]