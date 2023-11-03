#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Add a feed source
sed -i '1i src-git haibo https://github.com/haiibo/openwrt-packages' feeds.conf.default

# Add app
# git clone -b lede https://github.com/pymumu/luci-app-smartdns package/lean/luci-app-smartdns
# svn export https://github.com/leesuncom/packages/trunk/net/smartdns package/lean/smartdns
rm -rf package/lean/luci-app-mosdns/luci-app-mosdns
rm -rf package/lean/luci-app-mosdns/mosdns
rm -rf package/lean/luci-app-mosdns/v2dat
# git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/lean/luci-app-mosdns
# rm -rf feeds/packages/net/v2ray-geodata && git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata package/lean/v2ray-geodata
# Add theme
# rm -rf feeds/luci/applications/luci-app-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
# rm -rf feeds/luci/applications/luci-app-argon-config && git clone https://github.com/jerrykuku/luci-app-argon-config.git package/lean/luci-app-argon-config
