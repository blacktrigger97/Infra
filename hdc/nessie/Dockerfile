FROM projectnessie/nessie

ARG DOCKER_USR
ARG DOCKER_PASS
ARG NESSIE_GC_VER

ENV JAVA_OPTS_APPEND="-Dnessie.server.authentication.enabled=false -Dnessie.version.store.type=JDBC -Dquarkus.datasource.db-kind=postgresql \
-Dquarkus.datasource.jdbc.max-size=16 -Dquarkus.datasource.username=${DOCKER_USR} -Dquarkus.datasource.password=${DOCKER_PASS} \
-Dquarkus.debug.print-startup-times=true -Dquarkus.profile=dev -Dquarkus.datasource.driver='org.postgresql.Driver' \
-Dquarkus.datasource.jdbc.url=jdbc:postgresql://postgresql.bdc.home:5432/nessie_gc"

WORKDIR /home/jboss

# Download Nessie GC Tool
RUN curl -LJ -o nessie-gc https://github.com/projectnessie/nessie/releases/download/nessie-${NESSIE_GC_VER}/nessie-gc-${NESSIE_GC_VER}

# Host & Start Scripts config
#RUN mkdir -p hosts
#RUN chown -R jboss /home/jboss/hosts

# Updating run script
RUN sed -i "2i java -jar nessie-gc create-sql-schema --jdbc-url jdbc:postgresql://postgresql.bdc.home:5432/nessie_gc --jdbc-user ${DOCKER_USR} --jdbc-password ${DOCKER_PASS}" /opt/jboss/container/java/run/run-java.sh
#RUN sed -i "2i export postgresql=\`cat /home/jboss/hosts/hosts | grep postgresql | awk '{print \$1;}'\`" /opt/jboss/container/java/run/run-java.sh
RUN sed -i "2i sleep 60" /opt/jboss/container/java/run/run-java.sh
#RUN sed -i "2i if [ \$? -eq 1 ]; then cat /etc/hosts | grep nessie >> /home/jboss/hosts/hosts; fi" /opt/jboss/container/java/run/run-java.sh
#RUN sed -i "2i cat /home/jboss/hosts/hosts | grep nessie" /opt/jboss/container/java/run/run-java.sh
