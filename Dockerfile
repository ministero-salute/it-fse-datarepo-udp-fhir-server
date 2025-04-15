FROM paas-base-image/openjdk-21:1.21-3.1737580424

WORKDIR /workspace/app

ARG JAR_FILE=./*.jar
ARG RUNTIME=./runtime

ENV AB_JOLOKIA_OFF=true
ENV WORKBENCH_MAX_METASPACE_SIZE=1024
ENV JAVA_DIAGNOSTICS=true
ENV JAVA_OPTIONS="-XX:TieredStopAtLevel=1 -noverify -Xms512m -Xmx1024m"
ENV GC_MAX_METASPACE_SIZE=300

USER root

RUN useradd -u 185 -g 185 -r -m -d /home/jboss -s /sbin/nologin -c "JBoss user" jboss || true && \
    mkdir -p /deployments /workspace/app && \
    chown -R jboss:jboss /deployments /workspace/app /home/jboss

USER jboss

COPY ${JAR_FILE} /deployments/
COPY ${RUNTIME} /deployments/

USER jboss