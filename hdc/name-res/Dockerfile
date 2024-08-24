FROM hdc

ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS
ARG DOCKER_DIR
ARG DOCKER_NAMENODE_DIR
ARG LOCAL_NAMENODE_DIR

WORKDIR $DOCKER_DIR

#RUN echo "export DOCKER_DIR=$DOCKER_DIR" >> .bashrc
RUN echo "export LOCAL_NAMENODE_DIR=$LOCAL_NAMENODE_DIR" >> .bashrc

RUN git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru $GIT_DIR/s_scripts/ s_scripts
RUN rsync -avru $GIT_DIR/airflow/ airflow
# RUN rsync -avru $GIT_DIR/spark/ spark

RUN mkdir $DOCKER_NAMENODE_DIR docker_$DOCKER_NAMENODE_DIR
RUN chown root:root -R $DOCKER_NAMENODE_DIR
RUN chown root:root -R docker_$DOCKER_NAMENODE_DIR
RUN chmod 777 -R $DOCKER_NAMENODE_DIR
RUN chmod 777 -R docker_$DOCKER_NAMENODE_DIR

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

CMD ["/root/s_scripts/name-res.sh"]