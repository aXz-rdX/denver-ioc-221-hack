#!/bin/sh

# include config
. ./config.txt

# mount copied config dir
mkdir -p /tmp/config
cp -pfr /mnt/config/* /tmp/config
mount --bind /tmp/config /mnt/config

## Mount /etc/ files from microSD card
# env
mount --bind ./hack/etc/profile /etc/profile
# users and groups
mount --bind ./hack/etc/group /etc/group
mount --bind ./hack/etc/passwd /etc/passwd
mount --bind ./hack/etc/shadow /etc/shadow
# update hosts file to prevent communication
if [ "$HACK_CLOUD" = "YES" ]; then
    mount --bind ./hack/etc/hosts /etc/hosts
fi

# Wi-Fi Settings
#if [ "$HACK_WIFI" = "YES" ]; then
#    echo "[cls_server]" > cls.conf
#    echo "ssid = $WIFI_SSID" >> cls.conf
#    echo "passwd = $WIFI_PASSWORD" >> cls.conf
#fi

## Servers

# Busybox httpd
if [ "$HACK_HTTPD" = "YES" ]; then
    busybox httpd -p 8080 -h ./hack/www
fi

# SSH Server - user root with no password required
if [ "$HACK_SSH" = "YES" ]; then
    ./hack/dropbearmulti dropbear -r ./hack/dropbear_ecdsa_host_key -B
fi

# FTP Server
if [ "$HACK_FTP" = "YES" ]; then
    (busybox tcpsvd -E 0.0.0.0 21 busybox ftpd -w / ) &
fi

# ONVIF
if [ "$HACK_ONVIF" = "YES" ]; then
    sed -i "s/\"onvif_switch\":0/\"onvif_switch\":1/" /mnt/config/system.cfg
fi

# Custom files
#for f in "./*"
#do
#  echo "Processing $f file..."
#  cat "$f"
#done

# Sync time with gateway ntp server
( sleep 20 && busybox ntpd -q -p `ip route show default | awk '/default/ {print $3}'` ) &
