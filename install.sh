#!/usr/bin/env bash

# TODO: build_opencv(), build_pcl(), build_tensorflow() ...

# general
LIBS_DIR="${HOME}/libs"
mkdir -p "${LIBS_DIR}"

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
    python2 /tmp/get-pip.py # TODO : upgrade myself to python3

    # misc (but important?)
    sudo apt install openssh-client openssh-server
    sudo apt install dtrx # unified decompression interface 

    # TODO : add other things if they come up
}

# python
build_py(){
    pip2 install -U pip
    sudo pip2 install setuptools
    pip2 install numpy --user --upgrade
    pip2 install scipy --user --upgrade # requires some deps? don't remember
    pip2 install sympy --user --upgrade
    pip2 install matplotlib --user --upgrade
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
    # build vim from source
    pushd "${LIBS_DIR}"
    git clone https://github.com/vim/vim.git
    ./configure --with-features=huge \
        --enable-pythoninterp=yes \
        --with-python-config-dir='/usr/lib/python2.7/config' \
        --enable-python3interp=yes \
        --with-python3-config-dir='/usr/lib/python3.5/config' \
        --enable-gui=gtk2 \
        --enable-cscope \
        --enable-terminal
    make -j8 VIMRUNTIMEDIR=/usr/local/share/vim/vim81
    sudo checkinstall 
    popd

    # vundle - plugins
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

    # youcompleteme : follow-up steps
    # may require the following steps:
    # sudo pip2 install --upgrade pyopenssl
    # sudo python -m easy_install --upgrade pyOpenSSL
    ~/.vim/bundle/YouCompleteMe/install.py --clang-completer
}

build(){
    build_sys
    build_py
    build_vim
}
