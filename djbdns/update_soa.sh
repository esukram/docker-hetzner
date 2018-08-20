#!/bin/bash

DOMAIN=$1

ZONE_FILE="/zones/data"
SLAVE_IP="213.239.242.238"

if [ "${DOMAIN}x" != "x" ]; then
	echo "Updating only one domain: $DOMAIN"
fi

for dom in `grep "^Z.*" ${ZONE_FILE} | awk -F ":" '{print $1}' | sed -e s/^Z//g`
do
	if [ "${DOMAIN}x" != "x" ]; then
		if [ "$dom" != "$DOMAIN" ]; then
			continue;
		fi
	fi

	echo -n "Updating zone '$dom' ..."
	./dnsnotify $dom ${IP} >/dev/null 2>&1
	echo " done."
done
