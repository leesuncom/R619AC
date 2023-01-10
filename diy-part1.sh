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
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/lean/luci-app-argon-config
git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
git clone https://github.com/kenzok8/small.git package/small
# git clone https://github.com/open-mesh-mirror/batman-adv.git package/batman-adv
cd package/openwrt-packages  
rm -rf luci-theme-argon  
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
# rm -rf luci-app-netdata
# git clone https://github.com/sirpdboy/luci-app-netdata.git
