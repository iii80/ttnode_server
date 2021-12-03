#开始前的说明
sleep 1s
read -p "
======================================================================================
你选择的当前脚本只适用于  “armbian系统”  安装甜糖服务，若选错了按Ctrl+C即可结束安装

若确认无误，请按Enter键继续操作，脚本运行中，如果选错选项也可通过Ctrl+C中断脚本运行
======================================================================================


请按Enter键继续操作：" beforestart


echo "

脚本运行中，请稍等。。。

";


#选择安装甜糖的arm版本

sleep 1s;
choose='ture';
while [ $choose == 'ture' ] ;do
read -p "
请输入要安装的arm版：

1.n1、我家云、r3300l等64位盒子请输入1（默认）

2.玩客云等32位盒子请输入2

请输入数字1或2（默认为1）：" armtype
if [[ ${armtype} == 1 || ${armtype} == '' ]];then
choose='false';
rm -rf /usr/node
mv ./ttnode/arm/node /usr/;
mv ./ttnode/arm/arm64/ttnode /usr/node;
mv ./ttnode/arm/arm64/yfapp.conf /usr/node;
elif [[ ${armtype} == 2 ]];then
choose='false';
rm -rf /usr/node
mv ./ttnode/arm/node /usr/;
mv ./ttnode/arm/arm32/ttnode /usr/node;
mv ./ttnode/arm/arm32/yfapp.conf /usr/node;
else
echo "

输入错误，5s后请重新选择，或按ctrl+c退出安装命令
";
sleep 5s;
fi
done

#安装qrencode扫码工具
#sleep 2s;
#echo "

#正在安装qrencode扫码工具，请耐心等待
#";
#sleep 2s;
#apt install -y qrencode;

#赋予相关文件权限
sleep 1s;
mkdir /mnts;
sleep 1s;
chmod 777 -R /usr/node;
sleep 1s;
mv ./ttnode/arm/tt_info.sh /root/;
sleep 1s;
chmod 777 /root/tt_info.sh;
sleep 1s;
mkdir /etc/crontab #定时任务
sleep 1s;
mv ./ttnode/arm/root /etc/crontab;
sleep 1s;
crontab /etc/crontab/root;
sleep 1s;
chmod 600 /etc/crontab/root;

#选择挂载的硬盘
sleep 1s;
choose='ture';
while [ $choose == 'ture' ] ;do
read -p "
执行安装命令前请先通过lsblk或df -h确认挂载硬盘或内存卡的分区；若需要退出手动挂载，请按下Ctrl+c键退出:

1.将分区/dev/sda1挂载到/mnts，一般适用于挂载u盘/硬盘等使用usb接口的设备，请输入1（默认）

2.将分区/dev/mmcblk1p1挂载到/mnts，一般适用于挂载内存卡/SD卡，请输入2

3.将分区/dev/mmcblk2p1挂载到/mnts，一般适用于挂载内存卡/SD卡，请输入3

4.我已手动挂载，跳过此步骤，请输入4

请输入数字1-4（默认为1）：" mountstore
if [[ ${mountstore} == 1 || ${mountstore} == '' ]];then
sleep 1s;
umount /mnts;
mount /dev/sda1 /mnts;
sleep 1s;
choose='false';
rm -f /usr/node/crash_monitor.sh;
sleep 1s;
mv ./ttnode/arm/monitor1/crash_monitor.sh /usr/node/;

elif [[ ${mountstore} == 2 ]];then
sleep 1s;
umount /mnts;
mount /dev/mmcblk1p1 /mnts;
sleep 1s;
choose='false';
rm -f /usr/node/crash_monitor.sh;
sleep 1s;
mv ./ttnode/arm/monitor2/crash_monitor.sh /usr/node/;

elif [[ ${mountstore} == 3 ]];then
sleep 1s;
umount /mnts;
mount /dev/mmcblk2p1 /mnts;
sleep 1s;
choose='false';
rm -f /usr/node/crash_monitor.sh;
sleep 1s;
mv ./ttnode/arm/monitor3/crash_monitor.sh /usr/node/;
elif [[ ${mountstore} == 4 ]];then
sleep 1s;
choose='false';
else
echo "

输入错误，5s后请重新选择，或按ctrl+c退出安装命令
";
sleep 5s;
fi
done

sleep 1s;
chmod 755 /usr/node/crash_monitor.sh;

#启动甜糖
sleep 1s;
echo "

正在启动甜糖程序，请耐心等待
";

#获取端口号
sleep 5s;
echo "

甜糖启动成功，正在获取二维码及端口信息，请耐心等侯
";
/root/tt_info.sh;
sleep 2s;
echo "

第一次获取甜糖信息可能会出现信息不全，可在脚本运行完成后，手动输入/root/tt_info.sh再次获取甜糖二维码(若无法显示显示二维码，请手动执行apt update;apt install -y qrencode;安装二维码工具)及端口信息

";

echo "

安装结束，10秒后将自动退出脚本，如获取到的甜糖二维码及端口信息不全，请ssh手动输入/root/tt_info.sh
";
sleep 10s
exit 0