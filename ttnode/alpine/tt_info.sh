#sleep 60s
/usr/node/ttnode -p /mnts -i /usr/node/uid.txt
echo "

20秒后将自动获取甜糖信息
";
sleep 20s;
netstat -nlp |grep ttnode|grep -Ev '127.0|tcp6|17331' |awk '{print $1,$4}' |sed 's/0.0.0.0://' > /usr/node/port.txt;

num2=$(sed -n '$=' /usr/node/port.txt);
while [ "$num2" -lt 5 ];do
echo "

正在获取甜糖端口号信息，若长时间未能成功获取端口号，可按ctrl+c退出"
sleep 30s;
netstat -nlp |grep ttnode|grep -Ev '127.0|tcp6|17331' |awk '{print $1,$4}' |sed 's/0.0.0.0://' > /usr/node/port.txt;
num2=$(sed -n '$=' /usr/node/port.txt);
done
echo "

端口号信息如下，如需使用端口映射，请在路由器中映射下列端口；若下面显示空白，可在脚本执行完后一分钟以后执行命令/root/tt_info.sh再次获取端口号，若无需求可忽略"
cat /usr/node/port.txt;
echo "

甜糖服务的UID如下，若无法在甜糖app中搜索到设备，可在甜糖app中扫码绑定；此后执行命令/root/tt_info.sh即可获得UID及二维码信息"
cat /usr/node/uid.txt | qrencode -m 1 -o - -t ANSI256;
cat /usr/node/uid.txt;
echo "

======================================================================================================
";
exit 0