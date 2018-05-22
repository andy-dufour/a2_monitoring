#!/bin/bash

yum install git -y

curl -LO https://omnitruck.chef.io/install.sh && sudo bash ./install.sh -P chefdk && rm -f install.sh

mkdir /tmp/cookbooks

cd /tmp/cookbooks

git clone "https://github.com/andy-dufour/a2_monitoring.git"

chef-client --local-mode -r "a2_monitoring::default"
