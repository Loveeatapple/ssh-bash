#!/bin.sh
# 判断使用哪种包管理器
if [ -n "$(command -v yum)" ]; then
    pkg_mgr='yum'
elif [ -n "$(command -v apt-get)" ]; then
    pkg_mgr='apt'
else
    echo "yum 和 apt 都不可用，放弃安装！"
  exit 1
fi

# 安装 sslh 顺便获取本机 IP
if [ "$pkg_mgr" == "yum" ]; then
    my_ip=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm sslh || { echo "安装 sslh 失败！请查看错误信息。"; exit 1; }
else
    my_ip=$(/sbin/ip -o -4 addr list ens3 | awk '{print $4}' | cut -d/ -f1)
    apt install -y sslh || { echo "安装 sslh 失败,请查看错误信息。"; exit 1; }
fi

# 修改 sslh 配置文件的IP
sed -i "s/thelonious/$my_ip/g" /etc/sslh.cfg

# 应用 sslh 的新设置
service sslh restart

echo '配置完成'
