ARG PY_VER

FROM python:${PY_VER}

ARG DOCKER_DIR
#ARG SPARK_VERSION
#ARG GIT_CONFIG_DIR
#ARG GIT_CONFIG_ADDRESS

#WORKDIR $DOCKER_DIR

# Bash Entries
#RUN echo "export PYTHONPATH=\$SPARK_HOME/python:\$PYTHONPATH:\$SPARK_HOME/jars" >> .bashrc
#RUN echo "export PYSPARK_DRIVER_PYTHON='jupyter'" >> .bashrc
#RUN echo "export PYSPARK_DRIVER_PYTHON_OPTS='notebook'" >> .bashrc
#RUN echo "export PYSPARK_PYTHON=python3" >> .bashrc
#RUN echo "export PYSPARK_HADOOP_VERSION=3" >> .bashrc
#RUN echo "" >> .bashrc
#RUN echo "export PYSPARK_SUBMIT_ARGS='--master yarn --deploy-mode client \
#--jars /root/spark/jars/iceberg-spark-runtime-${ICEBERG_SPARK_VER}-${ICEBERG_VER}.jar,/root/spark/jars/nessie-spark-extensions-${NESSIE_SPARK_VER}-${NESSIE_VER}.jar \
#--conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions \
#--conf spark.sql.catalog.nessie=org.apache.iceberg.spark.SparkCatalog --conf spark.sql.catalog.nessie.uri=http://nessie.bdc.home:19120/api/v1 \
#--conf spark.sql.catalog.nessie.ref=main --conf spark.sql.catalog.nessie.authentication.type=NONE \
#--conf spark.sql.catalog.nessie.catalog-impl=org.apache.iceberg.nessie.NessieCatalog \
#--conf spark.sql.catalog.nessie.warehouse=hdfs://name-res.bdc.home:9000/root/nessie/warehouse pyspark-shell'" >> .bashrc

# Install uv for fast package management
COPY --from=ghcr.io/astral-sh/uv:0.4.20 /uv /bin/uv
ENV UV_SYSTEM_PYTHON=1

# Copy requirements file
COPY --link requirements.txt .

# Install the requirements using uv
RUN uv pip install -r requirements.txt

RUN mkdir /root/notebooks
# UN git clone $GIT_CONFIG_ADDRESS
# RUN rsync -avru $GIT_CONFIG_DIR/s_scripts/ s_scripts

# RUN pip3 install pynessie
# RUN nessie remote add http://nessie.bdc.home:19120/api/v1
RUN pip3 install jupyter
# RUN pip3 install pyspark==${SPARK_VERSION}
RUN jupyter notebook --generate-config

# Jupiter config entries
RUN echo "c.NotebookApp.allow_root=True" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.port = 8091" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.password = u''" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.open_browser = True" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.ip = 'jupyter.bdc.home'" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.notebook_dir = '${DOCKER_DIR}notebooks/'" >> /root/.jupyter/jupyter_notebook_config.py 

EXPOSE 8091

#CMD ["/root/s_scripts/jupyter.sh"]