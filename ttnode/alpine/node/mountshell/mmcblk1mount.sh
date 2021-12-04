if grep -qs '/dev/mmcblk1p1' /proc/mounts; then
echo "/dev/mmcblk1p1 is mounted"
/usr/node/mountshell/mmcblk2mount.sh
else 
mount /dev/mmcblk1p1 /mnts;
if grep -qs '/mnts' /proc/mounts; then
echo "/mnts is mounted"
else
/usr/node/mountshell/mmcblk2mount.sh
fi
fi