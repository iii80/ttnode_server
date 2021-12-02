#开始前的说明
sleep 1s
read -p "
======================================================================================
当前脚本只适用于  “armbian/alpine（x86）/玩客云原系统root”  安装甜糖服务

若确认无误，请按Enter键继续操作，脚本运行中，如果选错选项也可通过Ctrl+C中断脚本运行
======================================================================================


请按Enter键继续操作：" beforestart


echo "

正在下载甜糖服务文件，请稍等。。。

";

rm -f ./ttnode.zip;
rm -rf ./ttnode;
sleep 2s
wget https://gitee.com/zhang0510/ttnode_server/attach_files/900237/download/ttnode.zip
unzip ttnode.zip


#选择安装甜糖的arm版本
sleep 1s;
choose='ture';
while [ $choose == 'ture' ] ;do
read -p "
请输入要安装甜糖服务的系统版本：

1.n1、玩客云、我家云、r3300l等armbian系统，请输入1（默认）

2.alpine(x86)系统,请输入2

3.玩客云原系统root

请输入数字1-3（默认为1）：" startchoose
if [[ ${startchoose} == 1 || ${startchoose} == '' ]];then
sleep 1s;
choose='false';
chmod 755 ./ttnode/arm/tt_run.sh;
./ttnode/arm/tt_run.sh;
elif [[ ${armtype} == 2 ]];then
sleep 1s;
choose='false';
chmod 755 ./ttnode/alpine/tt_run.sh;
./ttnode/alpine/tt_run.sh;
elif [[ ${armtype} == 3 ]];then
sleep 1s;
choose='false';
chmod 755 ./ttnode/wky/tt_run.sh;
./ttnode/wky/tt_run.sh;
else
echo "

输入错误，5s后请重新选择，或按ctrl+c退出安装命令
";
sleep 5s;
fi
done

echo "

正在清理缓存文件，请勿中断程序，脚本将在10s自动退出

";
rm -f ./ttnode.zip;
rm -rf ./ttnode;
rm -f ./tt_start.sh;
sleep 10s;
exit 0