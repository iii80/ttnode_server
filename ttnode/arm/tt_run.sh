#开始前的说明
sleep 1s
clear;
read -p "

======================================================================================
你选择的当前脚本只适用于  “armbian系统（包含玩客云原固件root）”  安装甜糖服务，若选错了
按Ctrl+C即可结束安装

若确认无误，请按Enter键继续操作，脚本运行中，如果选错选项也可通过Ctrl+C中断脚本运行
======================================================================================


请按Enter键继续操作：" beforestart


echo "

======================================================================================
脚本运行中，请稍等。。。
======================================================================================

";


#选择安装甜糖的arm版本

sleep 1s;
choose='ture';
while [ $choose == 'ture' ] ;do
    read -p "

    ======================================================================================
    请输入要安装的arm版：

    1.n1、我家云、r3300l、微加云、私家云、贝壳云等64位盒子armbian，请输入1（默认）

    2.玩客云等32位盒子armbian，请输入2

    3.玩客云原系统root版，非三方固件，请输入2
    ======================================================================================

    请输入数字1~3（默认为1）：" armtype
    if [[ ${armtype} == 1 || ${armtype} == '' ]];then
        choose='false';
        rm -rf /usr/node
        mv ./ttnode/armbian/node /usr/;
        mv ./ttnode/armbian/arm64/* /usr/node;
    elif [[ ${armtype} == 2 ]];then
        choose='false';
        rm -rf /usr/node
        mv ./ttnode/armbian/node /usr/;
        mv ./ttnode/armbian/arm32/* /usr/node;
    elif [[ ${armtype} == 3 ]];then
        choose='false';
        #删除原本可能存在的残余文件
        sleep 2s
        rm -rf /usr/node;
        rm -f /etc/init.d/S98ttnode
        rm -f /root/tt_info.sh

        #将相关文件移入系统
        sleep 2s
        mv ./ttnode/armbian/node /usr/;  #移入甜糖程序
        mv ./ttnode/armbian/arm32/* /usr/node;
        sleep 1s;
        rm -f /usr/node/crash_monitor.sh
        rm -f /usr/node/mount.sh
        sleep 1s;
        chmod 777 -R /usr/node;  #赋予权限
        sleep 1s;
        mv ./ttnode/armbian/wky/S98ttnode /etc/init.d #移入开机启动甜糖脚本
        chmod 755 /etc/init.d/S98ttnode

        #创建甜糖缓存目录
        sleep 2s;
        mkdir /mnts;
        sleep 2s;

        #选择存储介质
        choosemount='ture';
        while [ $choosemount == 'ture' ] ;do
            read -p "
            ===========================================================
            选择您用于甜糖缓存的存储介质:

            1.U盘、硬盘等使用usb接口的存储介质，请输入1（默认）

            2.SD卡，请输入2
            ===========================================================
            请输入数字1或2（默认为1）：" storagetype
            if [[ ${storagetype} == 1 || ${storagetype} == '' ]];then
                choosemount='false';
                mv ./ttnode/armbian/wky/monitor1/crash_monitor.sh /usr/node;
                chmod 777 -R /usr/node;
                sleep 1s;
                mv ./ttnode/armbian/wky/monitor1/tt_info.sh /root/; #移入获取信息脚本
                sleep 1s;
                chmod 755 /root/tt_info.sh; #赋予权限
            elif [[ ${storagetype} == 2 ]];then
                choosemount='false';
                mv ./ttnode/armbian/wky/monitor2/crash_monitor.sh /usr/node;
                chmod 777 -R /usr/node;
                sleep 1s;
                mv ./ttnode/armbian/wky/monitor2/tt_info.sh /root/; #移入获取信息脚本
                sleep 1s;
                chmod 755 /root/tt_info.sh; #赋予权限
            else
                echo "
                    ======================================================
                    输入错误，5s后请重新选择，或按ctrl+c退出安装命令
                    ======================================================
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
    else
        echo "

        ======================================================================================
        输入错误，5s后请重新选择，或按ctrl+c退出安装命令
        ======================================================================================

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
mv ./ttnode/armbian/tt_info.sh /root/;
sleep 1s;
chmod 777 /root/tt_info.sh;
sleep 1s;
mkdir /etc/ttcrontab #定时任务
sleep 1s;
mv ./ttnode/armbian/root /etc/ttcrontab;
sleep 1s;
crontab /etc/ttcrontab/root;
sleep 1s;
chmod 600 /etc/ttcrontab/root;

echo "

======================================================================================
正在尝试挂载硬盘，请稍等。。。
======================================================================================

";
#自动挂载的硬盘
/usr/node/mount.sh;

#启动甜糖
sleep 5s;
echo "

======================================================================================
正在启动甜糖程序，请耐心等待
======================================================================================

";

#获取端口号
sleep 5s;
echo "

======================================================================================
甜糖启动成功，正在获取二维码及端口信息，请耐心等侯
======================================================================================

";

/root/tt_info.sh;
sleep 2s;
echo "

======================================================================================
第一次获取甜糖信息可能会出现信息不全，可在脚本运行完成后，手动输入/root/tt_info.sh再次获取
甜糖二维码(若无法显示显示二维码，请手动执行apt update;apt install -y qrencode;安装二维码
工具)及端口信息
======================================================================================

";

echo "

======================================================================================
安装结束，10秒后将自动退出脚本，如获取到的甜糖二维码及端口信息不全，请ssh手动
输入/root/tt_info.sh
======================================================================================

";
sleep 10s
exit 0