#!/bin.sh

# 判断使用哪种包管理器并安装 sslh
if [ -n "$(command -v yum)" ]; then
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm sslh || { echo "安装 sslh 失败！请查看错误信息。"; exit 1; }
elif [ -n "$(command -v apt-get)" ]; then
    apt update
    apt install -y sslh || { echo "安装 sslh 失败！请查看错误信息。"; exit 1; }
else
    echo "yum 和 apt 都不可用，放弃安装！"
  exit 1
fi

# 获取本机IP
my_ip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')

# 修改 sslh 配置文件的IP，如果成功则应用新设置
[ -e /etc/sslh.cfg ] && sed -i "s/thelonious/$my_ip/g" /etc/sslh.cfg && service sslh restart
[ -e /etc/default/sslh ] && sed -i "s/<change-me>/$my_ip/g;s/RUN=no/RUN=yes/g" /etc/default/sslh && service sslh restart

echo '配置完成'
