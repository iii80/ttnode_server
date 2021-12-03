#!/bin/sh
sleep 20s
# mount /dev/mmcblk0p1 /media/mmcblk0p1
while [ ture ] ;do
d=`date '+%F %T'`;
num=`ps fax | grep '/ttnode' | egrep -v 'grep|echo|rpm|moni|guard' | wc -l`;
if [ $num -lt 1 ];then
 echo "[$d] ttnode is dead...restarting" >> /usr/node/log.log ;
 echo "[$d] ttnode is dead...restarting";
 mount -o,remount,rw /dev/mmcblk0p1 /media/mmcblk0p1
 /usr/node/ttnode -p /media/mmcblk0p1 -i /usr/node/uid.txt;
fi
sleep 60s
done
