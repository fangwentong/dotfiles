My dotfiles
---

###关于

此仓库存放的是一些linux常用的配置文件，
通过软链接建立与系统配置文件的联系（系统的相关配置文件通过软链接指向该仓库中的文件).
如 `~/.vimrc` ->  `repo_path/vim/vimrc`.

通过一个仓库管理这些配置文件的优势主要有：

- 借助编写的shell脚本，可实现系统配置的快速部署.
- 修改系统配置文件后，这些更改能直接反应到git工作目录中，借助git，可以高效地管理这些更改.
- 依托GitHub等平台，实现配置备份与共享.


###配置列表

1. `zsh`配置

    借助 [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) 配置zsh

2. `tmux`配置

    修改任务栏显示内容、快捷键等.

3. `vim` 配置
    参见[fangwentong/vimrc](https://github.com/fangwentong/vimrc)

###安装

1. clone本仓库到本地

    ```
    git clone https://github.com/fangwentong/dotfiles.git
    ```

2. 更新子模块

    ```
    cd dotfiles
    git submodule update --init
    ```

3. 解决依赖关系并开始安装

    ```
    sh Dependence && sh install.sh
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
