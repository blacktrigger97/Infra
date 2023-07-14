FROM baseimage

ARG DOCKER_USR
ARG DOCKER_DIR
ARG DOCKER_PASS
ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS
ARG HDC_VERSION
ARG HIVE_VERSION
ARG MYSQL_VER
ARG MYSQL_CONN_VER
ARG SPARK_VERSION
ARG SPARK_HDC_VERSION

#Install MariaDB client
RUN yum install mysql which procps -y

# SSH configuration
RUN echo $DOCKER_PASS | passwd $DOCKER_USR --stdin
RUN < /dev/zero ssh-keygen -q -N '' && cat ${DOCKER_DIR}.ssh/id_rsa.pub >> ${DOCKER_DIR}.ssh/authorized_keys && cat ${DOCKER_DIR}.ssh/id_rsa > ${DOCKER_DIR}.ssh/known_keys && chmod 600 ${DOCKER_DIR}.ssh/*_keys

# Host & Start Scripts config
RUN mkdir -p ${DOCKER_DIR}{hosts,s_scripts}

# Downloading Hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-$HDC_VERSION/hadoop-$HDC_VERSION.tar.gz -P ${DOCKER_DIR}
RUN cd ${DOCKER_DIR} && tar -zxf hadoop-$HDC_VERSION.tar.gz
RUN mv ${DOCKER_DIR}hadoop-$HDC_VERSION ${DOCKER_DIR}hadoop

# Downloading Hive
RUN wget https://dlcdn.apache.org/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz -P ${DOCKER_DIR}
RUN cd ${DOCKER_DIR} && tar -zxf apache-hive-$HIVE_VERSION-bin.tar.gz
RUN mv ${DOCKER_DIR}apache-hive-$HIVE_VERSION-bin ${DOCKER_DIR}hive
RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONN_VER}/mysql-connector-java-${MYSQL_CONN_VER}.jar -P ${DOCKER_DIR}hive/lib/

# Downloading Spark
RUN wget https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION}.tgz -P ${DOCKER_DIR}
RUN cd ${DOCKER_DIR} && tar -zxf spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION}.tgz
RUN mv ${DOCKER_DIR}spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION} ${DOCKER_DIR}spark
RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONN_VER}/mysql-connector-java-${MYSQL_CONN_VER}.jar -P ${DOCKER_DIR}spark/lib/

# Hive & Hadoop configuration
#RUN rm ${DOCKER_DIR}hive/lib/guava-*
#RUN cp -rf ${DOCKER_DIR}hadoop/share/hadoop/common/lib/guava-* ${DOCKER_DIR}hive/lib/


RUN echo "########JAVA Export########" >> ${DOCKER_DIR}.bashrc
RUN echo "export JAVA_HOME=/usr/lib/jvm/jre/" >> ${DOCKER_DIR}.bashrc
RUN echo "" >> ${DOCKER_DIR}.bashrc
RUN echo "########HADOOP Exports########" >> ${DOCKER_DIR}.bashrc
RUN echo "export HADOOP_HOME=${DOCKER_DIR}hadoop" >> ${DOCKER_DIR}.bashrc
RUN echo "export HADOOP_INSTALL=\$HADOOP_HOME" >> ${DOCKER_DIR}.bashrc
RUN echo "export HADOOP_MAPRED_HOME=\$HADOOP_HOME" >> ${DOCKER_DIR}.bashrc
RUN echo "export HADOOP_COMMON_HOME=\$HADOOP_HOME" >> ${DOCKER_DIR}.bashrc
RUN echo "export HADOOP_HDFS_HOME=\$HADOOP_HOME" >> ${DOCKER_DIR}.bashrc
RUN echo "export HADOOP_YARN_HOME=\$HADOOP_HOME" >> ${DOCKER_DIR}.bashrc
RUN echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> ${DOCKER_DIR}.bashrc
RUN echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native/" >> ${DOCKER_DIR}.bashrc 
RUN echo 'export HADOOP_OPTS="-Djava.library.path=\$HADOOP_COMMON_LIB_NATIVE_DIR"' >> ${DOCKER_DIR}.bashrc
RUN echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >> ${DOCKER_DIR}.bashrc
RUN echo "export HDFS_NAMENODE_USER='root'" >> ${DOCKER_DIR}.bashrc
RUN echo "export HDFS_DATANODE_USER='root'" >> ${DOCKER_DIR}.bashrc
RUN echo "export HDFS_SECONDARYNAMENODE_USER='root'" >> ${DOCKER_DIR}.bashrc
RUN echo "export YARN_RESOURCEMANAGER_USER='root'" >> ${DOCKER_DIR}.bashrc
RUN echo "export YARN_NODEMANAGER_USER='root'" >> ${DOCKER_DIR}.bashrc
RUN echo "export DOCKER_DIR=$DOCKER_DIR" >> ${DOCKER_DIR}.bashrc
RUN echo "" >> ${DOCKER_DIR}.bashrc
RUN echo "########HIVE Exports########" >> ${DOCKER_DIR}.bashrc
RUN echo "export HIVE_HOME=${DOCKER_DIR}hive" >> ${DOCKER_DIR}.bashrc
RUN echo "export HIVE_CONF_DIR=${DOCKER_DIR}hive/conf" >> ${DOCKER_DIR}.bashrc
RUN echo "export PATH=\$PATH:\$HIVE_HOME/bin:\$HIVE_CONF_DIR:\$SPARK_HOME/bin:\$SPARK_HOME/sbin" >> ${DOCKER_DIR}.bashrc
RUN echo "alias bhive='beeline -u jdbc:hive2://secon-hist:10000 --incremental=true'" >> ${DOCKER_DIR}.bashrc
RUN echo "" >> ${DOCKER_DIR}.bashrc
RUN echo "########SPARK Exports########" >> ${DOCKER_DIR}.bashrc
RUN echo "export SPARK_HOME=${DOCKER_DIR}spark" >> ${DOCKER_DIR}.bashrc
RUN echo "export PATH=\$PATH:\$HIVE_HOME/bin:\$HIVE_HOME/lib:\$HIVE_CONF_DIR:\$SPARK_HOME/bin:\$SPARK_HOME/sbin" >> ${DOCKER_DIR}.bashrc
RUN echo "export LD_LIBRARY_PATH=/opt/hadoop/lib/native:\$LD_LIBRARY_PATH" >> ${DOCKER_DIR}.bashrc

RUN echo "export JAVA_HOME=/usr/lib/jvm/jre/" >> ${DOCKER_DIR}hadoop/etc/hadoop/hadoop-env.sh
RUN mv ${DOCKER_DIR}hive/conf/hive-env.sh.template ${DOCKER_DIR}hive/conf/hive-env.sh
RUN mv ${DOCKER_DIR}hive/conf/hive-default.xml.template ${DOCKER_DIR}hive/conf/hive-site.xml
RUN echo "export HADOOP_HOME=${DOCKER_DIR}hadoop" >> ${DOCKER_DIR}hive/conf/hive-env.sh
RUN mv ${DOCKER_DIR}spark/conf/spark-defaults.conf.template ${DOCKER_DIR}spark/conf/spark-defaults.conf
#RUN mv ${DOCKER_DIR}spark/conf/spark-env.sh.template ${DOCKER_DIR}spark/conf/spark-env.sh
#RUN echo "export HADOOP_HOME=${DOCKER_DIR}hadoop" >> ${DOCKER_DIR}spark/conf/spark-env.sh
RUN cd $DOCKER_DIR && git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/hadoop/ ${DOCKER_DIR}hadoop
RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/hive/ ${DOCKER_DIR}hive
RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/spark/ ${DOCKER_DIR}spark
RUN ln -s ${DOCKER_DIR}hive/conf/hive-site.xml ${DOCKER_DIR}spark/conf/hive-site.xml
RUN rm -rf ${DOCKER_DIR}$GIT_DIR

EXPOSE 22