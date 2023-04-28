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

sed -i '5i uci set system.@system[0].hostname=NeoBird' package/lean/default-settings/files/zzz-default-settings 
sed -i "46i echo 'iptables -t nat -I POSTROUTING -o eth0.1 -j MASQUERADE' >> /etc/firewall.user" package/lean/default-settings/files/zzz-default-settings
sed -i "74i uci set network.lan.ifname=eth0.1" package/lean/default-settings/files/zzz-default-settings
sed -i "75i uci set network.lan.netmask=255.255.255.0" package/lean/default-settings/files/zzz-default-settings
sed -i "76i uci set network.lan.gateway=192.168.1.1" package/lean/default-settings/files/zzz-default-settings
sed -i "77i uci set network.lan.dns=127.0.0.1" package/lean/default-settings/files/zzz-default-settings
sed -i "78i uci set network.wan.proto=none" package/lean/default-settings/files/zzz-default-settings
sed -i "79i uci set wireless.@wifi-device[0].disabled=1" package/lean/default-settings/files/zzz-default-settings
sed -i "80i uci set wireless.@wifi-device[1].disabled=1" package/lean/default-settings/files/zzz-default-settings
sed -i "81i uci commit network" package/lean/default-settings/files/zzz-default-settings

sed -i "82i sed -i '/option ra_management 1/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings
sed -i "83i sed -i '/option dhcpv6 server/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings
sed -i "84i sed -i '/option ra server/d' /etc/config/dhcp" package/lean/default-settings/files/zzz-default-settings
# 关掉lan的dhcp忽略此接口打勾OK
sed -i "85i uci set dhcp.lan.ignore=1" package/lean/default-settings/files/zzz-default-settings
sed -i "86i uci commit dhcp" package/lean/default-settings/files/zzz-default-settings

sed -i "87i sed -i '165,170d' /etc/config/firewall" package/lean/default-settings/files/zzz-default-settings
sed -i "88i sed -i '18,134d' /etc/config/firewall" package/lean/default-settings/files/zzz-default-settings
sed -i "89i sed -i '/option syn_flood '1'/d' /etc/config/firewall" package/lean/default-settings/files/zzz-default-settings
sed -i "90i sed -i '/option forward 'ACCEPT'/a\option masq '1'' /etc/config/firewall" package/lean/default-settings/files/zzz-default-settings

sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate
sed -i "s/OpenWrt /Wing build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
# sed -i "/firewall\.user/d" package/lean/default-settings/files/zzz-default-settings
