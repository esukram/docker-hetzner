#!/usr/bin/env bash

set -x

NAME=djbdns
TIMEZONE="-v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro"

PORT="-p 53:53/tcp -p 53:53/udp"

IMG_VER=$(date '+%Y%m%d_%H%M')

# build new verion
docker pull alpine:edge
docker build -t esukram/${NAME}:latest -t esukram/${NAME}:${IMG_VER} /srv/docker/${NAME}/

docker stop ${NAME}
docker rm ${NAME}
docker run --name ${NAME} --restart=unless-stopped -d ${TIMEZONE} ${DISK} ${LINK} ${PORT} ${ENV} esukram/${NAME}
