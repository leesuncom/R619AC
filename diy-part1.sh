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
sed -i '$a src-git helloworld https://github.com/fw876/helloworld.git' feeds.conf.default
# git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
# git clone https://github.com/kenzok8/small-package package/small-package
# git clone https://github.com/kenzok8/small.git package/small

# Add theme
rm -rf package/lean/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
# git clone https://github.com/jerrykuku/luci-app-argon-config.git package/lean/luci-app-argon-config
rm -rf package/lean/luci-theme-design && git clone https://github.com/gngpp/luci-theme-design.git package/lean/luci-theme-design
git clone https://github.com/gngpp/luci-app-design-config.git package/lean/luci-app-design-config
rm -rf package/lean/luci-theme-neobird && git clone https://github.com/thinktip/luci-theme-neobird.git package/lean/luci-theme-neobird

# Add app
git clone https://github.com/open-mesh-mirror/batman-adv.git package/batman-adv
# git clone -b lede https://github.com/pymumu/luci-app-smartdns package/lean/luci-app-smartdns
svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-app-smartdns package/lean/luci-app-smartdns
# svn export https://github.com/immortalwrt/packages/trunk/net/smartdns
svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-app-adguardhome package/lean/luci-app-adguardhome
svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-diskman
