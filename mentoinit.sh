 # File: mentoinit.sh 
 # Author: Zhang Xijin(mfs6174)
 # Email: mfs6174@gmail.com
 #
 # Copyright (C) 2011 Zhang Xijin(mfs6174)
 #
 # This file is part of OwrtXD.
 #
 # OwrtXD is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # OwrtXD is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with OwrtXD.  If not, see <http://www.gnu.org/licenses/>.

 # This work is licensed under a Creative Commons Attribution-NonCommercial 2.5 Generic License.
 # http://creativecommons.org/licenses/by-nc/2.5/
 # 未经作者授权,绝对不允许用做商业目的!

#!/bin/sh
sta="1"
echo "copying and setting config files..."
echo "    option 'ipaddr' '$2'" >> conf/network.static
if [ "$sta" = "1" ]; then
    cp conf/network.static /etc/config/network
    dm="0"
else
    cp conf/network /etc/config/
    mv /usr/share/udhcpc/default.script /usr/share/udhcpc/default.script.back
    cp conf/default.script /usr/share/udhcpc/
    dm="1"
fi
mv /etc/config/dhcp /etc/config/dhcp.back
cp conf/dhcp /etc/config/
cp conf/resolv.conf /etc/
if [ "$6" = "1" ]; then
    cp /etc/rc.local /etc/rc.local.back
    sed -i '/exit 0/i\\start.sh' /etc/rc.local
fi
echo "copying and setting bin files..."
if [ "$sta" = "1" ]; then
    cp mentohust/mento.xd /usr/sbin/mento
    df=""
    dv="0.00"
else
    cp mentohust/mento /usr/sbin/mento
    cp -r mentohust/mentohust /etc/
    df="/etc/mentohust"
    dv="4.60"
fi
chmod +x /usr/sbin/mento
opkg install packages/libpcap.ipk
echo "generating config and start.sh..."
echo "[MentoHUST]
MaxFail=8
Username=$3
Password=$4
Nic=eth1.1
IP=$2
Mask=
Gateway=$5
DNS=0.0.0.0
PingHost=61.134.1.5
Timeout=8
EchoInterval=30
RestartWait=15
StartMode=1
DhcpMode=$dm
DaemonMode=2
ShowNotify=5
Version=$dv
DataFile=$df
">mentohust/mentohust.conf
if [ "$dm" = "1" ]; then
    echo "DhcpScript=udhcpc -r $2 -i br-wan" >> mentohust/mentohust.conf
    echo "#!/bin/sh
ifconfig eth1.1 down
ifconfig eth1.1 up
ifconfig br-wan down
ifconfig br-wan up
ifconfig br-wan 0.0.0.0
ifconfig eth1.1 hw ether $1
ifconfig br-wan hw ether $1
mento
">start.sh
else
    echo "DhcpScript=" >> mentohust/mentohust.conf
    echo "#!/bin/sh
ifconfig eth1.1 down
ifconfig eth1.1 up
ifconfig br-wan down
ifconfig br-wan up
ifconfig br-wan $2 netmask 255.255.255.0
route add default gw $5
ifconfig eth1.1 hw ether $1
ifconfig br-wan hw ether $1
mento
">start.sh
fi
cp mentohust/mentohust.conf /etc/
chmod +x start.sh
cp start.sh /usr/sbin/
echo "done! just run start.sh to start"
 
