#!/bin/sh
cp conf/network
cp mentohust/mento /usr/sbin/
chmod +x /usr/sbin/mento
cp -r mentohust/mentohust /etc/
echo " ">>mentohust/mentohust.conf
cp mentohust/mentohust.conf /etc/
echo " ">>start.sh
chmod +x start.sh
cp start.sh /usr/sbin/
 