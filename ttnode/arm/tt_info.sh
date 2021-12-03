#sleep 60s
echo "

正在获取甜糖信息中，请稍等。。。
";
/usr/node/ttnode -p /mnts -i /usr/node/uid.txt
sleep 20s;
netstat -nlp |grep ttnode|grep -Ev '127.0|tcp6|17331' |awk '{print $1,$4}' |sed 's/0.0.0.0://' > /usr/node/port.txt;

echo "

成功获取二维码信息，请使用甜糖app扫描下方二维码进行绑定(若无法显示显示二维码，请手动执行apt update;apt install -y qrencode;安装二维码工具)

"
cat /usr/node/uid.txt | qrencode -m 1 -o - -t ANSI256;

num2=$(sed -n '$=' /usr/node/port.txt);
while [ "$num2" -lt 5 ];do
echo "

正在获取甜糖端口号信息，请先使用甜糖app扫描上方二维码(若无法显示显示二维码，请手动执行apt update;apt install -y qrencode;安装二维码工具)，若长时间未能成功获取端口号，可按ctrl+c退出"
sleep 30s;
netstat -nlp |grep ttnode|grep -Ev '127.0|tcp6|17331' |awk '{print $1,$4}' |sed 's/0.0.0.0://' > /usr/node/port.txt;
num2=$(sed -n '$=' /usr/node/port.txt);
done
echo "

成功获取端口号信息，请使用甜糖app扫描上方二维码绑定(若无法显示显示二维码，请手动执行apt update;apt install -y qrencode;安装二维码工具)，如需使用端口映射，请在路由器中映射下列端口"
cat /usr/node/port.txt
exit 0