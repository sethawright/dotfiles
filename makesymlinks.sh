#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory

# list of files/folders to symlink in homedir
files="vim vimrc tmux.conf gvimrc gitconfig gitignore_global zshrc hammerspoon mutt muttrc"
themes="base16-materialdark.sh base16-materiallight.sh"
colorschemes="base16-materialdark.vim base16-materiallight.vim"
airlinethemes="base16_materialdark-airline.vim base16_materiallight-airline.vim"

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

for theme in $themes; do
    echo "Creating symlink to $theme in base16 shell."
    ln -s $dir/$theme ~/.config/base16-shell/scripts/$theme
done

for scheme in $colorschemes; do
    echo "Creating symlink to $scheme in vim colors."
    ln -s $dir/$scheme ~/.vim/colors/$scheme
done

for air in $airlinethemes; do
    airmod="${air//-airline}"
    echo "Creating symlink to $air in airline."
    ln -s $dir/$air ~/.vim/autoload/airline/themes/$airmod
done

# custom locations
