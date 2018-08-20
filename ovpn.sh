#!/usr/bin/env bash

set -x

NAME=ovpn
TIMEZONE="-v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro"

DISK="-v /etc/getssl/esukram.org:/etc/ssl:ro"

PORT="-p 1194:1194/udp -p 1194:1194/tcp"

IMG_VER=$(date '+%Y%m%d_%H%M')

# build new verion
docker pull alpine:edge
docker build -t esukram/${NAME}:latest -t esukram/${NAME}:${IMG_VER} /srv/docker/${NAME}/

docker stop ${NAME}
docker rm ${NAME}
docker run --name ${NAME} --restart=unless-stopped --privileged -d ${TIMEZONE} ${DISK} ${LINK} ${PORT} ${ENV} esukram/${NAME}
