使用说明
=========================
1、使用mr11u-v2.bin升级固件（仅适用于mr11u v2版本，以下方法也适用于wr703n与mr11u v1的路由器，固件大家可以自行寻找）
2、修改network文件中wan的ipaddr、gateway、hostname、macaddr
3、修改wireless文件中wifi-iface的ssid、key
4、修改start.sh文件中的学号、密码、IP地址、网关
5、将文件拷贝到路由器中：
$scp m2 network rc.local start.sh wireless root@192.168.1.1:~
6、登录路由器网页管理，设置默认密码，然后在终端中拷贝配置文件：
$ssh root@192.168.1.1
#cp rc.local /etc/rc.local
#cp network /etc/config/network
#cp wireless /etc/config/wireless
#chmod +x start.sh
#chmod +x m2
6、测试，先插上网线，然后再终端中执行：#./start.sh，稍等片刻看电脑能否上网
如果6能上网则表示配置完成！

