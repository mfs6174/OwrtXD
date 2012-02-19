#!/bin/sh
ip6tables -F 2>/dev/null
sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv6.conf.all.proxy_ndp=1
ip -6 route del default
sleep 1
ip -6 route add default via `rdisc6 eth1.1 |grep from | sed 's/ from //'` dev eth1.1
sleep 4
npd6  > /dev/null
 
