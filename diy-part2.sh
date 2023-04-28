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
sed -i "17i sed -i '/option type/d' /etc/config/network" package/lean/default-settings/files/zzz-default-settings
sed -i "18i uci set network.lan.ifname=eth0.1" package/lean/default-settings/files/zzz-default-settings
sed -i "19i uci set network.lan.netmask=255.255.255.0" package/lean/default-settings/files/zzz-default-settings
sed -i "20i uci set network.lan.gateway=192.168.1.1" package/lean/default-settings/files/zzz-default-settings
sed -i "21i uci set network.lan.dns=127.0.0.1" package/lean/default-settings/files/zzz-default-settings 
sed -i "22i uci commit network" package/lean/default-settings/files/zzz-default-settings

sed -i '5i uci set system.@system[0].hostname=NeoBird' package/lean/default-settings/files/zzz-default-settings 
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate
sed -i "s/OpenWrt /Wing build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
sed -i "46i echo 'iptables -t nat -I POSTROUTING -o eth0.1 -j MASQUERADE' >> /etc/firewall.user" package/lean/default-settings/files/zzz-default-settings
#sed -i "/firewall\.user/d" package/lean/default-settings/files/zzz-default-settings
