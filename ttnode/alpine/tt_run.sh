#开始前的说明
sleep 1s;
clear;
read -p "
======================================================================================

你选择的当前脚本只适用于  “X86的alpine系统”  后安装甜糖服务，若选错了按Ctrl+C即可结束安装


若确认无误，请按Enter键继续操作，脚本运行中，如果选错选项也可通过Ctrl+C中断脚本运行

======================================================================================


请按Enter键继续操作：" beforestart


echo "

======================================================================================

脚本运行中，请稍等。。。

======================================================================================

";

#删除可能存在的旧文件
sleep 1s;
rm -rf /usr/node;
rm -f /root/tt_info.sh;
rm -f /etc/crontabs/root;

#移入甜糖所需文件
sleep 1s;
mv ./ttnode/alpine/node /usr/;
sleep 1s;
chmod 777 -R /usr/node;
sleep 1s;
mv ./ttnode/alpine/tt_info.sh /root/;
sleep 1s;
chmod 755 /root/tt_info.sh;
sleep 1s;
mv ./ttnode/alpine/root /etc/crontabs; #移入定时文件
sleep 1s;
chmod 600 /etc/crontabs/root;
#sleep 1s;
#mv -f ./ttnode/alpine/mount.start /etc/local.d; #移入开机自动挂载硬盘
#sleep 1s;
#chmod 755 /etc/local.d/mount.start;
#sleep 1s;
#rc-update add local;

#初始化硬盘
/usr/node/automkfs.sh;


#安装相关应用
sleep 2s;
apk update;
sleep 2s;
apk add libstdc++;
sleep 2s;
apk add net-tools;
sleep 2s;
apk add libqrencode;
sleep 2s;
mkdir /mnts;
sleep 2s;
echo "

======================================================================================

正在尝试挂载硬盘，请稍等。。。

======================================================================================

";
/usr/node/mountshell/mount.sh;
sleep 1s;

#启动甜糖服务
clear;
echo "

======================================================================================

正在启动甜糖服务，请耐心等待

======================================================================================

";
sleep 10s;
/root/tt_info.sh;
sleep 2s;
exit 0