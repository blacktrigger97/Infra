ARG MYSQL_VER

FROM mysql:${MYSQL_VER}

ARG DOCKER_DIR
ARG GIT_DIR
ARG GIT_REMOTE_ADDRESS
ARG MYSQL_DIR

# Install Cron
RUN apt-get update && apt install cron git vim net-tools rsync -y
RUN update-rc.d cron enable

# Host & Start Scripts config
RUN mkdir -p ${DOCKER_DIR}hosts
RUN mkdir -p ${DOCKER_DIR}s_scripts

#RUN echo "export DOCKER_DIR=$DOCKER_DIR" >> ${DOCKER_DIR}.bashrc
RUN (crontab -l 2>/dev/null; echo "*/2 * * * * . ${DOCKER_DIR}.bashrc; cd ${DOCKER_DIR}s_scripts && ./host-config-ubuntu.sh > /hosts.log 2>&1") | crontab -u root -
RUN sed -i '26i bind-address    =   mysql' /etc/mysql/my.cnf

RUN cd $DOCKER_DIR && git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/s_scripts/ ${DOCKER_DIR}s_scripts
RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/$MYSQL_DIR/init/ /docker-entrypoint-initdb.d/
RUN chmod -R 1777 /root

#RUN sed -i '2i sleep 30' /usr/local/bin/docker-entrypoint.sh
#RUN sed -i '2i service cron reload' /usr/local/bin/docker-entrypoint.sh
#RUN sed -i '2i (crontab -l 2>/dev/null; echo "*/2 * * * * . \\$HOME/.bashrc; cd \\$HOME/s_scripts && ./host-config-ubuntu.sh > /hosts.log 2>&1") | crontab -' /usr/local/bin/docker-entrypoint.sh
RUN sed -i "2i cd ${DOCKER_DIR}s_scripts && ./host-config-ubuntu.sh" /usr/local/bin/docker-entrypoint.sh
RUN sed -i "2i sed -i '2i DOCKER_DIR=$DOCKER_DIR' ${DOCKER_DIR}s_scripts/host-config-ubuntu.sh" /usr/local/bin/docker-entrypoint.sh
#RUN sed -i '2i service cron start' /usr/local/bin/docker-entrypoint.sh
