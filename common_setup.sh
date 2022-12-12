#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname $0 )" && pwd )"
SETUP_DIR="$( cd $SCRIPT_DIR/.. && pwd )"

# install color functions
sudo cp $SETUP_DIR/bin/color_functions/echo_* /usr/local/bin/
echo_green "Color functions installed"

echo_blue "installing common"

sudo apt update
sudo apt upgrade -y

# create my common folder structure
if [ ! -d ~/Documents/research ]; then mkdir ~/Documents/research; fi
if [ ! -d ~/Documents/software ]; then mkdir ~/Documents/software; fi



# terminal
sudo apt install -y curl ssh tmux gnome-tweaks

# C++
sudo apt install -y build-essential gcc g++ gcc-10 g++-10 cmake ccache make gdb
# set up compiler versions (last # is priority - highest is default)
# change compilers with `sudo update-alternatives --config <g++>`
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 10
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 10
echo_yellow "G++ compiler information:"
sudo update-alternatives --display g++

# Python
sudo apt install -y python3-dev 
sudo apt install -y pybind11-dev libtool libffi-dev
sudo apt-get install -y python3-pip
pip3 install numpy sympy scipy matplotlib
pip3 install control jupyter

# video viewers
sudo apt install -y vlc

# screenshot and screen recording
sudo apt install -y flameshot
sudo apt install -y kazam

# Install Visual Studio Code with Extensions
sudo snap install --classic code
# C/C++ extension
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cmake-tools
code --install-extension twxs.cmake

# Python extension
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
# Visual Studio Code

# Install Google Chrome
REQUIRED_PKG="google-chrome-stable"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome*.deb
fi

echo_green "common installed"

# set the timezone
sudo timedatectl set-timezone America/Denver
echo_green "timezone set to MDT"


sudo apt-get update
sudo apt autoremove -y