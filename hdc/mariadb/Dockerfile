ARG MARIADB_VER

FROM mariadb:${MARIADB_VER}

ARG GIT_DIR
ARG DOCKER_DIR
ARG GIT_REMOTE_ADDRESS

# Install Cron
RUN apt-get update && apt install cron git vim net-tools -y

# Host & Start Scripts config
RUN mkdir -p ${DOCKER_DIR}hosts
RUN mkdir -p ${DOCKER_DIR}s_scripts

RUN echo "export DOCKER_DIR=$DOCKER_DIR" >> ${DOCKER_DIR}.bashrc
RUN echo "bind-address=mariadb" >> /etc/mysql/mariadb.conf.d/50-server.cnf

RUN cd $DOCKER_DIR && git clone $GIT_REMOTE_ADDRESS
RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/s_scripts/ ${DOCKER_DIR}s_scripts
RUN rsync -avru ${DOCKER_DIR}$GIT_DIR/mariadb/init/ /docker-entrypoint-initdb.d/

RUN sed -i '2i service cron reload' /usr/local/bin/docker-entrypoint.sh
RUN sed -i '2i (crontab -l 2>/dev/null; echo "*/2 * * * * . \\$HOME/.bashrc; cd \\$HOME/s_scripts && ./host-config.sh > /hosts.log 2>&1") | crontab -' /usr/local/bin/docker-entrypoint.sh
RUN sed -i '2i cd /root/s_scripts && ./host-config.sh' /usr/local/bin/docker-entrypoint.sh
RUN sed -i '2i sed -i "2i DOCKER_DIR=/root/" /root/s_scripts/host-config.sh' /usr/local/bin/docker-entrypoint.sh
RUN sed -i '2i service cron start' /usr/local/bin/docker-entrypoint.sh
