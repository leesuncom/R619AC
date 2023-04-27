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
sed -i "46i echo 'iptables -t nat -I POSTROUTING -o eth0.1 -j MASQUERADE' >> /etc/firewall.user" package/lean/default-settings/files/zzz-default-settings # 关闭lan口的桥接所有数据的源IP都转换eth0.1这个接口的IP然后转发出去
sed -i "62i # network config" package/lean/default-settings/files/zzz-default-settings
sed -i "63i uci set network.lan.ipaddr=192.168.1.2" package/lean/default-settings/files/zzz-default-settings # 默认IP地址，旁路由时不会和主路由的 192.168.1.1 冲突
sed -i "64i uci set network.lan.proto=static" package/lean/default-settings/files/zzz-default-settings # 静态 IP
# sed -i "65i uci set network.lan.type=bridge" package/lean/default-settings/files/zzz-default-settings  # 接口类型：桥接
sed -i "65i sed '/option type/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # 接口类型：关闭桥接
sed -i "66i sed '/option ip6assign/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "67i sed '/config interface 'lan'/a\option delegate '0'' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # 使用内置的 IPv6 管理，去掉勾

sed -i "68i sed '/config interface 'wan'/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "69i sed '/option ifname 'eth0.2'/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "70i sed '/option proto 'none'/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "71i sed '/config interface 'wan6'/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "72i sed '/option ifname 'eth0.2'/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "73i sed '/option proto 'dhcpv6'/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用




sed -i "74i uci set network.lan.ifname=eth0.1" package/lean/default-settings/files/zzz-default-settings  # 网络端口：默认 eth0.1，第一个接口
sed -i "75i uci set network.lan.netmask=255.255.255.0" package/lean/default-settings/files/zzz-default-settings    # 子网掩码
sed -i "76i uci set network.lan.gateway=192.168.1.1" package/lean/default-settings/files/zzz-default-settings  # 默认网关地址（主路由 IP）
sed -i "77i uci set network.lan.dns=127.0.0.1" package/lean/default-settings/files/zzz-default-settings  # 默认上游 DNS 地址
sed -i "78i uci set network.wan.proto=none" package/lean/default-settings/files/zzz-default-settings # 关掉wan   
sed -i "79i uci set wireless.@wifi-device[0].disabled=1" package/lean/default-settings/files/zzz-default-settings # 关闭无线0
sed -i "80i uci set wireless.@wifi-device[1].disabled=1" package/lean/default-settings/files/zzz-default-settings # 关闭无线1
sed -i "81i uci commit network" package/lean/default-settings/files/zzz-default-settings

sed -i "82i sed '/option ra_management '1'/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings # IPv6 分配长度，已禁用
sed -i "83i uci set dhcp.lan.ignore=1" package/lean/default-settings/files/zzz-default-settings # 关掉lan的dhcp
sed -i "84i uci commit dhcp" package/lean/default-settings/files/zzz-default-settings

# sed '6 iuci\ set\ system.@system[0].hostname=NeoBird' -i package/lean/default-settings/files/zzz-default-settings
# sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate
sed -i "s/OpenWrt /Wing build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
# sed -i "/firewall\.user/d" package/lean/default-settings/files/zzz-default-settings
