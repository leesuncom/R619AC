#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 网络配置信息，将从 zzz-default-settings 文件的第2行开始添加
sed '6 iuci\ set\ system.@system[0].hostname=NeoBird' -i package/lean/default-settings/files/zzz-default-settings 
sed -i "46i echo 'iptables -t nat -I POSTROUTING -o eth0.1 -j MASQUERADE' >> /etc/firewall.user" package/lean/default-settings/files/zzz-default-settings # 关闭lan口的桥接所有数据的源IP都转换eth0.1这个接口的IP然后转发出去
sed -i "62i # network config" package/lean/default-settings/files/zzz-default-settings  
sed -i "63i uci set network.lan.ipaddr=192.168.1.2" package/lean/default-settings/files/zzz-default-settings # 默认IP地址，旁路由时不会和主路由的 192.168.1.1 冲突  OK
sed -i "64i uci set network.lan.proto=static" package/lean/default-settings/files/zzz-default-settings # 静态 IP  OK

sed -i "65i sed -i '/option type 'bridge'/d'" package/lean/default-settings/files/zzz-default-settings # 接口类型：关闭桥接
sed -i "66i sed -i '/option ip6assign/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "67i sed -i '/config interface 'lan'/a\option delegate '0'' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # 使用内置的 IPv6 管理，去掉勾，下一行插入
sed -i "68i sed -i '/config interface 'wan'/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "69i sed -i '/option ifname 'eth0.2'/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "70i sed -i '/option proto 'none'/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "71i sed -i '/config interface 'wan6'/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "72i sed -i '/option ifname 'eth0.2'/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "73i sed -i '/option proto 'dhcpv6'/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "74i uci set network.lan.ifname=eth0.1" package/lean/default-settings/files/zzz-default-settings  # 网络端口：默认 eth0.1，第一个接口  OK
sed -i "75i uci set network.lan.netmask=255.255.255.0" package/lean/default-settings/files/zzz-default-settings    # 子网掩码  OK
sed -i "76i uci set network.lan.gateway=192.168.1.1" package/lean/default-settings/files/zzz-default-settings  # 默认网关地址（主路由 IP）  OK
sed -i "77i uci set network.lan.dns=127.0.0.1" package/lean/default-settings/files/zzz-default-settings  # 默认上游 DNS 地址  OK
sed -i "78i uci set network.wan.proto=none" package/lean/default-settings/files/zzz-default-settings # 关掉wan   
sed -i "79i uci set wireless.@wifi-device[0].disabled=1" package/lean/default-settings/files/zzz-default-settings # 关闭无线0   OK
sed -i "80i uci set wireless.@wifi-device[1].disabled=1" package/lean/default-settings/files/zzz-default-settings # 关闭无线1   OK
sed -i "81i uci commit network" package/lean/default-settings/files/zzz-default-settings

sed -i "82i sed -i '/option ra_management '1'/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "83i sed -i '/option dhcpv6 'server'/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings
sed -i "84i sed -i '/option ra 'server'/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings
sed -i "85i uci set dhcp.lan.ignore=1" package/lean/default-settings/files/zzz-default-settings # 关掉lan的dhcp忽略此接口打勾   OK
sed -i "86i uci commit dhcp" package/lean/default-settings/files/zzz-default-settings

sed -i "87i sed -i '165,170d' /etc/config/firewall" package/lean/default-settings/files/zzz-default-settings
sed -i "88i sed -i '18,134d' /etc/config/firewall" package/lean/default-settings/files/zzz-default-settings
sed -i "89i sed -i '/option syn_flood '1'/d' /etc/config/firewall" package/lean/default-settings/files/zzz-default-settings
sed -i "90i sed -i '/option forward 'ACCEPT'/a\option masq '1'' /etc/config/firewall" package/lean/default-settings/files/zzz-default-settings

sed -i "91i echo 'bind-tls :853@eth0.1' >> /etc/smartdns/custom.conf
sed -i "92i echo 'force-qtype-SOA 28' >> /etc/smartdns/custom.conf

# sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate
sed -i "s/OpenWrt /Wing build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings  OK
# sed -i "/firewall\.user/d" package/lean/default-settings/files/zzz-default-settings
