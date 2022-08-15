#!/bin/sh

BASE_DIR=`pwd`
TODAY=`date +%Y%m%d%H%M%S`


install_mac_os() {
    # 安装 Homebrew
    if [ ! `which brew` ]
    then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    # GNU coreutils
    brew install coreutils
    # iterm2 上传/下载文件 see https://github.com/mmastrac/iterm2-zmodem
    brew install lrzsz
    # Google Chrome Start script
    ln -sf $BASE_DIR/scripts/chrome_osx.sh /usr/local/bin/chrome
}

install_ubuntu() {
    sudo apt-get update 2>> err.log
    # git
    sudo apt-get install -y git 2>> err.log
    sudo apt-get install -y zsh tmux 2>> err.log
    # Ruby Dev
    sudo apt-get install -y ruby-dev 2>> err.log
}

install_ubuntu_gui() {
    # 安装GVim terminator
    sudo apt-get install -y vim-gnome terminator 2>> err.log
    # 关闭Ubuntu错误报告
    sudo sed -i 's/enabled=1/enabled=0/' /etc/default/apport
    sudo service apport restart
    # 修改中文字体为 文泉驿-微米黑
    sudo apt-get install -y ttf-wqy-microhei 2>> err.log
    sudo ln -sf $BASE_DIR/ubuntu-gui/system/69-language-selector-zh-cn.conf /etc/fonts/conf.d/69-language-selector-zh-cn.conf
}

install_fedora() {
    sudo yum install vim
}

install_dependence() {
    if [ `uname` = "Darwin" ] # Mac OS X
    then
        install_mac_os
    elif [ `which apt-get` ]
    then
        install_ubuntu
    elif [ `which yum` ]
    then
        intall_fedora
    fi
}

# 配置Zsh
setup_zsh() {
    echo "\033[034m* 配置zsh...\033[0m"
    for i in $HOME/.zshrc $HOME/.oh-my-zsh $HOME/.dir_colors
    do [ -L $i ] && unlink $i
    done
    for i in $HOME/.zshrc $HOME/.oh-my-zsh $HOME/.dir_colors
    do [ -e $i ] && mv $i $i.$TODAY
    done
    ln -s $BASE_DIR/terminal/zsh/zshrc $HOME/.zshrc
    ln -s $BASE_DIR/terminal/zsh/oh-my-zsh $HOME/.oh-my-zsh
    ln -s $BASE_DIR/terminal/zsh/dircolors.ansi-dark $HOME/.dir_colors
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

# 配置tmux
setup_tmux() {
    echo "\033[034m* 配置tmux...\033[0m"
    if [ -L $HOME/.tmux.conf ];then
        unlink $HOME/.tmux.conf
    elif [ -f $HOME/.tmux.conf ];then
        mv $HOME/.tmux.conf $HOME/.tmux.conf.$TODAY
    fi
    ln -s $BASE_DIR/terminal/tmux.conf $HOME/.tmux.conf
}

# 配置git
setup_git() {
    echo "\033[034m* 配置Git...\033[0m"
    if [ -L $HOME/.gitconfig ];then
        unlink $HOME/.gitconfig
    elif [ -f $HOME/.gitconfig ];then
        mv $HOME/.gitconfig $HOME/.gitconfig.$TODAY
    fi
    ln -s $BASE_DIR/terminal/gitconfig $HOME/.gitconfig
}

# 配置vim
setup_vim() {
    cd vim
    sh install.sh
}

# 基本的终端环境配置
setup_terminal() {
    setup_zsh
    setup_tmux
    setup_git
    setup_vim
}

setup_ubuntu_gui() {
    #安装字体文件
    echo "\033[034m* 正在安装字体...\033[0m"
    mkdir -p $HOME/.fonts
    ln -fs $BASE_DIR/ubuntu-gui/fonts/* $HOME/.fonts/
    fc-cache -vf #刷新系统字体缓存

    #建立terminator配置链接
    mkdir -p $HOME/.config/terminator
    echo "\033[034m* 配置terminator...\033[0m"
    mkdir -p $HOME/.config/terminator
    if [ -L $HOME/.config/terminator/config ];then
        unlink $HOME/.config/terminator/config
    elif [ -f $HOME/.config/terminator/config ];then
        mv $HOME/.config/terminator/config $HOME/.config/terminator/config.$TODAY
    fi
    ln -s $BASE_DIR/ubuntu-gui/terminator/config $HOME/.config/terminator/config
}

link_others() {
    # jshintrc
    if [ -L $HOME/.jshintrc ];then
        unlink $HOME/.jshintrc
    elif [ -f $HOME/.jshintrc ];then
        mv $HOME/.jshintrc $HOME/.jshintrc.$TODAY
    fi
    ln -s $BASE_DIR/dotrc/jshintrc $HOME/.jshintrc

    for i in $HOME/.jshintrc $HOME/.npmrc
    do [ -L $i ] && unlink $i || [ -f $i ] && mv $i $i.$TODAY
    done

    ln -s $BASE_DIR/dotrc/jshintrc $HOME/.jshintrc
    ln -s $BASE_DIR/dotrc/npmrc $HOME/.npmrc

}

############################## Setup Start ######################################

if [ "$1" = "--with-gui" ] && [ `which apt-get` ]; then
    install_ubuntu_gui
    setup_ubuntu_gui
elif [ "$1" = "--with-gui" ];then
    echo "\033[33m Sorry, Can't setup GUI environment on your operating system!\033[0m"
elif [ "$1" ]; then
    echo "Try '\033[33msh install.sh --with-gui\033[0m' to setup ubuntu GUI environment."
fi

install_dependence
link_others
setup_terminal

echo "\033[034m* Last Step : Change your login shell to zsh.\033[0m"
chsh -s "/bin/zsh"

echo "\033[034m* Configure completed, just enjoy!\033[0m"

################################ Setup End ######################################
