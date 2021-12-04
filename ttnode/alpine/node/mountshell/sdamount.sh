if grep -qs '/dev/sda1' /proc/mounts; then
echo "/dev/sda1 is mounted"
/usr/node/mountshell/sdbmount.sh
else 
mount /dev/sda1 /mnts;
if grep -qs '/mnts' /proc/mounts; then
echo "/mnts is mounted"
else
/usr/node/mountshell/sdbmount.sh
fi
fi