#!/bin/bash -e

. /opt/bitnami/base/functions
. /opt/bitnami/base/helpers

print_welcome_page

while ! nc -z postgresql 5432; do
  info "Waiting for PostgreSQL to be up...";
  sleep 2;
done;
info "PostgreSQL is up. Proceeding.";

if [[ "$1" == "nami" && "$2" == "start" ]] || [[ "$1" == "/init.sh" ]]; then
    nami_initialize postgresql-client sonarqube
    info "Starting gosu... "
fi

exec tini -- "$@"
