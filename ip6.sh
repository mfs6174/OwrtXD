#!/bin/sh
ip6tables -F 2>/dev/null
sleep 1
rdisc6 br-wan
sleep 4
nohup npd6 & > /dev/null
 
