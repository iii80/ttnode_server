#开始前的说明
sleep 1s
read -p "
======================================================================================
你选择的当前脚本只适用于  “玩客云原系统root”  后安装甜糖服务，若选错了按Ctrl+C即可结束安装

若确认无误，请按Enter键继续操作，脚本运行中，如果选错选项也可通过Ctrl+C中断脚本运行
======================================================================================


请按Enter键继续操作：" beforestart


echo "

脚本运行中，请稍等。。。

";

#删除原本可能存在的残余文件
sleep 2s
rm -rf /usr/node;
rm -f /etc/init.d/S98ttnode
rm -f /root/tt_info.sh

#将相关文件移入系统
sleep 2s
mv ./ttnode/wky/node /usr/;  #移入甜糖程序
sleep 1s;
chmod 777 -R /usr/node;  #赋予权限
sleep 1s;
mv ./ttnode/wky/S98ttnode /etc/init.d #移入开机启动甜糖脚本
chmod 755 /etc/init.d/S98ttnode

#创建甜糖缓存目录
sleep 2s;
mkdir /mnts;
sleep 2s;

#选择存储介质
choose='ture';
while [ $choose == 'ture' ] ;do
read -p "
选择您用于甜糖缓存的存储介质:

1.U盘、硬盘等使用usb接口的存储介质，请输入1（默认）

2.SD卡，请输入2

请输入数字1或2（默认为1）：" storagetype
if [[ ${storagetype} == 1 || ${storagetype} == '' ]];then
choose='false';
mv ./ttnode/wky/monitor1/crash_monitor.sh /usr/node;
chmod 777 -R /usr/node;
sleep 1s;
mv ./ttnode/wky/monitor1/tt_info.sh /root/; #移入获取信息脚本
sleep 1s;
chmod 777 /root/tt_info.sh; #赋予权限
elif [[ ${storagetype} == 2 ]];then
choose='false';
mv ./ttnode/wky/monitor2/crash_monitor.sh /usr/node;
chmod 777 -R /usr/node;
sleep 1s;
mv ./ttnode/wky/monitor2/tt_info.sh /root/; #移入获取信息脚本
sleep 1s;
chmod 777 /root/tt_info.sh; #赋予权限
else
echo "

输入错误，5s后请重新选择，或按ctrl+c退出安装命令
";
sleep 5s;
fi
done

#启动甜糖服务
echo "

正在启动甜糖服务，请耐心等待
";
sleep 10s;
/root/tt_info.sh;
sleep 2s;
exit 0