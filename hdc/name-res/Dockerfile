FROM nrsh

ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS
ARG DOCKER_DIR
ARG DOCKER_NAMENODE_DIR

WORKDIR $DOCKER_DIR

RUN git clone $GIT_REMOTE_ADDRESS

RUN rsync -avru $GIT_DIR/s_scripts/ s_scripts
RUN rsync -avru $GIT_DIR/hadoop/ hadoop
RUN rsync -avru $GIT_DIR/spark/ spark

RUN mkdir -p {$DOCKER_NAMENODE_DIR,docker_$DOCKER_NAMENODE_DIR}
RUN chown root:root -R $DOCKER_NAMENODE_DIR
RUN chown root:root -R docker_$DOCKER_NAMENODE_DIR
RUN chmod 777 -R $DOCKER_NAMENODE_DIR
RUN chmod 777 -R docker_$DOCKER_NAMENODE_DIR

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

CMD ["/root/s_scripts/name-res.sh"]