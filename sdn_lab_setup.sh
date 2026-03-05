#!/bin/bash
set -e

echo "=== SDN LAB SETUP STARTING ==="

# Update
sudo apt-get update

# Core build + networking tools
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  git build-essential libffi-dev libssl-dev \
  libxml2-dev libxslt1-dev pkg-config \
  software-properties-common ca-certificates \
  curl gnupg lsb-release \
  bridge-utils iproute2 iputils-ping net-tools tcpdump tmux

# Install Open vSwitch
sudo apt-get install -y openvswitch-switch
sudo systemctl enable --now openvswitch-switch

# Install Docker
sudo apt-get install -y docker.io
sudo systemctl enable --now docker

sudo groupadd -f docker
sudo usermod -aG docker $USER

# Install Python 3.9
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install -y python3.9 python3.9-venv python3.9-dev python3.9-distutils

# Create virtual environment
python3.9 -m venv /opt/ryu-py39
source /opt/ryu-py39/bin/activate

# Pin compatible toolchain
pip install --upgrade "pip<24" "setuptools<58" "wheel<0.40"

# Ryu dependencies
pip install eventlet==0.31.1 greenlet==1.1.3 dnspython==1.16.0 pyyaml

# Install Ryu
pip install git+https://github.com/osrg/ryu.git

echo "=== SDN LAB SETUP COMPLETE ==="
