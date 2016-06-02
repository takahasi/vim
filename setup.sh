#!/bin/bash

mkdir -p ~/.vim/.swp
mkdir -p ~/.vim/.undo
mkdir -p ~/.vim/.backup

mkdir -p ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

