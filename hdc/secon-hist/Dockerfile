FROM hdc_baseimage

ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS
ARG DOCKER_DIR
ARG DOCKER_SECONDARY_NAMENODE_DIR


RUN echo "export DOCKER_SECONDARY_NAMENODE_DIR=$DOCKER_SECONDARY_NAMENODE_DIR" >> ${DOCKER_DIR}.bashrc

RUN cd $DOCKER_DIR && git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/s_scripts/ ${DOCKER_DIR}s_scripts
RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/hadoop/ ${DOCKER_DIR}hadoop
RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/hive/ ${DOCKER_DIR}hive
RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/spark/ ${DOCKER_DIR}spark

RUN mkdir -p $DOCKER_DIR$DOCKER_SECONDARY_NAMENODE_DIR
RUN chown root:root -R ${DOCKER_DIR}$DOCKER_SECONDARY_NAMENODE_DIR
RUN chmod 777 -R ${DOCKER_DIR}$DOCKER_SECONDARY_NAMENODE_DIR

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

CMD ["/root/s_scripts/secon-hist.sh"]