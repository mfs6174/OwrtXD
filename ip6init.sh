#!/bin/sh
if [ `echo ${#1}` != "19" ]; then
    echo "wrong ipv6 prefix: $1 ; it should be xxxx:xxxx:xxxx:xxxx ; we need all the leading zeros"
    exit 2
fi
echo "setting bin files..."
opkg install packages/rdisc6.ipk
opkg install packages/radvd.ipk
cp npd6/npd6 /usr/sbin/
chmod +x /usr/sbin/npd6
echo "setting config files..."
sed "/list prefix-m/c\\        list prefix             '$1::/64'" conf/radvd > /etc/config/radvd
sed "/prefix=/c\\prefix = $1:" npd6/npd6.conf > /etc/npd6.conf
sed  "/config 'interface' 'wan'/a\\option 'ip6addr' '$1$3/124'" conf/network.static > network.tmp
sed -i "/config 'interface' 'lan'/a\\option 'ip6addr' '$1$2/64'" network.tmp
mv network.tmp /etc/config/network	
echo "setting ip6.sh and auto start"
/etc/init.d/radvd enable
sed -i "/sleep 4/i\\ip -6 route del $1::/64 dev eth1" ip6.sh
sed -i "/sleep 4/i\\ip -6 address add $1$3/124 dev eth1.1" ip6.sh
chmod +x ip6.sh
cp ip6.sh /usr/sbin/
cp /etc/rc.local /etc/rc.local.back2
sed -i '/exit 0/i\\sleep 1' /etc/rc.local
sed -i '/exit 0/i\\ip6.sh' /etc/rc.local







