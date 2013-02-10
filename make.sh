#!/bin/bash
########################################
# makeshit.sh
# This script makes shit
########################################

#################### Variables

dir=~/dotfiles
olddir=~/dotfiles_old
files="ackrc gitconfig gvimrc.after vimrc.before vimrc.after zshrc"

####################

# If you don't have MacVim:
# brew install macvim
#
# Then install Janus using the automatic installer:

curl -Lo- https://bit.ly/janus-bootstrap | bash

# Then install oh-my-zsh:

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

# Backup old dotfiles and create new symlinks
mkdir -p $olddir
cd $dir

for file in $files; do
  mv ~/.$file ~/$olddir/
  ln -s $dir/$file ~/.$file
done

# oh-my-zsh custom shit
rm -f ~/.oh-my-zsh/custom/example.zsh
ln -s $dir/example.zsh ~/.oh-my-zsh/custom/example.zsh
