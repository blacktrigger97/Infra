FROM hdc

ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS
ARG DOCKER_DIR
ARG DOCKER_NAMENODE_DIR
ARG LOCAL_NAMENODE_DIR

WORKDIR $DOCKER_DIR

#RUN echo "export DOCKER_DIR=$DOCKER_DIR" >> .bashrc
RUN echo "export LOCAL_NAMENODE_DIR=$LOCAL_NAMENODE_DIR" >> .bashrc
RUN echo "afl () { \nairflow \$@ -l=/root/logs/airflow/\$@/\$@.log --stderr=/root/logs/airflow/\$@/\$@.err --stdout=/root/logs/airflow/\$@/\$@.out -D \n\
}" >> .bashrc
RUN echo "aflc () { \nairflow celery \$@ -l=/root/logs/airflow/\$@/\$@.log --stderr=/root/logs/airflow/\$@/\$@.err --stdout=/root/logs/airflow/\$@/\$@.out -D \n\
}" >> .bashrc

RUN git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru $GIT_DIR/s_scripts/ s_scripts

RUN mkdir $DOCKER_NAMENODE_DIR docker_$DOCKER_NAMENODE_DIR logs/airflow/dag_processor_manager logs/airflow/webserver logs/airflow/scheduler logs/airflow/triggerer logs/airflow/flower
RUN chown root:root -R $DOCKER_NAMENODE_DIR
RUN chown root:root -R docker_$DOCKER_NAMENODE_DIR
RUN chmod 777 -R $DOCKER_NAMENODE_DIR
RUN chmod 777 -R docker_$DOCKER_NAMENODE_DIR

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

RUN useradd -m -d /root/airflow airflow
RUN echo airflow:airflow | chpasswd
RUN usermod -aG sudo airflow
RUN mkdir -p airflow airflow/dags airflow/plugins /run/airflow 

CMD ["/root/s_scripts/name-res.sh"]