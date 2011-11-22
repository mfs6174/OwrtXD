#!/bin/sh
ip -6 route del
sysctl -w net.ipv6.conf.br-lan.forwarding=1
radvd
