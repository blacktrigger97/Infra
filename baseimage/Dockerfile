ARG PY_VER

FROM python:${PY_VER}

ARG JAVA_VER
ARG DOCKER_USR
ARG DOCKER_DIR
ARG DOCKER_PASS
ARG AIRFLOW_VER


# Java installation
RUN apt update && apt upgrade -y && apt install -y gnupg ca-certificates curl rsync
RUN curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list
RUN apt-get update && apt-get -y install zulu11-jdk
RUN apt-get -y autoremove && apt-get -y clean

# OS required package installation
RUN apt-get -y install make net-tools wget gcc git openssh-server which procps libpq-dev libsqlite3-dev libssl-dev libbz2-dev libffi-dev zlib1g-dev
RUN systemctl enable ssh

# Pip & other Python library installation
RUN pip3 install --upgrade pip
RUN pip3 install pynessie
RUN pip3 install importlib-metadata
RUN pip3 install apache-airflow==${AIRFLOW_VER}
RUN pip3 install apache-airflow[celery]==${AIRFLOW_VER}
RUN pip3 install apache-airflow[rabbitmq]==${AIRFLOW_VER}
RUN pip3 install psycopg2
RUN nessie remote add http://nessie.bdc.home:19120/api/v1

# SSH configuration
RUN echo ${DOCKER_USR}:${DOCKER_PASS} | chpasswd
RUN < /dev/zero ssh-keygen -q -N '' && cat ${DOCKER_DIR}.ssh/id_rsa.pub >> ${DOCKER_DIR}.ssh/authorized_keys && cat ${DOCKER_DIR}.ssh/id_rsa > ${DOCKER_DIR}.ssh/known_keys && chmod 600 ${DOCKER_DIR}.ssh/*_keys

WORKDIR ${DOCKER_DIR}

# Start Scripts config
RUN mkdir -p hadoop spark aiflow/dags airflow/plugins logs/hadoop logs/spark logs/airflow logs/airflow/scheduler logs/airflow/webserver /run/airflow

# Downloading Hadoop
# RUN wget https://downloads.apache.org/hadoop/common/hadoop-$HDC_VERSION/hadoop-$HDC_VERSION.tar.gz
# RUN tar -zxf hadoop-$HDC_VERSION.tar.gz && rm hadoop-$HDC_VERSION.tar.gz
# RUN mv hadoop-$HDC_VERSION hadoop

# Bashrc entries
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
RUN echo "export YARN_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> .bashrc
RUN echo "export DOCKER_DIR=${DOCKER_DIR}" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "########SPARK Exports########" >> .bashrc
RUN echo "export SPARK_HOME=${DOCKER_DIR}spark" >> .bashrc
RUN echo "export PATH=\$PATH:\$JAVA_HOME/bin:\$SPARK_HOME/bin:\$SPARK_HOME/sbin:/usr/sbin:\$SPARK_HOME/yarn" >> .bashrc
RUN echo "export LD_LIBRARY_PATH=/opt/hadoop/lib/native:\$LD_LIBRARY_PATH" >> .bashrc
# RUN echo -e "ssql () { \nspark-sql --packages org.apache.iceberg:iceberg-spark-runtime-${ICEBERG_SPARK_VER}:${ICEBERG_VER},org.projectnessie:nessie-spark-extensions-${NESSIE_SPARK_VER}:${NESSIE_VER} \\\n\
# --conf spark.sql.extensions='org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions' \\\n\
# --conf spark.sql.catalog.nessie.uri='http://nessie.bdc.home:19120/api/v1' --conf spark.sql.catalog.nessie.ref=main  --conf spark.sql.catalog.nessie.authentication.type=NONE \\\n\
# --conf spark.sql.catalog.nessie.catalog-impl=org.apache.iceberg.nessie.NessieCatalog --conf spark.sql.catalog.nessie=org.apache.iceberg.spark.SparkCatalog \\\n\
# --conf spark.sql.catalog.nessie.warehouse=hdfs://name-res.bdc.home:9000/user/root/nessie/warehouse \$@ \n}" >> .bashrc

# Updating configuration files
# RUN echo "export JAVA_HOME=/usr/lib/jvm/jre/" >> hadoop/etc/hadoop/hadoop-env.sh
# RUN git clone $GIT_REMOTE_ADDRESS
# RUN rsync -avru $GIT_DIR/hadoop/ hadoop
# RUN rm -rf $GIT_DIR

EXPOSE 22