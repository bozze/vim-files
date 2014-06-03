vim-files
=========

Installation
------------
You may need to remove existing `~/.vimrc` file and `~/.vim/` folder

    cd ~
    git clone git@github.com:bozze/vim-files.git .vim
    ln -s .vim/vimrc .vimrc
    cd ~/.vim/
    git submodule update --init --recursive

Adding Vim plugins
------------------
    cd ~/.vim/
    git submodule add CLONE_URL bundle/PLUGIN_NAME

Upgrading
---------
### Main repo
    git pull origin master
    
### A specific plugin
    cd ~/.vim/bundle/<plugin-name>
    git pull origin master

### All plugins
    cd ~/.vim/
    git submodule update --init --recursive
