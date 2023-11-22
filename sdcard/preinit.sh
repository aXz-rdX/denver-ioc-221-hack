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
    cp -pf /media/hack.sh /mnt/hacksd
    cp -pf /media/config.txt /mnt/hacksd
    cp -pfr /media/hack /mnt/hacksd

    #hook before start.sh
    startscript="/mnt/config/start_denver.sh"
    if [ ! -f "$startscript" ];then
        cp -pf /mnt/config/start.sh $startscript
    fi

    cp -f /media/hook.sh /mnt/config/start.sh
fi

cd /opt/httpServer/lighttpd/htdocs/sd
./hack.sh

#run cam app like /mnt/config/start.sh did
/mnt/app/camapp &

sleep 1