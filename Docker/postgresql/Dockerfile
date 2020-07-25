FROM docker.io/bitnami/minideb:buster
LABEL maintainer="Thales Alves <thales@thalesalv.es>" \
    io.k8s.description="A PostgreSQL image for OpenShift, based on Bitnami's PostgreSQL image" \
    io.k8s.display-name="PostgreSQL" \
    io.openshift.expose-services="5432:5432" \
    io.openshift.tags="postgres,postgresql,database,sql"

ENV HOME="/" \
    OS_ARCH="amd64" \
    OS_FLAVOUR="debian-10" \
    OS_NAME="linux" \
    BITNAMI_APP_NAME="postgresql" \
    BITNAMI_IMAGE_VERSION="10.13.0-debian-10-r64" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    NSS_WRAPPER_LIB="/opt/bitnami/common/lib/libnss_wrapper.so" \
    PATH="/opt/bitnami/postgresql/bin:/opt/bitnami/common/bin:$PATH" \
    POSTGRESQL_POSTGRES_PASSWORD="postgres"

COPY [ "prebuildfs", "rootfs", "/"]
VOLUME [ "/bitnami/postgresql", "/docker-entrypoint-initdb.d", "/docker-entrypoint-preinitdb.d" ]
RUN install_packages acl ca-certificates curl gzip libbsd0 libc6 libedit2 libffi6 libgcc1 \
    libgmp10 libgnutls30 libhogweed4 libicu63 libidn2-0 libldap-2.4-2 liblzma5 libnettle6 \
    libp11-kit0 libsasl2-2 libsqlite3-0 libssl1.1 libstdc++6 libtasn1-6 libtinfo6 libunistring2 \
    libuuid1 libxml2 libxslt1.1 locales procps tar zlib1g && \
    . /opt/bitnami/scripts/libcomponent.sh && component_unpack "postgresql" "10.13.0-9" --checksum 879ec7573bd4be62b37bc381379b56ea3699f161105654e1aadf0f93b8ed1ac8 && \
    . /opt/bitnami/scripts/libcomponent.sh && component_unpack "gosu" "1.12.0-1" --checksum 51cfb1b7fd7b05b8abd1df0278c698103a9b1a4964bdacd87ca1d5c01631d59c && \
    apt-get update && apt-get upgrade -y && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives && \
    chmod g+rwX /opt/bitnami && \
    localedef -c -f UTF-8 -i en_US en_US.UTF-8 && \
    update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales && \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen && \
    /opt/bitnami/scripts/postgresql/postunpack.sh && \
    useradd -u 1001 postgres && \
    chown -R 1001 /opt && \
    chgrp -R 0 /bitnami && \
    chmod -R g=u /bitnami && \
    chown -R 1001 /bitnami && \
    chgrp -R 0 /opt && \
    chmod -R g=u /opt

USER 1001
EXPOSE 5432
ENTRYPOINT [ "/opt/bitnami/scripts/postgresql/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/postgresql/run.sh" ]
