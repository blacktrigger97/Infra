FROM dn

ARG HDC_USER
ARG HDC_PASS

RUN mkdir /root/notebooks

RUN pip3 install jupyter
RUN pip3 install findspark
RUN jupyter notebook --generate-config

RUN echo "c.NotebookApp.allow_root=True" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.port = 8091" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.password = u''" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.open_browser = True" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.ip = 'jupyter.bdc.home'" >> /root/.jupyter/jupyter_notebook_config.py \
   && echo "c.NotebookApp.notebook_dir = '/root/notebooks/'" >> /root/.jupyter/jupyter_notebook_config.py 

EXPOSE 8091

CMD ["jupyter", "notebook"]
