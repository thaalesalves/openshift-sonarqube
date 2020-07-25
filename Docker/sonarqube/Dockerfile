FROM docker.io/centos:8
LABEL maintainer="Thales Alves <thales@thalesalv.es>" \
    io.k8s.description="A SonarQube 7.9.1 image optimized for OpenShift" \
    io.k8s.display-name="SonarQube 7.9.1" \
    io.openshift.expose-services="9000:http" \
    io.openshift.tags="sonarqube,codecoverage,sonar,coverage"

ENV SONARQUBE_VERSION="7.9.1" \
    SONAR_JDBC_USERNAME=sonarqube \
    SONAR_JDBC_PASSWORD=sonarqube \
    SONAR_JDBC_URL=jdbc:postgresql://postgresql/sonarqube \
    SONAR_ELASTISEARCH_DIR="/var/share/sonarqube/elastisearch" \
    SONAR_TEMP_DIR="/var/share/sonarqube/temp" \
    SONAR_LOGS="/opt/sonarqube/logs" \
    LC_ALL="en_US.UTF-8" \
    PATH="$PATH:/opt/sonarqube/bin/linux-x86-64"

COPY [ "scripts/entrypoint.sh", "scripts/commands", "/" ]
RUN yum update -y && yum upgrade -y && \
    yum install -y sudo emacs curl wget unzip java-11-openjdk-devel java-11-openjdk && \
    yum install -y glibc-locale-source glibc-langpack-en && \
    dnf install -y @postgresql:10 && \
    localedef -c -f UTF-8 -i en_US en_US.UTF-8 && \
    mkdir -p /var/share/sonarqube/elastisearch && \
    mkdir /var/share/sonarqube/temp && \
    wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.9.1.zip -P /tmp && \
    unzip /tmp/sonarqube-7.9.1.zip -d /opt && \
    mv /opt/sonarqube-7.9.1 /opt/sonarqube && \
    sed -i -e 's/\s*Defaults\s*secure_path\s*=/# Defaults secure_path=/' /etc/sudoers && \
    echo "sonar.jdbc.username=$SONAR_JDBC_USERNAME" >> /opt/sonarqube/conf/sonar.properties && \
    echo "sonar.jdbc.password=$SONAR_JDBC_PASSWORD" >> /opt/sonarqube/conf/sonar.properties && \
    echo "sonar.jdbc.url=$SONAR_JDBC_URL" >> /opt/sonarqube/conf/sonar.properties && \
    echo "sonar.path.data=$SONAR_ELASTISEARCH_DIR" >> /opt/sonarqube/conf/sonar.properties && \
    echo "sonar.path.temp=$SONAR_TEMP_DIR" >> /opt/sonarqube/conf/sonar.properties && \
    echo 'sonarqube ALL=NOPASSWD: ALL' >> /etc/sudoers && \
    useradd sonarqube -u 1001 && \
    chown -R sonarqube /opt && \
    chgrp -R 0 /opt && \
    chmod -R g=u /opt && \
    chown -R sonarqube /var/share/sonarqube && \
    chgrp -R 0 /var/share/sonarqube && \
    chmod -R g=u /var/share/sonarqube && \
    cat /commands >> /home/sonarqube/.bashrc

USER 1001
EXPOSE 9000
ENTRYPOINT [ "/entrypoint.sh" ]
