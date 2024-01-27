#!/bin/sh

/mnt/config/clearCached_denver.sh

#only start persistent hack if no sd card is present
preinit="/opt/httpServer/lighttpd/htdocs/sd/preinit.sh"
if [ ! -f "$preinit" ];then
    cd /mnt/hacksd
    ./hack.sh

    #run cam app like /mnt/config/start.sh did
    /mnt/app/camapp &

    sleep 1
fi
