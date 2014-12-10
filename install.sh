#!/bin/bash

BASE_DIR=`pwd`
TODAY=`date +%Y%m%d%H%M%S`

#建立zshrc链接
echo "配置zsh..."
for i in $HOME/.zshrc $HOME/.oh-my-zsh $HOME/.dir_colors
do [ -L $i ] && unlink $i
done
for i in $HOME/.zshrc $HOME/.oh-my-zsh $HOME/.dir_colors
do [ -e $i ] && mv $i $i.$TODAY
done

ln -s $BASE_DIR/terminal/zsh/zshrc $HOME/.zshrc
ln -s $BASE_DIR/terminal/zsh/oh-my-zsh $HOME/.oh-my-zsh
ln -s $BASE_DIR/terminal/zsh/dircolors.ansi-dark $HOME/.dir_colors

#建立tmux配置链接
echo "配置tmux..."
if [ -L $HOME/.tmux.conf ];then
    unlink $HOME/.tmux.conf
elif [ -f $HOME/.tmux.conf ];then
    mv $HOME/.tmux.conf $HOME/.tmux.conf.$TODAY
fi
ln -s $BASE_DIR/terminal/tmux.conf $HOME/.tmux.conf


#建立gitconfig链接
echo "配置Git..."
if [ -L $HOME/.gitconfig ];then
    unlink $HOME/.gitconfig
elif [ -f $HOME/.gitconfig ];then
    mv $HOME/.gitconfig $HOME/.gitconfig.$TODAY
fi
ln -s $BASE_DIR/terminal/gitconfig $HOME/.gitconfig

#配置vim
cd vim
sh -x Dependence
sh -x install.sh

echo "Config completed, just enjoy!"
