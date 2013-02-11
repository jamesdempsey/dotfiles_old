#!/bin/bash
########################################
# bootstrap.sh
# This script makes shit
########################################

#################### Variables

dir=~/dotfiles
olddir=~/dotfiles_old
files="ackrc gitconfig gvimrc.after vimrc.before vimrc.after zshrc"

####################

# If you don't have MacVim:
#
# brew install macvim
#
# And you should also probably install iTerm2, dunno if there's way to
# brew install that shit..
#
# If you don't have Janus, then install it using the automatic installer:

if [ ! -d ~/.vim/janus ]
then
  curl -Lo- https://bit.ly/janus-bootstrap | bash
else
  cd ~/.vim
  rake
fi

# If you also don't have oh-my-zsh..

if [ ! -d ~/.oh-my-zsh/ ]
then
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

# Backup old dotfiles and create new symlinks

mkdir -p $olddir
cd $dir

for file in $files; do
  mv ~/.$file ~/dotfiles_old/
  ln -s $dir/$file ~/.$file
done

# oh-my-zsh custom shit
rm -f ~/.oh-my-zsh/custom/example.zsh
ln -s $dir/example.zsh ~/.oh-my-zsh/custom/example.zsh

# font shit
cp -i $dir/DinaMedium.dfont ~/Library/Fonts/

# iterm2 shit
cp -i $dir/com.googlecode.iterm2.plist ~/Library/Preferences/
