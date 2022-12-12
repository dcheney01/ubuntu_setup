#!/bin/sh

#Install ROS
echo_blue "Installing ROS Noetic for Ubuntu 20.04 based off of wiki.ros.org installation guide"

echo_blue "Setup your sources.list"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# this key could change if ROS ever updates it for whatever reason
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

sudo apt update
sudo apt install -y ros-noetic-desktop #-full

echo_blue "Initialize rosdep"

sudo apt install -y python3-rosdep
sudo rosdep init
rosdep update

echo_blue "Installing final dependencies"

sudo apt install -y python3-rosinstall python3-rosinstall-generator
sudo apt install -y ros-noetic-eigen-stl-containers
sudo apt-get install -y ros-noetic-rqt-multiplot
sudo apt-get install -y ros-noetic-rqt-ez-publisher

echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

echo_green "ROS Noetic installed and sourced"