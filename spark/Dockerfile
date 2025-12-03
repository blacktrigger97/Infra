ARG SPARK_VERSION

FROM bitnamilegacy/spark:${SPARK_VERSION}

USER root
RUN install_packages curl
USER 1001
RUN mkdir /opt/bitnami/spark/extraJars
RUN touch /opt/bitnami/spark/conf/hadoop-metrics2-s3a-file-system.properties
