#!/usr/bin/env bash

# TODO: build_opencv(), build_pcl(), build_tensorflow() ...

# general
LIBS_DIR="${HOME}/libs"
mkdir -p "${LIBS_DIR}"

# my prefered directory structure
build_dir(){
    mkdir -p "${HOME}/libs"
    mkdir -p "${HOME}/Miscellaneous"
    mkdir -p "${HOME}/Repos"
}

# system
build_sys(){
    sudo apt update

    # default build-related tools
    sudo apt install git build-essential
    sudo apt install python-dev python3-dev
    sudo apt install checkinstall
    sudo apt install cmake-qt-gui
    sudo apt install ccache

    # pip
    curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
    python3 /tmp/get-pip.py

    # misc (but important?)
    sudo apt install openssh-client openssh-server
    sudo apt install dtrx # unified decompression interface 
    sudo apt install autojump
}

# python
build_py(){
    pip3 install -U pip
    pip3 install setuptools --user --upgrade
    pip3 install numpy --user --upgrade
    pip3 install scipy --user --upgrade # requires some deps? don't remember
    pip3 install sympy --user --upgrade
    pip3 install matplotlib --user --upgrade
}

# ROS
build_ros(){
    # configuration
    ROS_DISTRO=kinetic # TODO : upgrade myself to NOT-kinetic? ROS2?
    ROS_CI_DESKTOP="`lsb_release -cs`"  # e.g. [precise|trusty|...]

    sudo sh -c "echo \"deb http://packages.ros.org/ros/ubuntu $ROS_CI_DESKTOP main\" > /etc/apt/sources.list.d/ros-latest.list"
    sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
    sudo apt update -qq
    sudo apt install -y python-catkin-pkg python-catkin-tools python-rosdep python-wstool ros-$ROS_DISTRO-catkin -y

    if [ -d "${HOME}/catkin_ws" ]; then
        echo "Catkin Workspace Already Setup; Skipping."
    else
        # initialize workspace
        mkdir -p "${HOME}/catkin_ws/src"
        pushd "${HOME}/catkin_ws/src"
        catkin_init_workspace
        cd ../
        catkin build
        popd
    fi
}

# CUDA
build_cuda(){
    echo "[Me from the past] : Generic CUDA build is hopeless. Please figure it out yourself."
    # remember to build CUBLAS, CUDNN, etc.
}

# vim
build_vim(){
    # NOTE(ycho): Prior setup such as
    # sudo apt-get build-dep vim-gtk3
    # may be necessary for GUI support.
    # This step may fail without configuring
    # `sources` option in Ubuntu Software settings.

    # build vim from source
    pushd "${LIBS_DIR}"
    git clone https://github.com/vim/vim.git
    pushd vim
    ./configure --with-features=huge \
        --enable-pythoninterp=no \
        --with-python-config-dir="$(python2-config --configdir)" \
        --enable-python3interp=yes \
        --with-python3-config-dir="$(python3-config --configdir)" \
        --with-x=yes \
        --enable-fail-if-missing \
        --enable-gui=auto \
        --enable-cscope \
        --enable-terminal
    make -j8 VIMRUNTIMEDIR=/usr/local/share/vim/vim82
    sudo checkinstall 
    popd
    popd

    # vundle - plugins
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

    # youcompleteme : follow-up steps
    ~/.vim/bundle/YouCompleteMe/install.py --clangd-completer
}

build(){
    build_sys
    build_py
    build_vim
}

build_vim
