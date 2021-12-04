if grep -qs '/dev/sdb1' /proc/mounts; then
echo "/dev/sdb1 is mounted"
/usr/node/mountshell/mmcblk0mount.sh
else 
mount /dev/sdb1 /mnts;
if grep -qs '/mnts' /proc/mounts; then
echo "/mnts is mounted"
else
/usr/node/mountshell/mmcblk0mount.sh
fi
fi