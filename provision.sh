#!/usr/bin/env bash

if [ -f "/var/vagrant_provision" ]; then
	exit 0
fi

export NODE_VERSION="0.10.26"
export GIT_VERSION="1.9.1"

touch /var/vagrant_provision

# Provisioning
echo "[Vagrant provisioning]"

echo ".. Updating & upgrading index"
apt-get update >/dev/null
apt-get upgrade >/dev/null
echo ".. Installing make"
apt-get install -y make >/dev/null
echo ".. Installing g++"
apt-get install -y g++ >/dev/null

echo ".. Downloading node"
wget "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.gz" >/dev/null 2>&1
echo ".. Extracting node"
tar -xzf "node-v$NODE_VERSION.tar.gz" >/dev/null
cd "./node-v$NODE_VERSION" >/dev/null
echo ".. Making node"
./configure >/dev/null
make >/dev/null
make install >/dev/null
cd ../
echo ".. Cleanup after making node"
rm "node-v$NODE_VERSION.tar.gz" >/dev/null
rm -rf "node-v$NODE_VERSION" >/dev/null
echo "The node version installed: " & node -v

echo ".. Installing git"
echo ".. Downloading git dependencies"
apt-get install -y curl expat gettext openssl zlib1g-dev >/dev/null
echo ".. Downloading git"
wget "https://www.kernel.org/pub/software/scm/git/git-$GIT_VERSION.tar.gz" >/dev/null
echo ".. Extracting git"
tar -xzf "git-$GIT_VERSION.tar.gz" >/dev/null
cd "./git-$GIT_VERSION" >/dev/null
echo ".. Making git"
./configure >/dev/null
make prefix=/usr all >/dev/null
make prefix=/usr install >/dev/null
cd ../
echo ".. Cleanup after making git"
rm "git-$GIT_VERSION.tar.gz" >/dev/null
rm -rf "git-$GIT_VERSION" >/dev/null
echo "The git version installed: " & git --version

echo ".. Installing mocha globally"
npm install -g mocha
echo ".. Installing coffeescript globally"
npm install -g coffeescript
