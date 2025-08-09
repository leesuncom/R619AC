#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# echo "src-git helloworld https://github.com/fw876/helloworld.git" >> "feeds.conf.default"
# replace luci-theme-argon to lastest update
rm -rf feeds/kenzo/luci-theme-argon feeds/kenzo/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/applications/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/applications/luci-app-argon-config

# replace MOSdns to lastest update
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/utils/v2dat
# rm -rf feeds/packages/net/v2ray-geodata
# git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
# git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# replace smartdns to lastest update
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,sing*,smartdns}
rm -rf feeds/luci/applications/luci-app-smartdns
git clone https://github.com/pymumu/openwrt-smartdns feeds/packages/net/smartdns
sed -i 's/1.2024.45/1.2024.46.0.13/g' feeds/packages/net/smartdns/Makefile
git clone https://github.com/pymumu/luci-app-smartdns feeds/luci/applications/luci-app-smartdns
sed -i 's/1.2024.45/1.2024.46/g' feeds/luci/applications/luci-app-smartdns/Makefile

# goland 2.1 to golang 2.2
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# miniupnpd 2.3.7 to 2.1.20200510
#rm -fr feeds/packages/net/miniupnpd
#git clone --filter=blob:none --no-checkout https://github.com/openwrt/packages miniupnpd-tmp
#cd miniupnpd-tmp
#git sparse-checkout init --cone
#git sparse-checkout set net/miniupnpd
#git checkout openwrt-18.06
#cp -r net/miniupnpd ../feeds/packages/net/
#cd ..
#rm -fr miniupnpd-tmp
