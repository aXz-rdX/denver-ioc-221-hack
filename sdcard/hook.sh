#!/bin/sh

/mnt/config/clearCached_denver.sh

#only start persistent hack if no sd card is present
preinit="/opt/httpServer/lighttpd/htdocs/sd/preinit.sh"
if [ ! -f "$preinit" ];then
    cd /mnt/hacksd
    ./hack.sh
fi
