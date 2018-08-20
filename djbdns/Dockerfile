FROM alpine:edge

RUN apk --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ add --update \
    daemontools ucspi-tcp
RUN apk add --update \
    bash \
    tinydns djbdns \
    perl perl-net-dns \
    && rm -rf /var/cache/apk/*

RUN mkdir /zones \
    && mkdir /axfrdns

COPY entrypoint.sh /entrypoint.sh

COPY zones /zones/data
COPY dnsnotify /zones/dnsnotify
COPY update_soa.sh /zones/update_soa.sh

COPY axfr /axfrdns/data

EXPOSE 53/tcp
EXPOSE 53/udp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["tail", "-f", "/etc/tinydns/log/main/current", "/etc/axfrdns/log/main/current"]
