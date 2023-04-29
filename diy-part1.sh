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

# Add app
ls
cd openwrt/package
mkdir openwrt-packages
cd openwrt-packages
git clone -b lede https://github.com/pymumu/luci-app-smartdns
svn export https://github.com/leesuncom/packages/trunk/net/smartdns
# svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-app-smartdns package/lean/luci-app-smartdns
# svn export https://github.com/kenzok8/openwrt-packages/trunk/smartdns package/lean/smartdns
# svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-app-adguardhome package/lean/luci-app-adguardhome
# Add theme
rm -rf package/lean/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
git clone https://github.com/jerrykuku/luci-app-argon-config.git
git clone https://github.com/thinktip/luci-theme-neobird.git
