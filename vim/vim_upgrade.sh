#!/usr/bin/env sh

# vim install

sudo yum install -y make gcc ncurses-devel
if [ ! -d "/usr/local/src" ]; then
	sudo mkdir -p /usr/local/src
fi
sudo git clone https://github.com/vim/vim.git /usr/local/src/vim
sudo sh -c 'cd /usr/local/src/vim && ./configure \
  --disable-selinux \
  --enable-cscope \
  --enable-fontset \
  --enable-gpm \
  --enable-multibyte \
  --enable-rubyinterp \
  --enable-xim
make &&
make install'
