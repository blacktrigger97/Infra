FROM baseimage

ARG DOCKER_USR
ARG DOCKER_DIR
ARG DOCKER_PASS
ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS
ARG HDC_VERSION
ARG HIVE_VERSION
ARG MYSQL_CONN_VER
ARG SPARK_VERSION
ARG SPARK_HDC_VERSION

#Install MariaDB client
RUN yum install mysql which procps -y

# SSH configuration
RUN echo $DOCKER_PASS | passwd $DOCKER_USR --stdin
RUN < /dev/zero ssh-keygen -q -N '' && cat ${DOCKER_DIR}.ssh/id_rsa.pub >> ${DOCKER_DIR}.ssh/authorized_keys && cat ${DOCKER_DIR}.ssh/id_rsa > ${DOCKER_DIR}.ssh/known_keys && chmod 600 ${DOCKER_DIR}.ssh/*_keys

WORKDIR ${DOCKER_DIR}

# Host & Start Scripts config
RUN mkdir -p {hosts,s_scripts}

# Downloading Hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-$HDC_VERSION/hadoop-$HDC_VERSION.tar.gz -P 
RUN cd  && tar -zxf hadoop-$HDC_VERSION.tar.gz && rm hadoop-$HDC_VERSION.tar.gz
RUN mv hadoop-$HDC_VERSION hadoop

# Downloading Hive
RUN wget https://dlcdn.apache.org/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz -P 
RUN cd  && tar -zxf apache-hive-$HIVE_VERSION-bin.tar.gz && rm apache-hive-$HIVE_VERSION-bin.tar.gz
RUN mv apache-hive-$HIVE_VERSION-bin hive
RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONN_VER}/mysql-connector-java-${MYSQL_CONN_VER}.jar -P hive/lib/

# Downloading Spark
RUN wget https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION}.tgz -P 
RUN cd  && tar -zxf spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION}.tgz && rm spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION}.tgz
RUN mv spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION} spark
RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONN_VER}/mysql-connector-java-${MYSQL_CONN_VER}.jar -P spark/lib/

# Hive & Hadoop configuration
#RUN rm hive/lib/guava-*
#RUN cp -rf hadoop/share/hadoop/common/lib/guava-* hive/lib/


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
RUN echo "export DOCKER_DIR=$DOCKER_DIR" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "########HIVE Exports########" >> .bashrc
RUN echo "export HIVE_HOME=${DOCKER_DIR}hive" >> .bashrc
RUN echo "export HIVE_CONF_DIR=\$HIVE_HOME/conf" >> .bashrc
RUN echo "export PATH=\$PATH:\$HIVE_HOME/bin:\$HIVE_CONF_DIR:\$SPARK_HOME/bin:\$SPARK_HOME/sbin" >> .bashrc
RUN echo "alias bhive='beeline -u jdbc:hive2://secon-hist:10000 --incremental=true'" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "########SPARK Exports########" >> .bashrc
RUN echo "export SPARK_HOME=${DOCKER_DIR}spark" >> .bashrc
RUN echo "export PATH=\$PATH:\$HIVE_HOME/bin:\$HIVE_HOME/lib:\$HIVE_CONF_DIR:\$SPARK_HOME/bin:\$SPARK_HOME/sbin" >> .bashrc
RUN echo "export LD_LIBRARY_PATH=/opt/hadoop/lib/native:\$LD_LIBRARY_PATH" >> .bashrc

RUN echo "export JAVA_HOME=/usr/lib/jvm/jre/" >> hadoop/etc/hadoop/hadoop-env.sh
RUN mv hive/conf/hive-env.sh.template hive/conf/hive-env.sh
RUN mv hive/conf/hive-default.xml.template hive/conf/hive-site.xml
RUN echo "export HADOOP_HOME=${DOCKER_DIR}hadoop" >> hive/conf/hive-env.sh
RUN mv spark/conf/spark-defaults.conf.template spark/conf/spark-defaults.conf
#RUN mv spark/conf/spark-env.sh.template spark/conf/spark-env.sh
##RUN echo "export HADOOP_HOME=${DOCKER_DIR}hadoop" >> spark/conf/spark-env.sh
RUN cd $DOCKER_DIR && git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru $GIT_DIR/hadoop/ hadoop
RUN rsync -avru $GIT_DIR/hive/ hive
RUN rsync -avru $GIT_DIR/spark/ spark
RUN ln -s hive/conf/hive-site.xml spark/conf/hive-site.xml
RUN rm -rf $GIT_DIR

EXPOSE 22