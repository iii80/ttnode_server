mkdir /mnts
if grep -qs '/mnts' /proc/mounts; then
echo "/mnts is mounted"
else
/usr/node/mountshell/sdamount.sh
fi