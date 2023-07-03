FROM nrsh

ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS
ARG DOCKER_DIR
ARG DOCKER_SECONDARY_NAMENODE_DIR

#RUN yum install postgresql -y
WORKDIR $DOCKER_DIR

RUN echo "export DOCKER_SECONDARY_NAMENODE_DIR=$DOCKER_SECONDARY_NAMENODE_DIR" >> .bashrc
RUN echo -e "ssql () { spark-sql --packages org.apache.iceberg:iceberg-spark-runtime-3.2_2.12:1.3.0,org.projectnessie:nessie-spark-3.2-extensions:0.45.0\n \
--conf spark.sql.extensions='org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSpark32SessionExtensions'\n \
--conf spark.sql.catalog.nessie.uri='http://nessie:19120/api/v1' --conf spark.sql.catalog.nessie.ref=main  --conf spark.sql.catalog.nessie.authentication.type=NONE\n \
--conf spark.sql.catalog.nessie.catalog-impl=org.apache.iceberg.nessie.NessieCatalog --conf spark.sql.catalog.nessie=org.apache.iceberg.spark.SparkCatalog\n \
--conf spark.sql.catalog.nessie.warehouse=hdfs://name-res:9000/root/nessie/warehouse \$@ }" >> .bashrc

RUN git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru $GIT_DIR/s_scripts/ s_scripts
RUN rsync -avru $GIT_DIR/hadoop/ hadoop
RUN rsync -avru $GIT_DIR/spark/ spark

RUN mkdir -p $DOCKER_SECONDARY_NAMENODE_DIR
RUN chown root:root -R $DOCKER_SECONDARY_NAMENODE_DIR
RUN chmod 777 -R $DOCKER_SECONDARY_NAMENODE_DIR

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

CMD ["/root/s_scripts/secon-hist.sh"]