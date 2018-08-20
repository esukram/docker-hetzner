#!/usr/bin/env bash

IP=$(ip a | awk '/inet 172/ {print $2}' | sed 's/\/16$//')

# start daemontools
echo -n "Starting daemontolls service... "
/usr/bin/svscanboot &
sleep 3
echo "done."

# create tinydns config
rmdir /etc/tinydns
tinydns-conf root root /etc/tinydns ${IP}
cd /etc/tinydns/root/ && /usr/bin/tinydns-data /zones/data

# start tinydns
ln -s /etc/tinydns /service/tinydns

# create axfrdns config
/usr/bin/axfrdns-conf root root /etc/axfrdns /etc/tinydns ${IP}
cd /etc/axfrdns && /usr/bin/tcprules tcp.cdb tcp.tmp < /axfrdns/data

# start axfrdns
ln -s /etc/axfrdns /service/axfrdns

echo -n "Waiting for services startup... "
sleep 5
echo "done."
svstat /service/tinydns
svstat /service/axfrdns

# trigger update of SOA for slaves
cd /zones && /zones/update_soa.sh

cd /

exec $@
