#!/usr/bin/env sh

# git install

sudo yum remove -y git
sudo yum install -y curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel autoconf asciidoc xmlto docbook2X make gcc wget
sudo ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi
if [ ! -d "/usr/local/src" ]; then
	sudo mkdir -p /usr/local/src
fi
sudo sh -c 'cd /usr/local/src &&
wget https://www.kernel.org/pub/software/scm/git/git-2.30.0.tar.gz &&
tar -zxvf git-2.30.0.tar.gz &&
cd git-2.30.0 &&
make prefix=/usr/local all &&
make prefix=/usr/local install &&
cd .. &&
rm -rf git-2.30.0 &&
rm -f git-2.30.0.tar.gz'
