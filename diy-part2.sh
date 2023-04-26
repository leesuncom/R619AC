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
sed -i "2i # network config" ./package/lean/default-settings/files/zzz-default-settings
sed -i "3i uci set network.lan.ipaddr=192.168.1.2" package/lean/default-settings/files/zzz-default-settings # 默认IP地址，旁路由时不会和主路由的 192.168.1.1 冲突
sed -i "4i uci set network.lan.proto=static" package/lean/default-settings/files/zzz-default-settings # 静态 IP
sed -i "5i uci set network.lan.type=bridge" package/lean/default-settings/files/zzz-default-settings  # 接口类型：桥接
sed -i "6i uci set network.lan.ifname=eth0.1" package/lean/default-settings/files/zzz-default-settings  # 网络端口：默认 eth0.1，第一个接口
sed -i "7i uci set network.lan.netmask=255.255.255.0" package/lean/default-settings/files/zzz-default-settings    # 子网掩码
sed -i "8i uci set network.lan.gateway=192.168.1.1" package/lean/default-settings/files/zzz-default-settings  # 默认网关地址（主路由 IP）
sed -i "9i uci set network.lan.dns=127.0.0.1" package/lean/default-settings/files/zzz-default-settings  # 默认上游 DNS 地址
sed -i "10i uci set network.wan.proto=none" package/lean/default-settings/files/zzz-default-settings # 关掉wan   
sed -i "11i uci set wireless.@wifi-device[0].disabled=1" package/lean/default-settings/files/zzz-default-settings # 关闭无线
sed -i "12i uci commit network" package/lean/default-settings/files/zzz-default-settings
sed -i "13i uci set dhcp.lan.ignore=1" package/lean/default-settings/files/zzz-default-settings # 关掉lan的dhcp
sed -i "14i uci commit dhcp" package/lean/default-settings/files/zzz-default-settings 
sed -i "15i iptables -t nat -I POSTROUTING -o eth0.1 -j MASQUERADE" package/lean/default-settings/files/zzz-default-settings # 关闭lan口的桥接所有数据的源IP都转换eth0.1这个接口的IP然后转发出去
# sed '6 iuci\ set\ system.@system[0].hostname=NeoBird' -i package/lean/default-settings/files/zzz-default-settings
# sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate
sed -i "s/OpenWrt /Wing build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
sed -i "/firewall\.user/d" package/lean/default-settings/files/zzz-default-settings
