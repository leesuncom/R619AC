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
git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
git clone https://github.com/kenzok8/small.git package/small
rm -rf package/openwrt-packages/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/openwrt-packages/luci-theme-argon
# git clone https://github.com/open-mesh-mirror/batman-adv.git package/batman-adv
# rm -rf package/openwrt-packages/luci-app-adguardhome && git clone https://github.com/OldCoding/luci-app-adguardhome.git package/openwrt-packages/luci-app-adguardhome
# rm -rf package/lean/luci-app-netdata && git clone https://github.com/sirpdboy/luci-app-netdata.git package/openwrt-packages/luci-app-netdata
