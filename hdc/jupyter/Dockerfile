FROM dn

ARG HDC_USER
ARG HDC_PASS
ARG DOCKER_DIR

WORKDIR $DOCKER_DIR

RUN mkdir notebooks

RUN pip3 install jupyter
RUN pip3 install py4j
RUN jupyter notebook --generate-config

# Jupiter config entries
RUN echo "c.NotebookApp.allow_root=True" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.port = 8091" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.password = u''" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.open_browser = True" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.ip = 'jupyter.bdc.home'" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.notebook_dir = '${DOCKER_DIR}notebooks/'" >> /root/.jupyter/jupyter_notebook_config.py 

# Bash Entries
RUN echo "export PYTHONPATH=\$SPARK_HOME/python:\$PYTHONPATH" >> .bashrc
RUN echo "export PYSPARK_DRIVER_PYTHON='jupyter'" >> .bashrc
RUN echo "export PYSPARK_DRIVER_PYTHON_OPTS='notebook'" >> .bashrc
RUN echo "export PYSPARK_PYTHON=python3" >> .bashrc

EXPOSE 8091

CMD ["jupyter", "notebook"]
