#!/bin/sh

# mount sd card to separate location
if [ -b /dev/mmcblk0p1 ]; then
	mount /dev/mmcblk0p1 /media
elif [ -b /dev/mmcblk0 ]; then
	mount /dev/mmcblk0 /media
fi

# include config
. /media/config.txt

if [ "$PERSISTENT" = "YES" ]; then
    #backup /mnt to sd
    mkdir -p /media/backup
    tar -cpzf "/media/backup/mnt_config_$(date '+%Y-%m-%d').tar.gz" /mnt/config/*

    #copy hash.sh to /mnt
    mkdir -p /mnt/hacksd
    rm -R /mnt/hacksd/*
    cp -pf /media/hack.sh /mnt/hacksd
    cp -pf /media/config.txt /mnt/hacksd
    cp -pfr /media/hack /mnt/hacksd

    #hook before clearCached.sh
    startscript="/mnt/config/clearCached_denver.sh"
    if [ ! -f "$startscript" ];then
        cp -pf /mnt/config/clearCached.sh $startscript
    fi

    cp -f /media/hook.sh /mnt/config/clearCached.sh

    #give default user right to edit this script if it fails
    chmod 777 /mnt/config/clearCached.sh
    chown 1000:default /mnt/config/clearCached.sh
fi

cd /opt/httpServer/lighttpd/htdocs/sd
./hack.sh
