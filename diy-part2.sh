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

# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
# sed -i 's/OpenWrt/OpenWrt-R619AC/g' ./package/base-files/files/bin/config_generate

# echo "修改wifi名称"
# sed -i "s/OpenWrt/$wifi_name/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' ./package/lean/default-settings/files/zzz-default-settings

sed -i "s/OpenWrt /Wing build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
sed -i '6i uci set system.@system[0].hostname=NeoBird' package/lean/default-settings/files/zzz-default-settings
# sed -i "/firewall\.user/d" package/lean/default-settings/files/zzz-default-settings
sed -i "42i echo 'iptables -t nat -I POSTROUTING -o eth0.1 -j MASQUERADE' >> /etc/firewall.user" package/lean/default-settings/files/zzz-default-settings
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate
# sed -i "64i chmod 0755 /etc/smartdns/up.sh" package/lean/default-settings/files/zzz-default-settings
sed -i "65i sed -i '/option type/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings
sed -i "66i uci set network.lan.ifname=eth0.1" package/lean/default-settings/files/zzz-default-settings
sed -i "67i sed -i '/option ip6assign/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings
sed -i "68i uci set network.lan.gateway=192.168.1.1" package/lean/default-settings/files/zzz-default-settings
sed -i "69i uci set network.lan.dns=127.0.0.1" package/lean/default-settings/files/zzz-default-settings
sed -i "70i uci set network.lan.delegate=0" package/lean/default-settings/files/zzz-default-settings
sed -i "71i uci commit network" package/lean/default-settings/files/zzz-default-settings
sed -i "72i sed -i '/option ra_management/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings
sed -i "73i sed -i '/option dhcpv6/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings
sed -i "74i sed -i '/option ra/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings
sed -i "75i uci set dhcp.lan.ignore=1" package/lean/default-settings/files/zzz-default-settings
sed -i "76i sed -i 's/8192/0/g' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings
sed -i "77i uci commit dhcp" package/lean/default-settings/files/zzz-default-settings
sed -i "78i uci set wireless.@wifi-device[0].disabled=1" package/lean/default-settings/files/zzz-default-settings
sed -i "79i uci set wireless.@wifi-device[1].disabled=1" package/lean/default-settings/files/zzz-default-settings
