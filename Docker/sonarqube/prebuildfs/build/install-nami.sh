#!/bin/bash

curl --silent -L https://nami-prod.s3.amazonaws.com/tools/nami/releases/nami-2.0.0-0-linux-x64.tar.gz > /tmp/nami-linux-x64.tar.gz
echo "63e836f3d752cb157b175e1efe2238e5b4e04ab139097c682ca5a0651f0df65c /tmp/nami-linux-x64.tar.gz" | sha256sum --check
mkdir -p /opt/bitnami/nami /opt/bitnami/licenses
tar xzf /tmp/nami-linux-x64.tar.gz --strip 1 -C /opt/bitnami/nami && rm /tmp/nami-linux-x64.tar.gz
curl --silent -L https://raw.githubusercontent.com/bitnami/nami/master/COPYING > /opt/bitnami/licenses/nami-2.0.0-0.txt
