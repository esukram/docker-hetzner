FROM alpine:latest

RUN apk add --update \
    bash \
    openvpn openvpn-auth-pam \
    iptables \
    && rm -rf /var/cache/apk/*

RUN touch /var/log/ovpn.log

COPY entrypoint.sh /entrypoint.sh
COPY dh4096.pem /etc/dh4096.pem
COPY udp.conf /etc/openvpn
COPY tcp.conf /etc/openvpn
COPY passwd /passwd
COPY shadow /shadow

VOLUME /etc/ssl

EXPOSE 1194/udp 1194/tcp

ENTRYPOINT ["/entrypoint.sh"]

CMD ["tail", "-f", "/var/log/openvpn-status.log"]

