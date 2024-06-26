ARG OS_VER

FROM rockylinux:${OS_VER}

ARG JAVA_VER
ARG PY_VER
ARG DOCKER_USR
ARG DOCKER_DIR
ARG DOCKER_PASS
ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS
ARG HDC_VERSION
ARG ICEBERG_VER
ARG ICEBERG_SPARK_VER
ARG NESSIE_VER
ARG SPARK_VERSION
ARG SPARK_HDC_VERSION
ARG NESSIE_SPARK_VER
ARG SPARK_KAFKA_VERSION


# Java, Python & Other Dependencie
RUN yum install java-${JAVA_VER}-openjdk java-${JAVA_VER}-openjdk-devel -y
RUN yum install net-tools iputils wget gcc git rsync openssh-server openssh openssh-clients which procps -y
RUN yum install openssl-devel bzip2-devel libffi-devel zlib-devel sqlite-devel  -y

RUN cd /usr/src \
    && wget https://www.python.org/ftp/python/${PY_VER}/Python-${PY_VER}.tgz \
    && tar -xzf Python-${PY_VER}.tgz \
    && cd Python-${PY_VER} \
    && ./configure --enable-optimizations \
    && make install

# Pip & other Python library installation
#RUN yum install pip -y
RUN pip3 install --upgrade pip
RUN pip3 install numpy pandas matplotlib seaborn statsmodels scikit-learn 
RUN pip3 install -U pip setuptools

# SSH configuration
RUN echo $DOCKER_PASS | passwd $DOCKER_USR --stdin
RUN < /dev/zero ssh-keygen -q -N '' && cat ${DOCKER_DIR}.ssh/id_rsa.pub >> ${DOCKER_DIR}.ssh/authorized_keys && cat ${DOCKER_DIR}.ssh/id_rsa > ${DOCKER_DIR}.ssh/known_keys && chmod 600 ${DOCKER_DIR}.ssh/*_keys

WORKDIR ${DOCKER_DIR}

# Start Scripts config
RUN mkdir s_scripts

# Downloading Hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-$HDC_VERSION/hadoop-$HDC_VERSION.tar.gz
RUN tar -zxf hadoop-$HDC_VERSION.tar.gz && rm hadoop-$HDC_VERSION.tar.gz
RUN mv hadoop-$HDC_VERSION hadoop

# Downloading Spark
RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION}.tgz
RUN tar -zxf spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION}.tgz && rm spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION}.tgz
RUN mv spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION} spark
RUN wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-${ICEBERG_SPARK_VER}/${ICEBERG_VER}/iceberg-spark-runtime-${ICEBERG_SPARK_VER}-${ICEBERG_VER}.jar -P spark/jars/
RUN wget https://repo.maven.apache.org/maven2/org/projectnessie/nessie-integrations/nessie-spark-extensions-${NESSIE_SPARK_VER}/${NESSIE_VER}/nessie-spark-extensions-${NESSIE_SPARK_VER}-${NESSIE_VER}.jar -P spark/jars/
RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-sql-kafka-0-10_${SPARK_KAFKA_VERSION}/${SPARK_VERSION}/spark-sql-kafka-0-10_${SPARK_KAFKA_VERSION}-${SPARK_VERSION}.jar -P spark/jars/
RUN wget https://repo1.maven.org/maven2/org/apache/commons/commons-pool2/2.12.0/commons-pool2-2.12.0.jar -P spark/jars/
RUN wget https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/3.6.2/kafka-clients-3.6.2.jar -P spark/jars/
RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-token-provider-kafka-0-10_${SPARK_KAFKA_VERSION}/${SPARK_VERSION}/spark-token-provider-kafka-0-10_${SPARK_KAFKA_VERSION}-${SPARK_VERSION}.jar -P spark/jars/

# Bashrc entries
RUN echo "" >> .bashrc
RUN echo "########JAVA Export########" >> .bashrc
RUN echo "export JAVA_HOME=/usr/lib/jvm/jre/" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "########HADOOP Exports########" >> .bashrc
RUN echo "export HADOOP_HOME=${DOCKER_DIR}hadoop" >> .bashrc
RUN echo "export HADOOP_INSTALL=\$HADOOP_HOME" >> .bashrc
RUN echo "export HADOOP_MAPRED_HOME=\$HADOOP_HOME" >> .bashrc
RUN echo "export HADOOP_COMMON_HOME=\$HADOOP_HOME" >> .bashrc
RUN echo "export HADOOP_HDFS_HOME=\$HADOOP_HOME" >> .bashrc
RUN echo "export HADOOP_YARN_HOME=\$HADOOP_HOME" >> .bashrc
RUN echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> .bashrc
RUN echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native/" >> .bashrc 
RUN echo 'export HADOOP_OPTS="-Djava.library.path=\$HADOOP_COMMON_LIB_NATIVE_DIR"' >> .bashrc
RUN echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >> .bashrc
RUN echo "export HDFS_NAMENODE_USER='root'" >> .bashrc
RUN echo "export HDFS_DATANODE_USER='root'" >> .bashrc
RUN echo "export HDFS_SECONDARYNAMENODE_USER='root'" >> .bashrc
RUN echo "export YARN_RESOURCEMANAGER_USER='root'" >> .bashrc
RUN echo "export YARN_NODEMANAGER_USER='root'" >> .bashrc
RUN echo "export YARN_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> .bashrc
RUN echo "export DOCKER_DIR=$DOCKER_DIR" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "########SPARK Exports########" >> .bashrc
RUN echo "export SPARK_HOME=${DOCKER_DIR}spark" >> .bashrc
RUN echo "export PATH=\$PATH:\$JAVA_HOME/bin:\$SPARK_HOME/bin:\$SPARK_HOME/sbin:/usr/sbin/:\$SPARK_HOME/yarn" >> .bashrc
RUN echo "export LD_LIBRARY_PATH=/opt/hadoop/lib/native:\$LD_LIBRARY_PATH" >> .bashrc
RUN echo -e "ssql () { \nspark-sql --packages org.apache.iceberg:iceberg-spark-runtime-${ICEBERG_SPARK_VER}:${ICEBERG_VER},org.projectnessie:nessie-spark-extensions-${NESSIE_SPARK_VER}:${NESSIE_VER} \\\n\
--conf spark.sql.extensions='org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions' \\\n\
--conf spark.sql.catalog.nessie.uri='http://nessie.bdc.home:19120/api/v1' --conf spark.sql.catalog.nessie.ref=main  --conf spark.sql.catalog.nessie.authentication.type=NONE \\\n\
--conf spark.sql.catalog.nessie.catalog-impl=org.apache.iceberg.nessie.NessieCatalog --conf spark.sql.catalog.nessie=org.apache.iceberg.spark.SparkCatalog \\\n\
--conf spark.sql.catalog.nessie.warehouse=hdfs://name-res.bdc.home:9000/user/root/nessie/warehouse \$@ \n}" >> .bashrc

# Updating configuration files
RUN echo "export JAVA_HOME=/usr/lib/jvm/jre/" >> hadoop/etc/hadoop/hadoop-env.sh
RUN mv spark/conf/spark-defaults.conf.template spark/conf/spark-defaults.conf
RUN mv spark/conf/spark-env.sh.template spark/conf/spark-env.sh
RUN echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> spark/conf/spark-env.sh
RUN git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru $GIT_DIR/hadoop/ hadoop
RUN rsync -avru $GIT_DIR/spark/ spark
RUN rm -rf $GIT_DIR

EXPOSE 22