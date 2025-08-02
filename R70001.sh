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

# Uncomment a feed source
cd openwrt
sed -i '$a src-git smpackage https://github.com/kenzok8/small-package' >>feeds.conf.default
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
rm -rf feeds/luci/applications/luci-app-openclash
cp -f feeds/smpackage/.github/diy/default-settings package/lean/default-settings/files/zzz-default-settings
cp -f feeds/smpackage/.github/diy/banner package/base-files/files/etc/banner
#cp -f feeds/smpackage/.github/diy/index_x86.htm package/lean/autocore/files/x86/index.htm
sed -i "s/%D %V, %C/openwrt $(date +'%m.%d') by kenzo/g" package/base-files/files/etc/banner
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#echo 'src-git istore https://github.com/linkease/istore;main' >>feeds.conf.default
#echo 'src-git weifuture https://github.com/hongweifuture/openwrt-packages' >>feeds.conf.default
#echo 'src-git pwdep https://github.com/hongweifuture/pwdep.git' >>feeds.conf.default
