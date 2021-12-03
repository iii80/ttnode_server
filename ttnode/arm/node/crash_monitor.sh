#!/bin/bash
sleep 5s;
d=`date '+%F %T'`;
num=`ps fax | grep '/ttnode' | egrep -v 'grep|echo|rpm|moni|guard' | wc -l`;
echo $num;
if [ $num -lt 1 ];then
 echo "[$d] ttnode is dead...restarting" >> /usr/node/log.log ;
 echo "[$d] ttnode is dead...restarting";
 /usr/node/ttnode -p /mnts  -i /usr/node/uid.txt;
fi