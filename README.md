# Read Me

这是一份包含vim、coc、ctags以及tmux的配置文件夹

以用户家目录为根目录，按照文件夹中的文件排放方法将所有的文件拷贝进家目录中即可完成配置文件的更改。

## vim-plug

在安装配置文件时需要使用vim-plug插件作为vim的插件管理器，vim下安装方法为

```shell
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

neovim下安装方法为

```shell
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

- 如上述代码失效，可以使用.config/nvim/plug.vim文件，将其放入$HOME/.local/share/nvim/site/autoload目录中

## 其他插件安装

打开`.vimrc`或是`.config/nvim/init.vim`文件，在命令行中输入`:PlugInstall`即可自动完成所有插件的安装。

## coc

下载安装coc插件之前请确保node已经被正常安装成功，建议使用v14.0以上的node，否则可能出现markdown-previewer插件的问题，可以直接到官网上安装，并解压将整个目录放置到`/usr/local/lib/`下，并建立`/bin/`目录下的软链接。

coc插件的安装是在插件安装的过程中自动完成的，但是coc插件中的插件需要安装完所有vim插件以后再进行安装的。在安装完所有插件后，退出.vimrc文件，重新进入后，coc插件会自动启动安装。等待即可完成。

如果出现安装问题，将npm源改成淘宝镜像，单次使用可以通过`npm install --registry=https://registry.npm.taobao.org`，永久使用通过命令`npm config set registry https://registry.npm.taobao.org`，源文件修改在`$HOME/.npmrc`中。

## coc-settings

coc-settings是用来配置coc插件中的插件的配置文件，详细内容可以通过GitHub主页查看，repo的拥有者为neoclide，还有一些插件我没有安装。

## ctags

ctags需要系统软件支持，Debian系中通过`sudo apt install ctags`即可简易安装，完毕后通过ctags命令可以生成标签文件，结合tagbar插件可以查看到目标文件中的所有标签符号

## tmux

tmux需要安装tmux软件，通过`sudo apt install tmux`即可实现安装，此配置文件对于窗口的管理和vim一致，可以通过Ctrl+b前缀，结合hjkl进行窗口切换；使用Ctrl+b前缀和Ctrl+vh进行窗口的竖直、水平的拆分
