#!/bin/bash

# create directories
mkdir -p ~/.vim/.swp
mkdir -p ~/.vim/.undo
mkdir -p ~/.vim/.backup
mkdir -p ~/.vim/bundle

# get neobundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
# get & set .vimrc
git clone https://github.com/takahasi/vim
ln -s vim/mac/.vimrc ~/.vimrc
