sleep 1s;
choose='ture';
while [ $choose == 'ture' ] ;do
clear;
read -p "

=========================================================================================================

在虚拟机中使用alpine安装甜糖服务时，初次挂载硬盘、调整硬盘后、更换硬盘都要对硬盘进行重新分区及格式化，请按照提示
选择是否格式化,若多次初始化硬盘不成功，请重启系统或检查硬盘是否已经挂载！！！

1.不对硬盘进行格式化，请输入1

2.对硬盘进行格式化，请输入2

=========================================================================================================

请输入数字1-2：" formatchoose

if [[ ${formatchoose} == 1 || ${formatchoose} == '' ]];then
sleep 1s;
choose='false';
sleep 1s;

elif [[ ${formatchoose} == 2 ]];then
sleep 1s;
echo "

硬盘正在格式化，请稍等。。。

"
sleep 1s;
if grep -qs '/dev/sda1' /proc/mounts; then

#/dev/sda1被挂载，将判断/dev/sdb1是被挂载
sleep 1s;
if grep -qs '/dev/sdb1' /proc/mounts; then
sleep 1s;
echo "

未发现可以被格式化的硬盘，10s后将自动返回格式化硬盘界面

"
sleep 10s;

#/dev/sdb1未被挂载，将进行格式化
else
echo "n

p

1

 

 

w

"|fdisk -u /dev/sdb;
mkfs.ext4 /dev/sdb1;
sleep 1s;
choose='false';
echo "

格式化完成，脚本将会在10s后继续执行，请稍等

"
sleep 10s;
fi
#/dev/sda1未被挂载，将进行格式化
else
echo "n

p

1

 

 

w

"|fdisk -u /dev/sda;
mkfs.ext4 /dev/sda1;
sleep 1s;
choose='false';
echo "

格式化完成，脚本将会在10s后继续执行，请稍等

"
sleep 10s;
fi

else
echo "

输入错误，5s后请重新选择，或按ctrl+c退出安装命令
";
sleep 5s;
fi
done
exit 0