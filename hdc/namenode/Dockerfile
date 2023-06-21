FROM hdc_baseimage

ARG HDC_USER

RUN su - $HDC_USER
RUN ssh -o StrictHostKeyChecking=no ${HDC_USER}@$(hostname)

RUN hdfs namenode -format

EXPOSE 9870