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

# 修改IP
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

# 发布固件名称添加日期
sed -i 's/^IMG_PREFIX\:\=.*/IMG_PREFIX:=$(VERSION_DIST_SANITIZED)-$(shell TZ=UTC-8 date +"%Y.%m.%d-%H%M")-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)$(BOARD)$(if $(SUBTARGET),-$(SUBTARGET))/g' include/image.mk
# sed -i 's/^IMG_PREFIX\:\=.*/IMG_PREFIX:=$(shell TZ=UTC-8 date +"%Y.%m.%d-%H%M")-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)$(BOARD)$(if $(SUBTARGET),-$(SUBTARGET))/g' include/image.mk

# 页面版本号添加日期
sed -i "s/R[0-9]\+\.[0-9]\+\.[0-9]\+/&("$(date +%Y-%m-%d)")/g" package/lean/default-settings/files/zzz-default-settings

# 添加自定义文件
curl -sfL https://github.com/leesuncom/R619AC/raw/master/patch/lede/zzz-default-settings -o package/lean/default-settings/files/zzz-default-settings
curl -sfL https://github.com/leesuncom/R619AC/raw/master/patch/mosdns -o feeds/luci/applications/luci-app-mosdns/root/etc/config/mosdns
curl -sfL https://github.com/leesuncom/R619AC/raw/master/patch/base.po -o feeds/luci/modules/luci-base/po/zh-cn/base.po

# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/OpenWrt/NeoBird/g' ./package/base-files/files/bin/config_generate

# 去除默认bootstrap主题
sed -i 's/[b|B]ootstrap/argon/g' ./feeds/luci/collections/luci/Makefile

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）

# small大佬常用OpenWrt软件包源码合集处理
# rm -rf ./feeds/packages/net/{alist,adguardhome,xray*,v2ray*,v2ray*,sing*,smartdns}
rm -rf ./feeds/smpackage/{PACKAGE_tor,luci-app-torbp,base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd-alt,miniupnpd-iptables,wireless-regdb,sms-tool,luci-app-sms-tool,luci-app-bypass,luci-app-passwall2,luci-app-bmtedge}

# Add Theme
rm -rf ./feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git ./feeds/luci/themes/luci-theme-argon
rm -rf ./feeds/luci/applications/luci-app-argon-config
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git ./package/lean/luci-app-argon-config

# 去掉不要插件
# rm -rf ./feeds/packages/net/{nlbwmon,udpxy}
# rm -rf ./feeds/luci/applications/{luci-app-nlbwmon,luci-app-wrtbwmon,luci-app-udpxy}
