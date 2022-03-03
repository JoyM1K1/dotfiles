#!/usr/bin/env sh

# vim install

yum install -y make gcc ncurses-devel
if [ ! -d "/usr/local/src" ]; then
	mkdir -p /usr/local/src
fi
git clone https://github.com/vim/vim.git /usr/local/src/vim
sh -c 'cd /usr/local/src/vim && ./configure \
  --disable-selinux \
  --enable-cscope \
  --enable-fontset \
  --enable-gpm \
  --enable-multibyte \
  --enable-rubyinterp \
  --enable-xim
make &&
make install'
