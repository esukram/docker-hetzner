#!/bin/ash

set -x
set -e

[ -d /dev/net ] ||
    mkdir -p /dev/net
[ -c /dev/net/tun ] ||
    mknod /dev/net/tun c 10 200

cat /passwd >> /etc/passwd
cat /shadow >> /etc/shadow

iptables -t nat -A POSTROUTING -s 172.30.38.0/24 -o eth0 -j MASQUERADE

touch /var/log/openvpn-status.log

openvpn /etc/openvpn/udp.conf 2>&1 >/var/log/openvpn.log &
sleep 1
openvpn /etc/openvpn/tcp.conf 2>&1 >>/var/log/openvpn.log &
sleep 1

exec $@
