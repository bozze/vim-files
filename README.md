vim-files
=========

Installation
------------
You may need to remove existing `~/.vimrc` file and `~/.vim/` folder

    cd ~
    git clone git@github.com:bozze/vim-files.git .vim
    ln -s .vim/vimrc .vimrc
    cd ~/.vim
    git submodule init
    git submodule update

Upgrading
---------
### Main repo
    git pull origin master
    
### A specific plugin
    cd ~/.vim/bundle/<plugin-name>
    git pull origin master

### All plugins
    cd ~/.vim
    git submodule foreach git pull origin master
