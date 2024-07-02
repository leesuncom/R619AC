#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 发布固件名称添加日期
sed -i 's/^IMG_PREFIX\:\=.*/IMG_PREFIX:=$(VERSION_DIST_SANITIZED)-$(shell TZ=UTC-8 date +"%Y.%m.%d-%H%M")-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)$(BOARD)$(if $(SUBTARGET),-$(SUBTARGET))/g' include/image.mk
# sed -i 's/^IMG_PREFIX\:\=.*/IMG_PREFIX:=$(shell TZ=UTC-8 date +"%Y.%m.%d-%H%M")-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)$(BOARD)$(if $(SUBTARGET),-$(SUBTARGET))/g' include/image.mk

# 页面版本号添加日期
# sed -i "s/R[0-9]\+\.[0-9]\+\.[0-9]\+/&("$(date +%Y-%m-%d)")/g" package/lean/default-settings/files/zzz-default-settings
curl -sfL https://github.com/leesuncom/package/raw/main/99-default-settings-chinese -o package/emortal/default-settings/files/99-default-settings-chinese
curl -sfL https://github.com/leesuncom/R619AC/raw/master/patch/mosdns -o package/mosdns/luci-app-mosdns/root/etc/config/mosdns
curl -sfL https://github.com/leesuncom/R619AC/raw/master/patch/base.po -o feeds/luci/modules/luci-base/po/zh-cn/base.po

# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
# sed -i 's/ImmortalWrt/NeoBird/g' ./package/base-files/files/bin/config_generate

# 去除默认bootstrap主题
sed -i 's/[b|B]ootstrap/argon/g' ./feeds/luci/collections/luci/Makefile

# echo "修改wifi名称"
# sed -i "s/OpenWrt/$wifi_name/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate
# rm -rf feeds/kiddin9/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd*,miniupnpd-iptables,wireless-regdb}
# git clone https://github.com/sbwml/luci-app-mosdns -b v5 feeds/luci/applications/luci-app-mosdns

find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
