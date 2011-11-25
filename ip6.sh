#!/bin/sh
ifconfig eth1.1 hw ether 48:5b:39:66:f2:1f 
ifconfig br-wan hw ether 48:5b:39:66:f2:1f
ifconfig eth1.1 down
ifconfig br-wan down
ifconfig eth1.1 up
ifconfig br-wan up

