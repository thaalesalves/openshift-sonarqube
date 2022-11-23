FROM redhat/ubi8:8.7

LABEL maintainer="Thales Alves <thales@thalesalv.es>" \
    io.k8s.description="A SonarQube image optimized for OpenShift" \
    io.k8s.display-name="SonarQube" \
    io.openshift.expose-services="9000:http" \
    io.openshift.tags="sonarqube,codecoverage,sonar,coverage"

ARG SONARQUBE_VERSION=8.9.9.56886

ENV SONAR_JDBC_USERNAME=sonarqube \
    SONAR_JDBC_PASSWORD=sonarqube \
    SONAR_JDBC_URL=jdbc:postgresql://postgresql/sonarqube \
    SONAR_ELASTICSEARCH_DIR="/var/share/sonarqube/elasticsearch" \
    SONAR_TEMP_DIR="/var/share/sonarqube/temp" \
    SONAR_LOGS="/opt/sonarqube/logs" \
    LC_ALL="en_US.UTF-8" \
    PATH="$PATH:/opt/sonarqube/bin/linux-x86-64"

COPY [ "scripts/entrypoint.sh", "/opt" ]
RUN yum update -y && yum upgrade -y && \
    yum install -y procps sudo wget unzip java-11-openjdk-devel java-11-openjdk && \
    mkdir -p /var/share/sonarqube/elasticsearch /var/share/sonarqube/temp && \
    wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-$SONARQUBE_VERSION.zip -P /tmp && \
    unzip /tmp/sonarqube-$SONARQUBE_VERSION.zip -d /opt && \
    mv /opt/sonarqube-$SONARQUBE_VERSION /opt/sonarqube && \
    sed -i -e 's/\s*Defaults\s*secure_path\s*=/# Defaults secure_path=/' /etc/sudoers && \
    echo 'sonarqube ALL=NOPASSWD: ALL' >> /etc/sudoers && \
    useradd sonarqube -u 1001 && \
    chown -R sonarqube /opt /var/share/sonarqube && \
    chgrp -R 0 /opt /var/share/sonarqube && \
    chmod -R g=u /opt /var/share/sonarqube

VOLUME [ "/var/share/sonarqube", "/var/share/sonarqube/elasticsearch", "/var/share/sonarqube/temp" ]
EXPOSE 9000
ENTRYPOINT [ "/opt/entrypoint.sh" ]
USER 1001
