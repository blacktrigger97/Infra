ARG DB_VER

FROM postgres:${DB_VER}

ARG DOCKER_DIR
ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS
#ARG MYSQL_DIR

COPY init.sql /docker-entrypoint-initdb.d/

WORKDIR ${DOCKER_DIR}

# Install Cron
RUN apt-get update && apt install cron git net-tools rsync -y
RUN update-rc.d cron enable

# Host & Start Scripts config
RUN mkdir -p hosts
RUN mkdir -p s_scripts
RUN chmod -R 777 /root

RUN (crontab -l 2>/dev/null; echo "*/2 * * * * . ${DOCKER_DIR}.bashrc; cd ${DOCKER_DIR}s_scripts && ./host-config-ubuntu.sh &> ${DOCKER_DIR}s_scripts/hosts.log") | crontab -u root -
#RUN echo "listen_addresses = '*'" >> /var/lib/postgresql/data/postgresql.conf
#RUN sed -i "90i host    all             all             postgres/34            trust"  /var/lib/postgresql/data/pg_hba.conf

RUN git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru $GIT_DIR/s_scripts/ s_scripts

RUN sed -i "2i cd ${DOCKER_DIR}s_scripts && ./host-config-ubuntu.sh" /usr/local/bin/docker-entrypoint.sh
RUN sed -i "2i sed -i '2i DOCKER_DIR=$DOCKER_DIR' ${DOCKER_DIR}s_scripts/host-config-ubuntu.sh" /usr/local/bin/docker-entrypoint.sh
