FROM docker.io/centos:8
LABEL maintainer="Thales Alves <thales@thalesalv.es>" \
    io.k8s.description="A SonarQube 8.4.1 image optimized for OpenShift" \
    io.k8s.display-name="SonarQube 8.4.1" \
    io.openshift.expose-services="9000:http" \
    io.openshift.tags="sonarqube,codecoverage,sonar,coverage"

ENV SONARQUBE_VERSION="8.4.1" \
    SONAR_JDBC_USERNAME=sonarqube \
    SONAR_JDBC_PASSWORD=sonarqube \
    SONAR_JDBC_URL=jdbc:postgresql://postgresql/sonarqube \
    SONAR_ELASTICSEARCH_DIR="/var/share/sonarqube/elasticsearch" \
    SONAR_TEMP_DIR="/var/share/sonarqube/temp" \
    SONAR_LOGS="/opt/sonarqube/logs" \
    LC_ALL="en_US.UTF-8" \
    PATH="$PATH:/opt/sonarqube/bin/linux-x86-64"

COPY [ "scripts/entrypoint.sh", "/opt" ]
RUN yum update -y && yum upgrade -y && \
    yum install -y sudo emacs curl wget unzip java-11-openjdk-devel java-11-openjdk && \
    yum install -y glibc-locale-source glibc-langpack-en && \
    dnf install -y @postgresql:10 && \
    localedef -c -f UTF-8 -i en_US en_US.UTF-8 && \
    mkdir -p /var/share/sonarqube/elasticsearch && \
    mkdir /var/share/sonarqube/temp && \
    wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.4.1.35646.zip -P /tmp && \
    unzip /tmp/sonarqube-8.4.1.35646.zip -d /opt && \
    mv /opt/sonarqube-8.4.1.35646 /opt/sonarqube && \
    sed -i -e 's/\s*Defaults\s*secure_path\s*=/# Defaults secure_path=/' /etc/sudoers && \
    echo 'sonarqube ALL=NOPASSWD: ALL' >> /etc/sudoers && \
    useradd sonarqube -u 1001 && \
    chown -R sonarqube /opt && \
    chgrp -R 0 /opt && \
    chmod -R g=u /opt && \
    chown -R sonarqube /var/share/sonarqube && \
    chgrp -R 0 /var/share/sonarqube && \
    chmod -R g=u /var/share/sonarqube

VOLUME [ "/var/share/sonarqube", "/var/share/sonarqube/elasticsearch", "/var/share/sonarqube/temp" ]
EXPOSE 9000
ENTRYPOINT [ "/opt/entrypoint.sh" ]
USER 1001
