#!/bin.sh

#Check OS
if [ -f /etc/redhat-release ];then
        OS='CentOS'
    elif [ ! -z "`cat /etc/issue | grep bian`" ];then
        OS='Debian'
    elif [ ! -z "`cat /etc/issue | grep Ubuntu`" ];then
        OS='Ubuntu'
    else
        echo "暂不支持您的系统。"
        exit 1
fi

#install 
if OS='CentOS'
	yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	yum install sslh
else 
apt-get install sslh
fi

#Configure Server-port
read -t 60 -p "请输入本机的IP地"your_ip
echo -e "\n"
echo "IP为：$your_ip"
cat << EOF > config
listen:
(
    { host: "$your_ip"; port: "443"; }
);
EOF

rm /etc/sslh.cfg
cat << EOF > /etc/sslh.cfg
listen:
(
    { host: "$your_ip"; port: "443"; }
);
EOF

service sslh restart
clear

echo '配置完成'
