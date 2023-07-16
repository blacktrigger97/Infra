ARG OS_VER

FROM rockylinux:${OS_VER}

ARG JAVA_VER
ARG DOCKER_USR
ARG DOCKER_DIR
ARG DOCKER_PASS
ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS
ARG HDC_VERSION
ARG SPARK_VERSION
ARG SPARK_HDC_VERSION


# Java, Python & Other Dependencies
RUN yum install java-${JAVA_VER}-openjdk java-${JAVA_VER}-openjdk-devel -y
RUN yum install crontabs cronie net-tools wget gcc git rsync openssh-server openssh openssh-clients -y

# SSH configuration
RUN echo $DOCKER_PASS | passwd $DOCKER_USR --stdin
RUN < /dev/zero ssh-keygen -q -N '' && cat ${DOCKER_DIR}.ssh/id_rsa.pub >> ${DOCKER_DIR}.ssh/authorized_keys && cat ${DOCKER_DIR}.ssh/id_rsa > ${DOCKER_DIR}.ssh/known_keys && chmod 600 ${DOCKER_DIR}.ssh/*_keys

WORKDIR ${DOCKER_DIR}

# Host & Start Scripts config
RUN mkdir -p {hosts,s_scripts}

# Downloading Hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-$HDC_VERSION/hadoop-$HDC_VERSION.tar.gz
RUN cd  && tar -zxf hadoop-$HDC_VERSION.tar.gz && rm hadoop-$HDC_VERSION.tar.gz
RUN mv hadoop-$HDC_VERSION hadoop

# Downloading Spark
RUN wget https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION}.tgz
RUN cd  && tar -zxf spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION}.tgz && rm spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION}.tgz
RUN mv spark-${SPARK_VERSION}-bin-hadoop${SPARK_HDC_VERSION} spark

# Bashrc entries
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
RUN echo "export DOCKER_DIR=${DOCKER_DIR}" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "" >> .bashrc
RUN echo "########SPARK Exports########" >> .bashrc
RUN echo "export SPARK_HOME=${DOCKER_DIR}spark" >> .bashrc
RUN echo "export PATH=\$PATH:\$SPARK_HOME/bin:\$SPARK_HOME/sbin:/usr/sbin" >> .bashrc
RUN echo "export LD_LIBRARY_PATH=/opt/hadoop/lib/native:\$LD_LIBRARY_PATH" >> .bashrc

# Updating configuration files
RUN echo "export JAVA_HOME=/usr/lib/jvm/jre/" >> hadoop/etc/hadoop/hadoop-env.sh
RUN mv spark/conf/spark-defaults.conf.template spark/conf/spark-defaults.conf
RUN git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru $GIT_DIR/hadoop/ hadoop
RUN rsync -avru $GIT_DIR/spark/ spark
RUN rm -rf $GIT_DIR

EXPOSE 22