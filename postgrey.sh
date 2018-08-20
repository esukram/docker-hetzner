#!/usr/bin/env bash

set -x

NAME=postgrey
TIMEZONE="-v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro"
DISK="-v /srv/postgrey:/var/spool/postfix/postgrey"

IMG_VER=$(date '+%Y%m%d_%H%M')

docker pull alpine:latest
docker build -t esukram/${NAME}:latest -t esukram/${NAME}:${IMG_VER} /srv/docker/${NAME}/

docker stop ${NAME}
docker rm ${NAME}
docker run --name ${NAME} --restart=unless-stopped -d ${TIMEZONE} ${DISK} ${PORT} esukram/${NAME}:latest
