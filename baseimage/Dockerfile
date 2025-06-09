ARG PY_VER

FROM python:${PY_VER}

ARG JAVA_VER
ARG DOCKER_USR
ARG DOCKER_DIR
ARG DOCKER_PASS
ARG AIRFLOW_VER
# ARG AIRFLOW_CLIENT_VER
ARG SPARK_VERSION

# Java installation
RUN apt update && apt upgrade -y && apt install -y gnupg ca-certificates curl rsync
RUN curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list
RUN apt-get update && apt-get -y install zulu11-jdk
RUN apt-get -y autoremove && apt-get -y clean

# OS required package installation
RUN apt-get -y install make net-tools wget gcc git openssh-server which procps libpq-dev libsqlite3-dev libssl-dev libbz2-dev libffi-dev zlib1g-dev
RUN systemctl enable ssh

# Pip & Arflow library installation
RUN pip install --upgrade pip
RUN pip3 install pynessie 
# RUN pip3 install pyspark==${SPARK_VERSION}
# RUN pip3 install pandas Flask-AppBuilder
# RUN pip3 install apache-airflow[redis,celery,postgres,client]==${AIRFLOW_VER}
# RUN pip3 install apache-airflow-providers-apache-spark
# RUN pip3 install apache-airflow-providers-apache-hdfs
# RUN pip3 install apache-airflow-providers-apache-kafka
# RUN pip3 install apache-airflow-providers-git
# RUN pip3 install apache-airflow-providers-http
# RUN pip3 install apache-airflow-providers-jdbc
# RUN pip3 install apache-airflow-providers-trino
# RUN pip3 install psycopg2-binary
RUN nessie remote add http://nessie.bdc.home:19120/api/v2

# SSH configuration
RUN echo ${DOCKER_USR}:${DOCKER_PASS} | chpasswd
RUN < /dev/zero ssh-keygen -q -N '' && cat ${DOCKER_DIR}.ssh/id_rsa.pub >> ${DOCKER_DIR}.ssh/authorized_keys && cat ${DOCKER_DIR}.ssh/id_rsa > ${DOCKER_DIR}.ssh/known_keys && chmod 600 ${DOCKER_DIR}.ssh/*_keys

WORKDIR ${DOCKER_DIR}

# Start Scripts config
RUN mkdir -p s_scripts hadoop spark logs/hadoop logs/spark

# Bashrc entries
RUN echo "" >> .bashrc
RUN echo "########Airflow Exports########" >> .bashrc
RUN echo "export AIRFLOW_HOME=/root/airflow/" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "########JAVA Export########" >> .bashrc
RUN echo "export JAVA_HOME=/usr/lib/jvm/zulu11/" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "########HADOOP Exports########" >> .bashrc
RUN echo "export HADOOP_HOME=${DOCKER_DIR}hadoop" >> .bashrc
RUN echo "export HADOOP_INSTALL=\$HADOOP_HOME" >> .bashrc
RUN echo "export HADOOP_MAPRED_HOME=\$HADOOP_HOME" >> .bashrc
RUN echo "export HADOOP_COMMON_HOME=\$HADOOP_HOME" >> .bashrc
RUN echo "export HADOOP_HDFS_HOME=\$HADOOP_HOME" >> .bashrc
RUN echo "export HADOOP_YARN_HOME=\$HADOOP_HOME" >> .bashrc
RUN echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> .bashrc
RUN echo "export HADOOP_LOG_DIR=${DOCKER_DIR}logs/hadoop" >> .bashrc
RUN echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native/" >> .bashrc 
RUN echo 'export HADOOP_OPTS="-Djava.library.path=\$HADOOP_COMMON_LIB_NATIVE_DIR"' >> .bashrc
RUN echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >> .bashrc
RUN echo "export HDFS_NAMENODE_USER='root'" >> .bashrc
RUN echo "export HDFS_DATANODE_USER='root'" >> .bashrc
RUN echo "export HDFS_SECONDARYNAMENODE_USER='root'" >> .bashrc
RUN echo "export YARN_RESOURCEMANAGER_USER='root'" >> .bashrc
RUN echo "export YARN_NODEMANAGER_USER='root'" >> .bashrc
#RUN echo "export YARN_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> .bashrc
RUN echo "export DOCKER_DIR=${DOCKER_DIR}" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "########SPARK Exports########" >> .bashrc
RUN echo "export SPARK_HOME=${DOCKER_DIR}spark" >> .bashrc
RUN echo "export SPARK_LOG_DIR='/root/logs/spark'" >> .bashrc
RUN echo "export PATH=\$PATH:\$JAVA_HOME/bin:\$SPARK_HOME/bin:\$SPARK_HOME/sbin:/usr/sbin:\$SPARK_HOME/yarn" >> .bashrc
RUN echo "export LD_LIBRARY_PATH=\$HADOOP_HOME/lib/native:\$LD_LIBRARY_PATH" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "afl () { \nairflow \$@ -l=/root/logs/airflow/\$@.log --stderr=/root/logs/airflow/\$@.err --stdout=/root/logs/airflow/\$@.out --pid=/run/airflow/\$@.pid -D \n}" >> .bashrc
RUN echo "aflc () { \nairflow celery \$@ -l=/root/logs/airflow/\$@.log --stderr=/root/logs/airflow/\$@.err --stdout=/root/logs/airflow/\$@.out --pid=/run/airflow/\$@.pid -D \n}" >> .bashrc


EXPOSE 22