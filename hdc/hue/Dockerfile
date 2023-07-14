ARG OS_VER

FROM rockylinux:${OS_VER}

ARG HUE_VER
ARG GIT_DIR
ARG DOCKER_DIR
ARG GIT_REMOTE_ADDRESS


# Install Dependencies & Cron
RUN yum install ant asciidoc cyrus-sasl-devel cyrus-sasl-gssapi cyrus-sasl-plain gcc gcc-c++ krb5-devel \
    libffi-devel libxml2-devel libxslt-devel make mysql openldap-devel python-devel sqlite-devel \
    gmp-devel maven crontabs cronie git vim net-tools gmp-devel wget rsync -y

# Install Hue
RUN wget https://cdn.gethue.com/downloads/hue-${HUE_VER}.tgz -P ${DOCKER_DIR}
RUN cd ${DOCKER_DIR} && tar -zxf hue-${HUE_VER}.tgz

RUN echo "export DOCKER_DIR=$DOCKER_DIR" >> ${DOCKER_DIR}.bashrc
RUN echo "export PYTHON_VER=python3.9" >> ${DOCKER_DIR}.bashrc
#RUN cd ${DOCKER_DIR}hue && PREFIX=/usr/share make install

# Host & Start Scripts config
RUN mkdir -p ${DOCKER_DIR}hosts
RUN mkdir -p ${DOCKER_DIR}s_scripts

#RUN cd $DOCKER_DIR && git clone $GIT_REMOTE_ADDRESS
#RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/s_scripts/ ${DOCKER_DIR}s_scripts
#RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/mariadb/init/ /docker-entrypoint-initdb.d/