#!/bin/bash
########################################
# bootstrap.sh
########################################

#################### Variables

dir=~/dotfiles
olddir=~/dotfiles_old
files="slate.js vimrc vim zshrc"

####################

# Backup old dotfiles and create new symlinks
mkdir -p $olddir
cd $dir

for file in $files; do
  mv ~/.$file ~/dotfiles_old/
  ln -s $dir/$file ~/.$file
done

# Install vundle bundles
mkdir ~/.vim/autoload
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall

# Best font
cp -i $dir/DinaMedium.dfont ~/Library/Fonts/

# iTerm2 color presets
open $dir/kolo-herald.itermcolors

# Change shell to zsh
chsh -s zsh
