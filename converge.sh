#!/bin/bash

sudo apt install -y unzip jq virtualenv build-essential python3-dev
sudo apt install python-pip || true
sudo apt install python3-pip || true


test provisioningenv || virtualenv provisioningenv --python=python3
. provisioningenv/bin/activate
pip install -r provisioning-requirements.txt

molecule converge -s lxd-pab