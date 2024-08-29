FROM hdc

ARG GIT_DIR
ARG GIT_CONFIG_ADDRESS
ARG DOCKER_DIR
ARG DOCKER_SECONDARY_NAMENODE_DIR

#RUN yum install postgresql -y
WORKDIR $DOCKER_DIR

#RUN echo "export DOCKER_DIR=$DOCKER_DIR" >> .bashrc
RUN echo "export DOCKER_SECONDARY_NAMENODE_DIR=$DOCKER_SECONDARY_NAMENODE_DIR" >> .bashrc

RUN git clone $GIT_CONFIG_ADDRESS
RUN rsync -avru $GIT_DIR/s_scripts/ s_scripts
# RUN rsync -avru $GIT_DIR/hadoop/ hadoop
# RUN rsync -avru $GIT_DIR/spark/ spark

RUN mkdir -p $DOCKER_SECONDARY_NAMENODE_DIR
RUN chown root:root -R $DOCKER_SECONDARY_NAMENODE_DIR
RUN chmod 777 -R $DOCKER_SECONDARY_NAMENODE_DIR

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

CMD ["/root/s_scripts/secon-hist.sh"]