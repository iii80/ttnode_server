if grep -qs '/dev/mmcblk0p1' /proc/mounts; then
echo "/dev/mmcblk0p1 is mounted"
/usr/node/mountshell/mmcblk1mount.sh
else 
mount /dev/mmcblk0p1 /mnts;
if grep -qs '/mnts' /proc/mounts; then
echo "/mnts is mounted"
else
/usr/node/mountshell/mmcblk1mount.sh
fi
fi