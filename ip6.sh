#!/bin/sh
sysctl -w net.ipv6.conf.br-lan.forwarding=1
radvd
insmod /usr/share/napt66.ko wan_if=eth1.1
