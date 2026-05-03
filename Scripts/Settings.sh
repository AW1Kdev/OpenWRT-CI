#!/bin/bash

[ -z "$WRT_IP" ] && { echo "WRT_IP kosong!"; exit 1; }

echo "Set LAN IP: $WRT_IP"

FLASH=$(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js" 2>/dev/null)
[ -n "$FLASH" ] && sed -i "s/192\.168\.1\.1/$WRT_IP/g" "$FLASH"

CFG="./package/base-files/files/bin/config_generate"
[ -f "$CFG" ] && sed -i "s/ipaddr='192\.168\.1\.1'/ipaddr='$WRT_IP'/g" "$CFG"

NET="./files/etc/config/network"
if [ -f "$NET" ]; then
  sed -i "/config interface 'lan'/,/config interface/ s/192\.168\.1\.1/$WRT_IP/" "$NET"
fi

echo "Done"
