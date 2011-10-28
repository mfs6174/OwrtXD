#!/bin/sh
cp conf/network /etc/config/
cp mentohust/mento /usr/sbin/
chmod +x /usr/sbin/mento
cp -r mentohust/mentohust /etc/
opkg install packages/lippcap.ipk
echo "[MentoHUST]
MaxFail=8
Username=$3
Password=$4
Nic=eth1.1
IP=$2
Mask=
Gateway=0.0.0.0
DNS=0.0.0.0
PingHost=0.0.0.0
Timeout=8
EchoInterval=30
RestartWait=15
StartMode=1
DhcpMode=1
DaemonMode=2
ShowNotify=5
Version=4.60
DataFile=/etc/mentohust/
DhcpScript=udhcpc -r $2 -i br-wan
">>mentohust/mentohust.conf
cp mentohust/mentohust.conf /etc/
echo "#!/bin/sh
ifconfig eth1.1 down
ifconfig eth1.1 up
ifconfig br-wan down
ifconfig br-wan up
ifconfig br-wan 0.0.0.0
ifconfig eth1.1 hw ether $1
ifconfig br-wan hw ether $1
mento
">>start.sh
chmod +x start.sh
cp start.sh /usr/sbin/
 