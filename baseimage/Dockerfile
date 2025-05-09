ARG PY_VER

FROM python:${PY_VER}

ARG JAVA_VER
ARG DOCKER_USR
ARG DOCKER_DIR
ARG DOCKER_PASS
ARG AIRFLOW_VER
ARG SPARK_VERSION

# Java installation
RUN apk update && apk add openjdk11

# OS required package installation
RUN apk add --no-cache net-tools wget gcc g++ git openrc openssh which procps cifs-utils libpq-dev sqlite-dev openssl-dev bzip2-dev libffi-dev zlib-dev re2-dev python3-dev musl-dev linux-headers
RUN rc-update add sshd default

# SSH configuration
RUN echo ${DOCKER_USR}:${DOCKER_PASS} | chpasswd
RUN < /dev/zero ssh-keygen -q -N ''
RUN export ssh_fl=`cd /root/.ssh && ls *.pub | cut -d'.' -f1` && cat ${DOCKER_DIR}.ssh/${ssh_fl} > ${DOCKER_DIR}.ssh/known_keys
RUN cat ${DOCKER_DIR}.ssh/*.pub >> ${DOCKER_DIR}.ssh/authorized_keys
RUN chmod 600 ${DOCKER_DIR}.ssh/*_keys
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Pip & other Python library installation
RUN pip3 install --upgrade pip
RUN pip3 install pyspark==${SPARK_VERSION}
RUN pip3 install pynessie
RUN pip3 install importlib-metadata
RUN pip3 install pybind11[global]
RUN pip3 install apache-airflow==${AIRFLOW_VER}
RUN pip3 install apache-airflow[celery]==${AIRFLOW_VER}
RUN pip3 install apache-airflow[rabbitmq]==${AIRFLOW_VER}
RUN pip3 install apache-airflow-providers-apache-spark
RUN pip3 install psycopg2
RUN nessie remote add http://nessie.bdc.home:19120/api/v2

WORKDIR ${DOCKER_DIR}

# Start Scripts config
RUN mkdir -p s_scripts airflow hadoop spark logs/hadoop logs/spark logs/airflow

# Bashrc entries
RUN echo "" >> .profile
RUN echo "########Airflow Exports########" >> .profile
RUN echo "export AIRFLOW_HOME=/root/airflow/" >> .profile
RUN echo "" >> .profile
RUN echo "########JAVA Export########" >> .profile
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk" >> .profile
RUN echo "" >> .profile
RUN echo "########HADOOP Exports########" >> .profile
RUN echo "export HADOOP_HOME=${DOCKER_DIR}hadoop" >> .profile
RUN echo "export HADOOP_INSTALL=\$HADOOP_HOME" >> .profile
RUN echo "export HADOOP_MAPRED_HOME=\$HADOOP_HOME" >> .profile
RUN echo "export HADOOP_COMMON_HOME=\$HADOOP_HOME" >> .profile
RUN echo "export HADOOP_HDFS_HOME=\$HADOOP_HOME" >> .profile
RUN echo "export HADOOP_YARN_HOME=\$HADOOP_HOME" >> .profile
RUN echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> .profile
RUN echo "export HADOOP_LOG_DIR=${DOCKER_DIR}logs/hadoop" >> .profile
RUN echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native/" >> .profile 
RUN echo 'export HADOOP_OPTS="-Djava.library.path=\$HADOOP_COMMON_LIB_NATIVE_DIR"' >> .profile
RUN echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >> .profile
RUN echo "export HDFS_NAMENODE_USER='root'" >> .profile
RUN echo "export HDFS_DATANODE_USER='root'" >> .profile
RUN echo "export HDFS_SECONDARYNAMENODE_USER='root'" >> .profile
RUN echo "export YARN_RESOURCEMANAGER_USER='root'" >> .profile
RUN echo "export YARN_NODEMANAGER_USER='root'" >> .profile
#RUN echo "export YARN_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> .profile
RUN echo "export DOCKER_DIR=${DOCKER_DIR}" >> .profile
RUN echo "" >> .profile
RUN echo "########SPARK Exports########" >> .profile
RUN echo "export SPARK_HOME=${DOCKER_DIR}spark" >> .profile
RUN echo "export PATH=\$PATH:\$JAVA_HOME/bin:\$SPARK_HOME/bin:\$SPARK_HOME/sbin:/usr/sbin:\$SPARK_HOME/yarn" >> .profile
RUN echo "export LD_LIBRARY_PATH=/opt/hadoop/lib/native:\$LD_LIBRARY_PATH" >> .profile
RUN echo "" >> .profile
RUN echo "afl () { \nairflow \$@ -l=/root/logs/airflow/\$@.log --stderr=/root/logs/airflow/\$@.err --stdout=/root/logs/airflow/\$@.out --pid=/run/airflow/\$@.pid -D \n\
}" >> .profile
RUN echo "aflc () { \nairflow celery \$@ -l=/root/logs/airflow/\$@.log --stderr=/root/logs/airflow/\$@.err --stdout=/root/logs/airflow/\$@.out --pid=/run/airflow/\$@.pid -D \n\
}" >> .profile


EXPOSE 22