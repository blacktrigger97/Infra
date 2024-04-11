FROM dn

ARG DOCKER_DIR
ARG SPARK_VERSION
ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS

WORKDIR $DOCKER_DIR

# Bash Entries
RUN echo "export PYTHONPATH=\$SPARK_HOME/python:\$PYTHONPATH" >> .bashrc
RUN echo "export PYSPARK_DRIVER_PYTHON='jupyter'" >> .bashrc
RUN echo "export PYSPARK_DRIVER_PYTHON_OPTS='notebook'" >> .bashrc
RUN echo "export PYSPARK_PYTHON=python3" >> .bashrc
RUN echo "export PYSPARK_HADOOP_VERSION=3" >> .bashrc

RUN mkdir notebooks
RUN git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru $GIT_DIR/s_scripts/ s_scripts

RUN pip3 install pynessie
RUN nessie remote add http://nessie.bdc.home:19120/api/v1
RUN pip3 install jupyter
RUN pip3 install pyspark==${SPARK_VERSION}
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

CMD ["/root/s_scripts/jupyter.sh"]
