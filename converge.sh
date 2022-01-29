#!/bin/bash

sudo apt install -y unzip jq virtualenv build-essential python3-dev
sudo apt install python-pip || true
sudo apt install python3-pip || true


test provisioningenv || virtualenv provisioningenv --python=python3
. provisioningenv/bin/activate
pip install -r provisioning-requirements.txt

molecule converge -s lxd-pab

while true; do
    read -p "Do you wish to build cardano node with testnet support [yes/no] ? " yn
    case $yn in
        [Yy]* ) molecule converge -s lxd-pab -- --tags=with_cardano_node; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
