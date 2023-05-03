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

# Modify default IP

sed -i "19i sed -i '/option ip6assign/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings
sed -i "20i uci set network.lan.gateway=192.168.1.1" package/lean/default-settings/files/zzz-default-settings
sed -i "21i uci set network.lan.dns=127.0.0.1" package/lean/default-settings/files/zzz-default-settings
sed -i "22i uci commit network" package/lean/default-settings/files/zzz-default-settings

sed -i "23i sed -i '/option ra_management/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings
sed -i "24i sed -i '/option dhcpv6/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings
sed -i "25i sed -i '/option ra/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings
sed -i "26i uci set dhcp.lan.ignore=1" package/lean/default-settings/files/zzz-default-settings
sed -i "27i uci commit dhcp" package/lean/default-settings/files/zzz-default-settings

sed -i "28i uci set wireless.@wifi-device[0].disabled=1" package/lean/default-settings/files/zzz-default-settings
sed -i "29i uci set wireless.@wifi-device[1].disabled=1" package/lean/default-settings/files/zzz-default-settings

sed -i "30i chmod 755 /etc/smartdns/up.sh" package/lean/default-settings/files/zzz-default-settings

sed '10 iuci\ set\ system.@system[0].hostname=NeoBird' -i package/lean/default-settings/files/zzz-default-settings
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate
sed -i "s/OpenWrt /Wing build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
# sed -i "46i echo 'iptables -t nat -I POSTROUTING -o eth0.1 -j MASQUERADE' >> /etc/firewall.user" package/lean/default-settings/files/zzz-default-settings
sed -i "/firewall\.user/d" package/lean/default-settings/files/zzz-default-settings
