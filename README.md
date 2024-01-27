# Hack for Denver Cloud IP Cameras (GK7102)

This hack is based on (https://github.com/dc35956/gk7102-hack)


## Working on the following camera models

* Denver IOC-221
* other models not tested yet

## Features

* Changes login credentials to ```user: root password: cxlinux```
* Blocking cloud hosts
* Enable ONVIF Server
* BusyBox FTP Server
* dropbear SSH Server: root can login ssh without password
* Wi-Fi configuration without cloud account

## Installation

* Download the hack
* Copy contents of folder ```sdcard``` to the main directory of a vfat/fat32 formatted microSD card
* Change options in ```config.txt```
* Insert microSD card into camera and reboot the device
* Enjoy

## Security

The security of these devices is terrible.
* DO NOT expose these cameras to the internet.
* For this hack, config.txt is used to decide what servers you want to run.
* This hack is blocking the communication with the cloud providers.
* DO NOT expose these cameras to the internet.


## Instructions

### Default Credentials
```
   IP                Port     Service     Username     Password     
   ------            ----     -------     --------     --------     
   x.x.x.x           23       telnet      root         cxlinux
```

### RTSP Connection

* rtsp://admin:@x.x.x.x:554/11
* rtsp://admin:@192.168.200.1:554/0/av0 (with audio)
* rtsp://admin:@192.168.200.1:554/0/av1 (low quality)
* rtsp://admin:@192.168.200.1:8001
* rtsp://admin:@192.168.200.1:8001/0/av0 (with audio)
* rtsp://admin:@192.168.200.1:8001/0/av1 (low quality)

### ONVIF Connection

* http://admin:admin@x.x.x.x:80

### Debug Scripts and Files

By default, the startup script ```/mnt/config/start.sh``` will try to load and run some commands.

### Date and time

Camera loses the date and time setting when it loses power. The time is updated from the connected gateway after 20 seconds.

## Device Details

### Product

Denver Electronics IOC-221 Outdoorkamera 
Brand: Denver
Model: IOC-221

[Denver IOC-221](https://denver.eu/products/smart-home-security/ip-camera-/outdoor/denver-ioc-221/c-1024/c-1246/p-4103)

### Software Versions
```
$ uname -a
Linux goke 3.4.43-gk #49 PREEMPT Fri Mar 5 16:51:24 CST 2021 armv6l GNU/Linux

$ busybox
BusyBox v1.21.0 (2015-10-10 11:17:34 CST) multi-call binary.
```

### Open ports
```
[root@goke:~]# netstat -tulpn
netstat: showing only processes with your user ID
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:554             0.0.0.0:*               LISTEN      177/camapp
tcp        0      0 0.0.0.0:6668            0.0.0.0:*               LISTEN      177/camapp
tcp        0      0 0.0.0.0:7101            0.0.0.0:*               LISTEN      177/camapp
tcp        0      0 0.0.0.0:7103            0.0.0.0:*               LISTEN      177/camapp
tcp        0      0 :::23                   :::*                    LISTEN      96/telnetd
udp        0      0 192.168.2.224:46663     0.0.0.0:*                           177/camapp
```

### Processor
```
[root@goke:~]# cat /proc/cpuinfo
Processor       : ARMv6-compatible processor rev 7 (v6l)
BogoMIPS        : 597.60
Features        : swp half fastmult vfp edsp java tls
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xb76
CPU revision    : 7

Hardware        : Goke IPC Board
Revision        : 0000
Serial          : 0000000000000000
```

### Memory
```
[root@goke:~]# cat /proc/meminfo
MemTotal:          37632 kB
MemFree:            3652 kB
Buffers:            2116 kB
Cached:             9644 kB
SwapCached:            0 kB
Active:            12852 kB
Inactive:           9340 kB
Active(anon):      10712 kB
Inactive(anon):      720 kB
Active(file):       2140 kB
Inactive(file):     8620 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 8 kB
Writeback:             0 kB
AnonPages:         10448 kB
Mapped:              972 kB
Shmem:              1000 kB
Slab:               8096 kB
SReclaimable:        700 kB
SUnreclaim:         7396 kB
KernelStack:         544 kB
PageTables:          412 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:       18816 kB
Committed_AS:      79216 kB
VmallocTotal:    2031616 kB
VmallocUsed:       56124 kB
VmallocChunk:     997204 kB
```

### /etc/passwd
```
[root@goke:~]# cat /etc/shadow
root:$1$JYFTech$dt2mZnCIdoFSWAog1s.T41:10933:0:99999:7:::
bin:*:10933:0:99999:7:::
daemon:*:10933:0:99999:7:::
adm:*:10933:0:99999:7:::
lp:*:10933:0:99999:7:::
sync:*:10933:0:99999:7:::
shutdown:*:10933:0:99999:7:::
halt:*:10933:0:99999:7:::
uucp:*:10933:0:99999:7:::
operator:*:10933:0:99999:7:::
ftp:*:10933:0:99999:7:::
nobody:*:10933:0:99999:7:::
default::10933:0:99999:7:::
```