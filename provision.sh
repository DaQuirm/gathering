#!/usr/bin/env bash

if [ -f "/var/vagrant_provision" ]; then
	exit 0
fi

touch /var/vagrant_provision


echo "[Vagrant provisioning]"

echo ".. Updating & upgrading index"
apt-get update >/dev/null
apt-get upgrade >/dev/null
echo ".. Installing make"
apt-get install -y make >/dev/null
echo ".. Installing g++"
apt-get install -y g++ >/dev/null

echo ".. Downloading node"
wget http://nodejs.org/dist/v0.10.26/node-v0.10.26.tar.gz >/dev/null 2>&1
echo ".. Extracting node"
tar -xzf node-v0.10.26.tar.gz >/dev/null
cd ./node-v0.10.26 >/dev/null
echo ".. Making node"
./configure >/dev/null
make >/dev/null
make install >/dev/null
cd ../
echo ".. Cleanup after making node"
rm -rf node-v0.10.26.tar.gz >/dev/null
echo "The node version installed: " & node -v