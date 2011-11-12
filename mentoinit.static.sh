#!/bin/sh
echo "copying and setting config files..."
echo "    option 'ipaddr' '$2'" >> conf/network.static
cp conf/network.static /etc/config/network
mv /etc/config/dhcp /etc/config/dhcp.back
cp conf/dhcp /etc/config/
cp conf/resolv.conf /etc/
echo "copying and setting bin files..."
cp mentohust/mento /usr/sbin/
chmod +x /usr/sbin/mento
cp -r mentohust/mentohust /etc/
opkg install packages/libpcap.ipk
echo "generating config and start.sh..."
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
DhcpMode=0
DaemonMode=2
ShowNotify=5
Version=4.60
DataFile=/etc/mentohust/
DhcpScript=
">mentohust/mentohust.conf
cp mentohust/mentohust.conf /etc/
echo "#!/bin/sh
ifconfig eth1.1 down
ifconfig eth1.1 up
ifconfig br-wan down
ifconfig br-wan up
ifconfig br-wan $2 netmask 255.255.255.0
ifconfig eth1.1 hw ether $1
ifconfig br-wan hw ether $1
mento
route add default gw $5
">start.sh
chmod +x start.sh
cp start.sh /usr/sbin/
echo "done! just run start.sh to start"
 
