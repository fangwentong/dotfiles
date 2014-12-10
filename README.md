My dotfiles
---

###关于

此仓库存放的是一些linux常用的配置文件，
通过软链接建立与系统配置文件的联系（系统的相关配置文件通过软链接指向该仓库中的文件).
如 `~/.vimrc` ->  `repo_path/vim/vimrc`.

当前分支为 **OS X** 分支， Ubuntu配置另见 [Ubuntu](https://github.com/fangwentong/dotfiles/tree/ubuntu) 分支.

通过一个仓库管理这些配置文件的优势主要有：

- 借助编写的shell脚本，可实现系统配置的快速部署.
- 修改系统配置文件后，这些更改能直接反应到git工作目录中，借助git，可以高效地管理这些更改.
- 依托GitHub等平台，实现配置备份与共享.



###mac配置列表

1. `zsh`配置

    借助 [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) 配置zsh

2. `tmux`配置

    修改任务栏显示内容、快捷键等.

3. `vim` 配置

    原型来自 [wklken/k-vim](https://github.com/wklken/k-vim) ,经过自己多次整理，得到现有的vim配置.

    快捷键说明

        1. 上排F功能键

            F1 废弃这个键,防止调出系统帮助
            F2 set nu/nonu,行号开关，用于鼠标复制代码用
            F3 set list/nolist,显示可打印字符开关
            F4 set wrap/nowrap,换行开关
            F5 compilerun() 编译/运行

        2. 分屏移动

            ctrl + jkhl 进行上下左右窗口跳转,不需要ctrl+w+jkhl

        3. buffer/tab相关

            , + tn  新tab
            , + to  tabonly
            , + tc  close
            , + tm  tab move
            , + te  new tab edit

        4. 按键修改

            U      =  ctrl-r   redo
            , + sa =  ggVG  全选
            H      =  0  移动光标至行首
            L      =  $  移动光标至行尾
            Y      =  y$ 复制到行尾

    插件配置文件为 `vim/vimrc.bundle` ,可以的参考`wklken/k-vim`的
    [插件介绍](https://github.com/wklken/k-vim/blob/master/README.md#%E6%8F%92%E4%BB%B6%E9%83%A8%E5%88%86).


###安装

1. clone本仓库到本地

    ```
    git clone https://github.com/fangwentong/dotfiles.git
    ```

2. 安装依赖的包

    ```
    # mac
    brew install ctags

    #使用python需要
    sudo pip install pyflakes
    sudo pip install pylint
    sudo pip install pep8
    ```

3. 更新子模块并开始安装

    ```
    cd dotfiles
    git checkout -t origin/mac
    git submodule update --init
    sh -x install.sh
    ```

4. 安装会持续一段时间，保持网络畅通，耐心等待

5. 安装完成后，修改部分信息，得到自己的配置
  - 修改git/gitconfig中的邮箱和用户名

    ```
    git config --global user.name "你的名字"
    git config --glabal user.email "你的邮箱"
    ```

###更多

获取`dotfiles`的更多信息，可以访问[http://dotfiles.github.io/](http://dotfiles.github.io/)
