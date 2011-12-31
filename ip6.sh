#!/bin/sh
ip6tables -F 2>/dev/null
ip -6 route del default
sleep 1
rdisc6 br-wan
sleep 4
nohup npd6 & > /dev/null
 
