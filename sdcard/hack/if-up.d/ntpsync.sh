#!/bin/sh

( sleep 2 && busybox ntpd -q -p `ip route show default | awk '/default/ {print $3}'` ) &