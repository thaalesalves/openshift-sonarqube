FROM docker.io/bitnami/minideb:buster
LABEL maintainer="Thales Alves <thales@thalesalv.es>" \
    io.k8s.description="A SonarQube image for OpenShift, based on Bitnami's SonarQube image" \
    io.k8s.display-name="SonarQube" \
    io.openshift.expose-services="9000:http" \
    io.openshift.tags="sonarqube,codecoverage,sonar,coverage"

ENV PATH="/opt/bitnami/postgresql/bin:/opt/bitnami/java/bin:/opt/bitnami/common/bin:/opt/bitnami/sonarqube/bin/linux-x86-64/:/opt/bitnami/nami/bin:$PATH"

COPY prebuildfs /
RUN install_packages ca-certificates curl gzip libblkid1 libbsd0 libc6 libedit2 libffi6 libgcc1 libglib2.0-0 \
    libgmp10 libgnutls30 libhogweed4 libicu63 libidn2-0 libldap-2.4-2 liblzma5 libmount1 libnettle6 libp11-kit0 \
    libpcre3 libsasl2-2 libselinux1 libssl1.1 libstdc++6 libtasn1-6 libtinfo6 libunistring2 libuuid1 libxml2 libxslt1.1 procps sudo tar zlib1g && \
    /build/bitnami-user.sh && \
    /build/install-nami.sh && \
    bitnami-pkg unpack postgresql-client-10.13.0-2 --checksum e0ed74425c548835e468d2bdead1ce1c266d5c77d56f3104f3a9b4dcf4e5ac35 && \
    bitnami-pkg install java-11.0.8-0 --checksum 268e7ba913422e7acd282b94615b127eeb56e3c4bb7e3c9c6d952c391e6ead4d && \
    bitnami-pkg install tini-0.19.0-0 --checksum 9a8ae20be31a518f042fcec359f2cf35bfdb4e2a56f2fa8ff9ef2ecaf45da80c && \
    bitnami-pkg unpack sonarqube-8.4.1-0 --checksum c14a6adf36bbcfe89a02d42dcfb2697ba1f358a80ec982645d9095df34465754 && \
    bitnami-pkg install gosu-1.12.0-1 --checksum 51cfb1b7fd7b05b8abd1df0278c698103a9b1a4964bdacd87ca1d5c01631d59c && \
    apt-get update -y && apt-get upgrade -y && \
    apt-get install netcat -y && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives && \
    mkdir /bitnami && \
    chgrp -R 0 /bitnami && \
    chmod -R g=u /bitnami && \
    chgrp -R 0 /opt && \
    chmod -R g=u /opt

COPY rootfs /
ENV BITNAMI_APP_NAME="sonarqube" \
    BITNAMI_IMAGE_VERSION="8.4.1-debian-10-r0" \
    OS_ARCH="amd64" \
    OS_FLAVOUR="debian-10" \
    OS_NAME="linux" \
    POSTGRESQL_CLIENT_CREATE_DATABASE_NAME="" \
    POSTGRESQL_CLIENT_CREATE_DATABASE_PASSWORD="" \
    POSTGRESQL_CLIENT_CREATE_DATABASE_USERNAME="" \
    POSTGRESQL_HOST="postgresql" \
    POSTGRESQL_PORT_NUMBER="5432" \
    POSTGRESQL_ROOT_PASSWORD="postgres" \
    POSTGRESQL_ROOT_USER="postgres" \
    SMTP_HOST="" \
    SMTP_PASSWORD="" \
    SMTP_PORT="" \
    SMTP_PROTOCOL="" \
    SMTP_USER="" \
    SONARQUBE_CE_JAVA_ADD_OPTS="" \
    SONARQUBE_DATABASE_NAME="sonarqube" \
    SONARQUBE_DATABASE_PASSWORD="sonarqube" \
    SONARQUBE_DATABASE_USER="sonarqube" \
    SONARQUBE_ELASTICSEARCH_JAVA_ADD_OPTS="" \
    SONARQUBE_ELASTICSEARCH_PORT_NUMBER="9001" \
    SONARQUBE_ENABLE_DEMO_DATA="no" \
    SONARQUBE_PASSWORD="admin" \
    SONARQUBE_USERNAME="admin" \
    SONARQUBE_PORT_NUMBER="9000" \
    SONARQUBE_PROPERTIES="" \
    SONARQUBE_START_TIMEOUT="300" \
    SONARQUBE_WEB_CONTEXT="/" \
    SONARQUBE_WEB_JAVA_ADD_OPTS=""


EXPOSE 9000
ENTRYPOINT [ "/app-entrypoint.sh" ]
CMD [ "nami", "start", "--foreground", "sonarqube" ]
USER 1001
