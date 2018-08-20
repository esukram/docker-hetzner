FROM alpine:latest

RUN apk add --update ca-certificates openssl postgrey perl-netaddr-ip \
    && wget -O /etc/postfix/postgrey_whitelist_clients.live https://raw.githubusercontent.com/schweikert/postgrey/master/postgrey_whitelist_clients \
    && rm -rf /var/cache/apk/*

COPY whitelist_clients /etc/postfix/postgrey_whitelist_clients.local

CMD ["postgrey", "--inet", "0.0.0.0:10023", "--delay", "60", "--user", "postgrey", "--group", "postgrey", "--hostname", "postgrey" \
    , "--greylist-text", "Greylisted for %s seconds, , see http://postgrey.schweikert.ch/help/%r.html" \
    , "--whitelist-clients", "/etc/postfix/postgrey_whitelist_clients" \
    , "--whitelist-clients", "/etc/postfix/postgrey_whitelist_clients.live" \
    , "--whitelist-clients", "/etc/postfix/postgrey_whitelist_clients.local" \
    , "--verbose" \
    ]
